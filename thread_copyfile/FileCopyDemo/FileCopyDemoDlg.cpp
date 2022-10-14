// FileCopyDemoDlg.cpp : implementation file
//

#include "stdafx.h"
#include "FileCopyDemo.h"
#include "FileCopyDemoDlg.h"
#include <process.h>

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CAboutDlg dialog used for App About

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

// Dialog Data
	//{{AFX_DATA(CAboutDlg)
	enum { IDD = IDD_ABOUTBOX };
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CAboutDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	//{{AFX_MSG(CAboutDlg)
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
	//{{AFX_DATA_INIT(CAboutDlg)
	//}}AFX_DATA_INIT
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CAboutDlg)
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
	//{{AFX_MSG_MAP(CAboutDlg)
		// No message handlers
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CFileCopyDemoDlg dialog

CFileCopyDemoDlg::CFileCopyDemoDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CFileCopyDemoDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CFileCopyDemoDlg)
	m_strSrc = _T("");
	m_strDes = _T("");
	m_strInfo = _T("");
	m_strPercentage = _T("");
	m_strSpeed = _T("");
	m_bSync = TRUE;
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CFileCopyDemoDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CFileCopyDemoDlg)
	DDX_Control(pDX, IDC_EDIT_SPEED, m_editSpeed);
	DDX_Control(pDX, IDC_EDIT_PERCENTAGE, m_editPercentage);
	DDX_Control(pDX, IDC_PROGRESS_COPY, m_prgsCopy);
	DDX_Control(pDX, IDC_EDIT_INFO, m_editInfo);
	DDX_Text(pDX, IDC_EDIT_SRC, m_strSrc);
	DDX_Text(pDX, IDC_EDIT_DES, m_strDes);
	DDX_Text(pDX, IDC_EDIT_INFO, m_strInfo);
	DDX_Text(pDX, IDC_EDIT_PERCENTAGE, m_strPercentage);
	DDX_Text(pDX, IDC_EDIT_SPEED, m_strSpeed);
	DDX_Check(pDX, IDC_CHECK_SYNC, m_bSync);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CFileCopyDemoDlg, CDialog)
	//{{AFX_MSG_MAP(CFileCopyDemoDlg)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_BUTTON_SRC, OnButtonSrc)
	ON_BN_CLICKED(IDC_BUTTON_DES, OnButtonDes)
	ON_BN_CLICKED(IDC_BUTTON_PAUSE, OnButtonPause)
	ON_BN_CLICKED(IDC_BUTTON_CANCEL, OnButtonCancel)
	ON_BN_CLICKED(IDC_BUTTON_RESUME, OnButtonResume)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CFileCopyDemoDlg message handlers

BOOL CFileCopyDemoDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// Add "About..." menu item to system menu.

	// IDM_ABOUTBOX must be in the system command range.
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		CString strAboutMenu;
		strAboutMenu.LoadString(IDS_ABOUTBOX);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

	// Set the icon for this dialog.  The framework does this automatically
	//  when the application's main window is not a dialog
	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon
	
	// TODO: Add extra initialization here

	m_hCopyThread = NULL;
	
	return TRUE;  // return TRUE  unless you set the focus to a control
}

void CFileCopyDemoDlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialog::OnSysCommand(nID, lParam);
	}
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

void CFileCopyDemoDlg::OnPaint() 
{
	if (IsIconic())
	{
		CPaintDC dc(this); // device context for painting

		SendMessage(WM_ICONERASEBKGND, (WPARAM) dc.GetSafeHdc(), 0);

		// Center icon in client rectangle
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// Draw the icon
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

// The system calls this to obtain the cursor to display while the user drags
//  the minimized window.
HCURSOR CFileCopyDemoDlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}

void CFileCopyDemoDlg::OnButtonSrc() 
{
	// TODO: Add your control notification handler code here
	CFileDialog dlgFile(TRUE);
	if (IDOK != dlgFile.DoModal())
	{
		return ;
	}

	UpdateData(TRUE);
	m_strSrc = dlgFile.GetPathName();
	UpdateData(FALSE);
}

void CFileCopyDemoDlg::OnButtonDes() 
{
	// TODO: Add your control notification handler code here
	CFileDialog dlgFile(FALSE);
	if (IDOK != dlgFile.DoModal())
	{
		return ;
	}
	
	UpdateData(TRUE);
	m_strDes = dlgFile.GetPathName();
	UpdateData(FALSE);
}

BOOL __stdcall CopingProgressCB(
	const void * const pUserData,
	const DOUBLE dbSpeed,
	const DWORD dwPercentage
)
{
	CFileCopyDemoDlg *pDlg = (CFileCopyDemoDlg *)pUserData;
	if (NULL == pDlg)
	{
		return TRUE;
	}

	DOUBLE dbSpeedInSec = dbSpeed * 1000;
	if (dbSpeedInSec > 1024 * 1024)
	{
		dbSpeedInSec /= 1024 * 1024;
		pDlg->m_strSpeed.Format(_T("%.2lfMB/S"), dbSpeedInSec);
	}
	else if (dbSpeedInSec > 1024)
	{
		dbSpeedInSec /= 1024;
		pDlg->m_strSpeed.Format(_T("%.2lfKB/S"), dbSpeedInSec);
	}
	else
	{
		pDlg->m_strSpeed.Format(_T("%.2lfByte/S"), dbSpeedInSec);
	}
	pDlg->m_editSpeed.SetWindowText(pDlg->m_strSpeed);
	pDlg->m_strPercentage.Format(_T("%d%%"), dwPercentage);
	pDlg->m_editPercentage.SetWindowText(pDlg->m_strPercentage);

	pDlg->m_prgsCopy.SetPos(dwPercentage);

	return TRUE;
}

BOOL __stdcall AsyncCopyResultCB(
	const void * const pUserData,
	const BOOL bCopySuccess,
	const DOUBLE dbSpeed,
	const tstring strErrorMsg
)
{
	CFileCopyDemoDlg *pDlg = (CFileCopyDemoDlg *)pUserData;
	if (NULL == pDlg)
	{
		return TRUE;
	}

	CString strMsg;
	if (bCopySuccess)
	{
		CString strSpeed;
		DOUBLE dbSpeedInSec = dbSpeed * 1000;
		if (dbSpeedInSec > 1024 * 1024)
		{
			dbSpeedInSec /= 1024 * 1024;
			strSpeed.Format(_T("%.2lfMB/S"), dbSpeedInSec);
		}
		else if (dbSpeedInSec > 1024)
		{
			dbSpeedInSec /= 1024;
			strSpeed.Format(_T("%.2lfKB/S"), dbSpeedInSec);
		}
		else
		{
			strSpeed.Format(_T("%.2lfByte/S"), dbSpeedInSec);
		}

		pDlg->m_prgsCopy.SetPos(100);
		pDlg->m_strPercentage.Format(_T("%d%%"), 100);
		pDlg->m_strSpeed.Empty();	
		strMsg.Format(_T("Asynchronous Copy Success, Speed = %s.\r\n"), strSpeed);
	}
	else
	{
		pDlg->m_prgsCopy.SetPos(0);
		pDlg->m_strPercentage.Format(_T("%d%%"), 0);
		pDlg->m_strSpeed.Empty();
		strMsg.Format(_T("Asynchronous Copy Fail : %s\r\n"), strErrorMsg.c_str());
	}

	pDlg->m_editSpeed.SetWindowText(pDlg->m_strSpeed);
	pDlg->m_editPercentage.SetWindowText(pDlg->m_strPercentage);

	pDlg->m_strInfo += strMsg;
	pDlg->m_editInfo.SetWindowText(pDlg->m_strInfo);
	pDlg->m_editInfo.SetSel(pDlg->m_strInfo.GetLength(), pDlg->m_strInfo.GetLength());

	return TRUE;
}

unsigned __stdcall SyncCopyThreadFunc(void* pArguments)  
{  
    CFileCopyDemoDlg *pThis = (CFileCopyDemoDlg *)pArguments;  
    if (NULL == pThis)  
    {  
        _endthreadex (1);  
        return 1;  
    }  
      
	tstring strErrMsg;
	DOUBLE dbSpeed = 0.0;
	BOOL bRet = pThis->m_filecopy.CopyFile(
		pThis->m_strSrc, 
		pThis->m_strDes, 
		TRUE, 
		1000, 
		dbSpeed, 
		strErrMsg
		);

	CString strMsg;
	if (bRet)
	{
		CString strSpeed;
		DOUBLE dbSpeedInSec = dbSpeed * 1000;
		if (dbSpeedInSec > 1024 * 1024)
		{
			dbSpeedInSec /= 1024 * 1024;
			strSpeed.Format(_T("%.2lfMB/S"), dbSpeedInSec);
		}
		else if (dbSpeedInSec > 1024)
		{
			dbSpeedInSec /= 1024;
			strSpeed.Format(_T("%.2lfKB/S"), dbSpeedInSec);
		}
		else
		{
			strSpeed.Format(_T("%.2lfByte/S"), dbSpeedInSec);
		}
		
		pThis->m_prgsCopy.SetPos(100);
		pThis->m_strPercentage.Format(_T("%d%%"), 100);
		pThis->m_strSpeed.Empty();	
		strMsg.Format(_T("Synchronous Copy Success, Speed = %s.\r\n"), strSpeed);
	}
	else
	{
		pThis->m_prgsCopy.SetPos(0);
		pThis->m_strPercentage.Format(_T("%d%%"), 0);
		pThis->m_strSpeed.Empty();
		strMsg.Format(_T("Synchronous Copy Fail : %s\r\n"), strErrMsg.c_str());
	}

	pThis->m_editSpeed.SetWindowText(pThis->m_strSpeed);
	pThis->m_editPercentage.SetWindowText(pThis->m_strPercentage);
	
	pThis->m_strInfo += strMsg;
	pThis->m_editInfo.SetWindowText(pThis->m_strInfo);
	pThis->m_editInfo.SetSel(pThis->m_strInfo.GetLength(), pThis->m_strInfo.GetLength());

	CloseHandle(pThis->m_hCopyThread);
	pThis->m_hCopyThread = NULL;

    return 1;  
}

void CFileCopyDemoDlg::OnOK() 
{
	// TODO: Add extra validation here
	
	UpdateData(TRUE);

	m_filecopy.SetUserData(this);
	m_filecopy.SetCopingProgressCB(CopingProgressCB);
	m_filecopy.SetAsyncCopyResultCB(AsyncCopyResultCB);

	unsigned threadID = 0;
	if (m_bSync)
	{
		if (NULL != m_hCopyThread)
		{
			CString strMsg;
			strMsg.Format(_T("Synchronous Copy Fail : In coping.\r\n"));
			m_strInfo += strMsg;
		}
		else
		{
			m_hCopyThread =   
				(HANDLE)_beginthreadex(NULL, 0, &SyncCopyThreadFunc, this, 0, &threadID);  
			if (NULL == m_hCopyThread)  
			{
				CString strMsg;
				strMsg.Format(_T("Create Synchronous Copy Thread Fail.\r\n"));
				m_strInfo += strMsg;
			}
			else
			{
				CString strMsg;
				strMsg.Format(_T("Create Synchronous Copy Thread Success.\r\n"));
				m_strInfo += strMsg;
			}
		}
	}
	else
	{
		tstring strErrMsg;
		DOUBLE dbSpeed = 0.0;
		BOOL bRet = m_filecopy.CopyFile(m_strSrc, m_strDes, m_bSync, 1000, dbSpeed, strErrMsg);
		if (bRet)
		{
			CString strMsg;
			strMsg.Format(_T("Send Asynchronous Copy Success.\r\n"));
			m_strInfo += strMsg;
		}
		else
		{
			CString strMsg;
			strMsg.Format(_T("Send Asynchronous Copy Fail : %s\r\n"), strErrMsg.c_str());
			m_strInfo += strMsg;
		}
	}

	UpdateData(FALSE);
	m_editInfo.SetSel(m_strInfo.GetLength(), m_strInfo.GetLength());
	

	//CDialog::OnOK();
}

void CFileCopyDemoDlg::OnButtonPause() 
{
	// TODO: Add your control notification handler code here
	m_filecopy.Pause();
}

void CFileCopyDemoDlg::OnButtonCancel() 
{
	// TODO: Add your control notification handler code here
	m_filecopy.Cancel();
}

void CFileCopyDemoDlg::OnCancel() 
{
	// TODO: Add extra cleanup here
	
	CDialog::OnCancel();
}

void CFileCopyDemoDlg::OnButtonResume() 
{
	// TODO: Add your control notification handler code here
	m_filecopy.Resume();
}
