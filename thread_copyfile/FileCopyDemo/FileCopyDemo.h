// FileCopyDemo.h : main header file for the FILECOPYDEMO application
//

#if !defined(AFX_FILECOPYDEMO_H__151506A3_6FD8_46C9_BA75_DEFFA3614E1E__INCLUDED_)
#define AFX_FILECOPYDEMO_H__151506A3_6FD8_46C9_BA75_DEFFA3614E1E__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols

/////////////////////////////////////////////////////////////////////////////
// CFileCopyDemoApp:
// See FileCopyDemo.cpp for the implementation of this class
//

class CFileCopyDemoApp : public CWinApp
{
public:
	CFileCopyDemoApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CFileCopyDemoApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CFileCopyDemoApp)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_FILECOPYDEMO_H__151506A3_6FD8_46C9_BA75_DEFFA3614E1E__INCLUDED_)
