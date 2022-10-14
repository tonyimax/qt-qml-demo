// FileCopyDemoDlg.h : header file
//

#if !defined(AFX_FILECOPYDEMODLG_H__3FFE401C_B7F1_4E8C_9863_3570DBF74B33__INCLUDED_)
#define AFX_FILECOPYDEMODLG_H__3FFE401C_B7F1_4E8C_9863_3570DBF74B33__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "FileCopy.h"

/////////////////////////////////////////////////////////////////////////////
// CFileCopyDemoDlg dialog

class CFileCopyDemoDlg : public CDialog
{
// Construction
public:
	CFileCopyDemoDlg(CWnd* pParent = NULL);	// standard constructor

// Dialog Data
	//{{AFX_DATA(CFileCopyDemoDlg)
	enum { IDD = IDD_FILECOPYDEMO_DIALOG };
	CEdit	m_editSpeed;
	CEdit	m_editPercentage;
	CProgressCtrl	m_prgsCopy;
	CEdit	m_editInfo;
	CString	m_strSrc;
	CString	m_strDes;
	CString	m_strInfo;
	CString	m_strPercentage;
	CString	m_strSpeed;
	BOOL	m_bSync;
	//}}AFX_DATA

    CFileCopy m_filecopy;
	HANDLE m_hCopyThread;

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CFileCopyDemoDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CFileCopyDemoDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void OnButtonSrc();
	afx_msg void OnButtonDes();
	virtual void OnOK();
	afx_msg void OnButtonPause();
	afx_msg void OnButtonCancel();
	virtual void OnCancel();
	afx_msg void OnButtonResume();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_FILECOPYDEMODLG_H__3FFE401C_B7F1_4E8C_9863_3570DBF74B33__INCLUDED_)
