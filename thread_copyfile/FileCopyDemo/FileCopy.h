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

// 异步复制时，复制完后会回调
// pUserData : CFileCopy::SetUserData()设置的值
// bCopySuccess : 复制是否成功
// dbSpeed : 若复制成功，保存平均速度，单位Byte/MS（字节/毫秒）
// strErrorMsg : 若复制失败，保存失败信息
typedef BOOL (__stdcall * LPAsyncCopyResultCB)(
    const void * const pUserData,
    const BOOL bCopySuccess,
	const DOUBLE dbSpeed,
    const tstring strErrorMsg
);

// 复制过程中，定义回调返回进度等
// pUserData : CFileCopy::SetUserData()设置的值
// dbSpeed : 复制速度，单位Byte/MS（字节/毫秒）
// dwPercentage : 复制百分比
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
    // 同步复制返回值表示是否复制成功
    // 异步复制表示发起复制是否成功
	BOOL CopyFile(
		IN LPCTSTR lpSrcFileName,       // 源文件名
		IN LPCTSTR lpDesFileName,       // 目标文件名
        IN const BOOL bSynchronousCopy, // 是否同步复制
		IN const DWORD dwProgressFeedbackTime,
										// 复制过程中反馈进度间隔时长，单位毫秒，0不反馈
		OUT DOUBLE &dbSpeed,			// 若复制成功，保存平均速度，单位Byte/MS（字节/毫秒）
        OUT tstring &strErrorMsg        // 复制失败原因
		);

    void Pause();   // 暂停
    void Resume();  // 恢复
    void Cancel();  // 取消

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
    // 同步复制文件
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

	// 异步复制线程
    unsigned AsyncCopy();  
    static unsigned __stdcall AsyncCopyThreadFunc(void* pArguments); 
	
	// 反馈进度线程
	unsigned FeedbackProgress();  
    static unsigned __stdcall FeedbackProgressThreadFunc(void* pArguments);

protected:
    BOOL m_bCancel;                         // 是否取消复制标志
    DWORD64 m_dw64TotalFileSize;            // 文件总大小
    DWORD64 m_dw64TotalBytesTransferred;    // 已复制的大小
    CRITICAL_SECTION m_csLock;              // 用于同步的CS
    BOOL m_bIsCoping;                       // 是否处于复制中
    HANDLE m_hPauseEvent;                   // 控件复制暂停恢复的事件
	HANDLE m_hFeedbackExitEvent;            // 反馈进度线程退出事件
    HANDLE m_hAsyncCopyThreadHandle;        // 异步复制线程句柄
	HANDLE m_hFeedbackProgressThreadHandle; // 反馈进度线程句柄
    tstring m_strSrcFile;                   // 源文件名
    tstring m_strDesFile;                   // 目标文件名
	DWORD m_dwProgressFeedbackTime;			// 复制过程中反馈进度间隔时长，单位毫秒，0不反馈
    void *m_pUserData;                      // 异步回调时会使用
    LPAsyncCopyResultCB m_pAsyncCopyResultCB;
                                            // 异步复制回调
	LPCopingProgressCB m_pCopingProgressCB;	// 复制过程中定时回调返回进度等
};

#endif // !defined(AFX_FILECOPY_H__061C1E4E_649D_4AF3_8950_69452B3909CA__INCLUDED_)
