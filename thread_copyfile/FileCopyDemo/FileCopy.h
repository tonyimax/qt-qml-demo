// FileCopy.h: interface for the CFileCopy class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_FILECOPY_H__061C1E4E_649D_4AF3_8950_69452B3909CA__INCLUDED_)
#define AFX_FILECOPY_H__061C1E4E_649D_4AF3_8950_69452B3909CA__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include <string>

#if (defined UNICODE) || (defined _UNICODE)  
#define tstring std::wstring  
#else  
#define tstring std::string  
#endif 

// �첽����ʱ����������ص�
// pUserData : CFileCopy::SetUserData()���õ�ֵ
// bCopySuccess : �����Ƿ�ɹ�
// dbSpeed : �����Ƴɹ�������ƽ���ٶȣ���λByte/MS���ֽ�/���룩
// strErrorMsg : ������ʧ�ܣ�����ʧ����Ϣ
typedef BOOL (__stdcall * LPAsyncCopyResultCB)(
    const void * const pUserData,
    const BOOL bCopySuccess,
	const DOUBLE dbSpeed,
    const tstring strErrorMsg
);

// ���ƹ����У�����ص����ؽ��ȵ�
// pUserData : CFileCopy::SetUserData()���õ�ֵ
// dbSpeed : �����ٶȣ���λByte/MS���ֽ�/���룩
// dwPercentage : ���ưٷֱ�
typedef BOOL (__stdcall * LPCopingProgressCB)(
	const void * const pUserData,
	const DOUBLE dbSpeed,
	const DWORD dwPercentage
);

class CFileCopy  
{
public:
	CFileCopy();
	virtual ~CFileCopy();

public:
    // ͬ�����Ʒ���ֵ��ʾ�Ƿ��Ƴɹ�
    // �첽���Ʊ�ʾ�������Ƿ�ɹ�
	BOOL CopyFile(
		IN LPCTSTR lpSrcFileName,       // Դ�ļ���
		IN LPCTSTR lpDesFileName,       // Ŀ���ļ���
        IN const BOOL bSynchronousCopy, // �Ƿ�ͬ������
		IN const DWORD dwProgressFeedbackTime,
										// ���ƹ����з������ȼ��ʱ������λ���룬0������
		OUT DOUBLE &dbSpeed,			// �����Ƴɹ�������ƽ���ٶȣ���λByte/MS���ֽ�/���룩
        OUT tstring &strErrorMsg        // ����ʧ��ԭ��
		);

    void Pause();   // ��ͣ
    void Resume();  // �ָ�
    void Cancel();  // ȡ��

    DWORD64 GetTotalFileSize()
    {
        return m_dw64TotalFileSize;
    }

    DWORD64 GetTotalBytesTransferred()
    {
        return m_dw64TotalBytesTransferred;
    }

    void SetUserData(void *pUserData)  
    {  
        m_pUserData = pUserData;  
    }

	void SetAsyncCopyResultCB(LPAsyncCopyResultCB pAsyncCopyResultCB)
	{
		m_pAsyncCopyResultCB = pAsyncCopyResultCB;
	}

	void SetCopingProgressCB(LPCopingProgressCB pCopingProgressCB)
	{
		m_pCopingProgressCB = pCopingProgressCB;
	}

protected:
    // ͬ�������ļ�
    BOOL SynchronousCopyFile(
		LPCTSTR lpSrcFileName, 
		LPCTSTR lpDesFileName, 
		const DWORD dwProgressFeedbackTime,
		DOUBLE &dbSpeed, 
		tstring &strErrorMsg);
    
    tstring GetLastErrorMsg(LPCTSTR lpszFunction, const DWORD dwLastError);

    static DWORD CALLBACK CopyProgressRoutine(
        LARGE_INTEGER TotalFileSize,
        LARGE_INTEGER TotalBytesTransferred,
        LARGE_INTEGER StreamSize,
        LARGE_INTEGER StreamBytesTransferred,
        DWORD dwStreamNumber,
        DWORD dwCallbackReason,
        HANDLE hSourceFile,
        HANDLE hDestinationFile,
        LPVOID lpData
        );

    void CloseAllHandles();

	// �첽�����߳�
    unsigned AsyncCopy();  
    static unsigned __stdcall AsyncCopyThreadFunc(void* pArguments); 
	
	// ���������߳�
	unsigned FeedbackProgress();  
    static unsigned __stdcall FeedbackProgressThreadFunc(void* pArguments);

protected:
    BOOL m_bCancel;                         // �Ƿ�ȡ�����Ʊ�־
    DWORD64 m_dw64TotalFileSize;            // �ļ��ܴ�С
    DWORD64 m_dw64TotalBytesTransferred;    // �Ѹ��ƵĴ�С
    CRITICAL_SECTION m_csLock;              // ����ͬ����CS
    BOOL m_bIsCoping;                       // �Ƿ��ڸ�����
    HANDLE m_hPauseEvent;                   // �ؼ�������ͣ�ָ����¼�
	HANDLE m_hFeedbackExitEvent;            // ���������߳��˳��¼�
    HANDLE m_hAsyncCopyThreadHandle;        // �첽�����߳̾��
	HANDLE m_hFeedbackProgressThreadHandle; // ���������߳̾��
    tstring m_strSrcFile;                   // Դ�ļ���
    tstring m_strDesFile;                   // Ŀ���ļ���
	DWORD m_dwProgressFeedbackTime;			// ���ƹ����з������ȼ��ʱ������λ���룬0������
    void *m_pUserData;                      // �첽�ص�ʱ��ʹ��
    LPAsyncCopyResultCB m_pAsyncCopyResultCB;
                                            // �첽���ƻص�
	LPCopingProgressCB m_pCopingProgressCB;	// ���ƹ����ж�ʱ�ص����ؽ��ȵ�
};

#endif // !defined(AFX_FILECOPY_H__061C1E4E_649D_4AF3_8950_69452B3909CA__INCLUDED_)
