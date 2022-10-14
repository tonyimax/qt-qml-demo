// FileCopy.cpp: implementation of the CFileCopy class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "FileCopyDemo.h"
#include "FileCopy.h"

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

#include <Windows.h>
#include <strsafe.h>
#include <process.h>

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

class CAutoLock  
{  
private:  
    LPCRITICAL_SECTION m_pcsLcok;  
    
public:  
    CAutoLock(LPCRITICAL_SECTION pcsLcok)  
    {  
        m_pcsLcok = pcsLcok;  
        if (m_pcsLcok)  
        {  
            EnterCriticalSection(m_pcsLcok);  
        }  
    }  
    
    ~CAutoLock()  
    {  
        if (m_pcsLcok)  
        {  
            LeaveCriticalSection(m_pcsLcok);  
            m_pcsLcok = NULL;  
        }  
    }  
};  

class CStopwatch
{
public:
	CStopwatch()
	{
		QueryPerformanceFrequency(&m_liPerfFreq);
		Start();
	}
	
	void Start()
	{
		QueryPerformanceCounter(&m_liPerfStart);
	}
	
	__int64 Now() const
	{
		LARGE_INTEGER liPerfNow;
		QueryPerformanceCounter(&liPerfNow);
		
		return (liPerfNow.QuadPart - m_liPerfStart.QuadPart) * 1000 / m_liPerfFreq.QuadPart;
	}
	
	__int64 NowInMicro() const
	{
		LARGE_INTEGER liPerfNow;
		QueryPerformanceCounter(&liPerfNow);
		
		return (liPerfNow.QuadPart - m_liPerfStart.QuadPart) * 1000000 / m_liPerfFreq.QuadPart;
	}
private:
	LARGE_INTEGER m_liPerfFreq;		//counter per second
	LARGE_INTEGER m_liPerfStart;	//starting count
};

CFileCopy::CFileCopy()
{
    m_bCancel = FALSE;
    m_dw64TotalFileSize = 0;
    m_dw64TotalBytesTransferred = 0;
    m_bIsCoping = FALSE;
    m_hPauseEvent = NULL;
	m_hFeedbackExitEvent = NULL;
    m_hAsyncCopyThreadHandle = NULL;
	m_hFeedbackProgressThreadHandle = NULL;
    m_pUserData = NULL;
    m_pAsyncCopyResultCB = NULL;
	m_pCopingProgressCB = NULL;
	m_dwProgressFeedbackTime = 0;
    InitializeCriticalSection(&m_csLock);
}

CFileCopy::~CFileCopy()
{
    Cancel();
    DeleteCriticalSection(&m_csLock);
}

BOOL CFileCopy::CopyFile(IN LPCTSTR lpSrcFileName,
                         IN LPCTSTR lpDesFileName,
                         IN const BOOL bSynchronousCopy,
						 IN const DWORD dwProgressFeedbackTime,
						 OUT DOUBLE &dbSpeed,
                         OUT tstring &strErrorMsg)
{
    {  
        CAutoLock autolock(&m_csLock);  
        if (m_bIsCoping)  
        {  
            strErrorMsg = _T("In coping.");  
            return FALSE;  
        }  
        m_bIsCoping = TRUE;  
    }  

    // 同步复制
    if (bSynchronousCopy)
    {
		m_dwProgressFeedbackTime = dwProgressFeedbackTime;
        BOOL bRet = SynchronousCopyFile(
			lpSrcFileName, 
			lpDesFileName, 
			dwProgressFeedbackTime, 
			dbSpeed, 
			strErrorMsg
			);
        m_bIsCoping = FALSE;
        return bRet;
    }

    // 异步复制
    m_strSrcFile = lpSrcFileName;
    m_strDesFile = lpDesFileName;
	m_dwProgressFeedbackTime = dwProgressFeedbackTime;

    unsigned threadID = 0;
    m_hAsyncCopyThreadHandle =   
        (HANDLE)_beginthreadex(NULL, 0, &AsyncCopyThreadFunc, this, 0, &threadID);  
    if (NULL == m_hAsyncCopyThreadHandle)  
    {  
        strErrorMsg = GetLastErrorMsg(_T("_beginthreadex"), GetLastError());  
        return FALSE;  
    }  

    return TRUE;
}

BOOL CFileCopy::SynchronousCopyFile(LPCTSTR lpSrcFileName, 
                                    LPCTSTR lpDesFileName, 
									const DWORD dwProgressFeedbackTime,
									DOUBLE &dbSpeed,
                                    tstring &strErrorMsg)
{
    m_bCancel = FALSE;
    m_dw64TotalFileSize = 0;
    m_dw64TotalBytesTransferred = 0;

    if (NULL == (m_hPauseEvent = CreateEvent(NULL, TRUE, TRUE, NULL)))
    {
        strErrorMsg = GetLastErrorMsg(_T("CreateEvent"), GetLastError());
        return FALSE;
    }

	if (0 != dwProgressFeedbackTime)
	{
		if (NULL == (m_hFeedbackExitEvent = CreateEvent(NULL, TRUE, FALSE, NULL)))
		{
			strErrorMsg = GetLastErrorMsg(_T("CreateEvent"), GetLastError());
			CloseAllHandles();
			return FALSE;
		}

		unsigned threadID = 0;
		m_hFeedbackProgressThreadHandle =   
			(HANDLE)_beginthreadex(NULL, 0, &FeedbackProgressThreadFunc, this, 0, &threadID);  
		if (NULL == m_hFeedbackProgressThreadHandle)  
		{  
			strErrorMsg = GetLastErrorMsg(_T("_beginthreadex"), GetLastError()); 
			CloseAllHandles();
			return FALSE;
		}
	}

	CStopwatch stopwatch;

    BOOL bRet = CopyFileEx(lpSrcFileName,
        lpDesFileName,
        CopyProgressRoutine,
        this,
        &m_bCancel,
        COPY_FILE_ALLOW_DECRYPTED_DESTINATION | COPY_FILE_FAIL_IF_EXISTS);
    if (!bRet)
    {
        strErrorMsg = GetLastErrorMsg(_T("CopyFileEx"), GetLastError());
    }
	else
	{
		// 成功了才需计算速度
		__int64 n64ElapseTimeInMs = stopwatch.Now();
		dbSpeed = (DOUBLE)(__int64)m_dw64TotalFileSize / n64ElapseTimeInMs;
	}

	if (0 != dwProgressFeedbackTime)
	{
		SetEvent(m_hFeedbackExitEvent);
		WaitForSingleObject(m_hFeedbackProgressThreadHandle, INFINITE);
	}
	
    CloseAllHandles();
	
    return bRet;
}

DWORD CALLBACK CFileCopy::CopyProgressRoutine( 
	LARGE_INTEGER TotalFileSize, 
	LARGE_INTEGER TotalBytesTransferred, 
	LARGE_INTEGER StreamSize, 
	LARGE_INTEGER StreamBytesTransferred, 
	DWORD dwStreamNumber, 
    DWORD dwCallbackReason, 
    HANDLE hSourceFile, 
    HANDLE hDestinationFile, 
    LPVOID lpData 
	)
{
    CFileCopy *pFileCopy = (CFileCopy *)lpData;
    if (!pFileCopy)
    {
        return PROGRESS_CANCEL;
    }

    pFileCopy->m_dw64TotalFileSize = TotalFileSize.QuadPart;
    pFileCopy->m_dw64TotalBytesTransferred = TotalBytesTransferred.QuadPart;

    // 用于控制暂停
    WaitForSingleObject(pFileCopy->m_hPauseEvent, INFINITE); 

    return PROGRESS_CONTINUE;
}

tstring CFileCopy::GetLastErrorMsg(LPCTSTR lpszFunction, const DWORD dwLastError)  
{  
    LPVOID lpMsgBuf = NULL;  
    LPVOID lpDisplayBuf = NULL;  
    
    FormatMessage(  
        FORMAT_MESSAGE_ALLOCATE_BUFFER |   
        FORMAT_MESSAGE_FROM_SYSTEM |  
        FORMAT_MESSAGE_IGNORE_INSERTS,  
        NULL,  
        dwLastError,  
        MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),  
        (LPTSTR) &lpMsgBuf,  
        0, NULL );  
    
    lpDisplayBuf = (LPVOID)LocalAlloc(LMEM_ZEROINIT,   
        (lstrlen((LPCTSTR)lpMsgBuf)+lstrlen((LPCTSTR)lpszFunction)+40)*sizeof(TCHAR));   
    StringCchPrintf((LPTSTR)lpDisplayBuf,   
        LocalSize(lpDisplayBuf) / sizeof(TCHAR),  
        TEXT("%s failed with error %d: %s"),   
        lpszFunction, dwLastError, lpMsgBuf);   
    
    tstring strLastError = (LPTSTR)lpDisplayBuf;  
    
    LocalFree(lpMsgBuf);  
    LocalFree(lpDisplayBuf);  
    
    return strLastError;  
}  

void CFileCopy::CloseAllHandles()
{
    if (m_hPauseEvent)
    {
        CloseHandle(m_hPauseEvent);
        m_hPauseEvent = NULL;
    }
	if (m_hFeedbackExitEvent)
    {
        CloseHandle(m_hFeedbackExitEvent);
        m_hFeedbackExitEvent = NULL;
    }
    if (m_hAsyncCopyThreadHandle)  
    {  
        CloseHandle(m_hAsyncCopyThreadHandle);  
        m_hAsyncCopyThreadHandle = NULL;  
    }  
	if (m_hFeedbackProgressThreadHandle)  
    {  
        CloseHandle(m_hFeedbackProgressThreadHandle);  
        m_hFeedbackProgressThreadHandle = NULL;  
    }  
}

void CFileCopy::Pause()
{
    if (m_hPauseEvent)
    {
        ResetEvent(m_hPauseEvent);
    }
}

void CFileCopy::Resume()
{
    if (m_hPauseEvent)
    {
        SetEvent(m_hPauseEvent);
    } 
}

void CFileCopy::Cancel()
{
    m_bCancel = TRUE;
    Resume();
}

unsigned CFileCopy::AsyncCopy()  
{  
    unsigned usRet = 1;  
    
	DOUBLE dbSpeed = 0.0;
    tstring strErrorMsg;  
    
    BOOL bCopySuccess = SynchronousCopyFile(
        m_strSrcFile.c_str(),
        m_strDesFile.c_str(),
		m_dwProgressFeedbackTime,
		dbSpeed,
        strErrorMsg
        );
    if (m_pAsyncCopyResultCB)  
    {  
        m_pAsyncCopyResultCB(m_pUserData, bCopySuccess, dbSpeed, strErrorMsg);
    }  
    m_bIsCoping = FALSE;  
    
    return usRet;
}  

unsigned CFileCopy::AsyncCopyThreadFunc(void* pArguments)  
{  
    CFileCopy *pThis = (CFileCopy *)pArguments;  
    if (NULL == pThis)  
    {  
        _endthreadex (1);  
        return 1;  
    }  
    
    unsigned usRet = pThis->AsyncCopy();  
    _endthreadex (usRet);  
    return usRet;  
}  

unsigned CFileCopy::FeedbackProgress()  
{  
    unsigned usRet = 1;

	DWORD64 dw64TotalBytesTransferred = 0;
	DWORD64 dw64TotalBytesTransferredBak = 0;
	DOUBLE dbSpeed = 0.0;
	DWORD dwPercentage = 0;
	__int64 n64ElapseTimeInMs = 0;
	__int64 n64UsedTimeInMs = 0;
	__int64 n64NowInMs = 0;

	CStopwatch stopwatch;

	while (WAIT_TIMEOUT == WaitForSingleObject(m_hFeedbackExitEvent, m_dwProgressFeedbackTime))
	{	
		n64NowInMs = stopwatch.Now();
		dw64TotalBytesTransferred = m_dw64TotalBytesTransferred;
		n64ElapseTimeInMs = n64NowInMs - n64UsedTimeInMs;
		n64UsedTimeInMs = n64NowInMs;
		if (0 == n64ElapseTimeInMs)
		{
			dbSpeed = 0.0;
		}
		else
		{
			dbSpeed = (DOUBLE)(__int64)(dw64TotalBytesTransferred - dw64TotalBytesTransferredBak) 
				/ n64ElapseTimeInMs;
		}
		dw64TotalBytesTransferredBak = dw64TotalBytesTransferred;
		
		if (0 == m_dw64TotalFileSize)
		{
			dwPercentage = 0;
		}
		else
		{
			dwPercentage = m_dw64TotalBytesTransferred * 100 / m_dw64TotalFileSize;
		}
		if (m_pCopingProgressCB)
		{
			m_pCopingProgressCB(m_pUserData, dbSpeed, dwPercentage);
		}
	}
    
    return usRet;
}  

unsigned CFileCopy::FeedbackProgressThreadFunc(void* pArguments)  
{  
    CFileCopy *pThis = (CFileCopy *)pArguments;  
    if (NULL == pThis)  
    {  
        _endthreadex (1);  
        return 1;  
    }  
    
    unsigned usRet = pThis->FeedbackProgress();  
    _endthreadex (usRet);  
    return usRet;  
}  