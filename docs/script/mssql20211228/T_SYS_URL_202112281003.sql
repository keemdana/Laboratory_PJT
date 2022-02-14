INSERT INTO DBD_TEST.dbo.T_SYS_URL (ACCES_URL,URL_DESC,ALW_DIV,USE_YN,REG_DTE,REG_LOGIN_ID,UPT_DTE,UPT_LOGIN_ID) VALUES
	 (N'/',N'루트경로',N'IS_AUTHENTICATED_FULLY',N'Y','2021-04-09',N'SYSTEM','2021-12-24',N'ADMIN'),
	 (N'/cmm/particle',N'공용파티클',N'IS_AUTHENTICATED_FULLY',N'Y','2021-05-24',N'ADMIN','2021-05-24',N'ADMIN'),
	 (N'/login.do',N'로그인 폼',N'IS_AUTHENTICATED_ANONYMOUSLY',N'Y','2021-04-09',N'SYSTEM','2021-04-09',N'SYSTEM'),
	 (N'/login/proc',N'로그인 처리',N'IS_AUTHENTICATED_ANONYMOUSLY',N'Y','2021-04-09',N'SYSTEM','2021-04-09',N'SYSTEM'),
	 (N'/logout',N'로그아웃',N'IS_AUTHENTICATED_FULLY',N'Y','2021-04-09',N'SYSTEM','2021-04-09',N'SYSTEM'),
	 (N'/main',N'메인페이지 관련',N'IS_AUTHENTICATED_FULLY',N'Y','2021-04-30',N'ADMIN','2021-04-30',N'ADMIN'),
	 (N'/main/main',N'메인 페이지 js',N'IS_AUTHENTICATED_FULLY',N'Y','2021-04-09',N'SYSTEM','2021-04-09',N'SYSTEM'),
	 (N'/paragon/aprv/aprv',N'결재관련',N'IS_AUTHENTICATED_FULLY',N'Y','2021-06-10',N'ADMIN','2021-06-10',N'ADMIN'),
	 (N'/paragon/bbs/bbsList',N'공통게시판',N'IS_AUTHENTICATED_FULLY',N'Y','2021-04-15',N'ADMIN','2021-04-15',N'ADMIN'),
	 (N'/paragon/bbs/bbsMas',N'게시판 서비스',N'IS_AUTHENTICATED_FULLY',N'Y','2021-07-26',N'ADMIN','2021-07-26',N'ADMIN');
INSERT INTO DBD_TEST.dbo.T_SYS_URL (ACCES_URL,URL_DESC,ALW_DIV,USE_YN,REG_DTE,REG_LOGIN_ID,UPT_DTE,UPT_LOGIN_ID) VALUES
	 (N'/paragon/bbs/bbsMas/bbsMasView/json',N'공통게시판 뷰 서비스',N'IS_AUTHENTICATED_FULLY',N'Y','2021-06-24',N'ADMIN','2021-06-24',N'ADMIN'),
	 (N'/paragon/bbs/bbsMasView',N'게시판 게시물 보기 서비스',N'IS_AUTHENTICATED_FULLY',N'Y','2021-07-26',N'ADMIN','2021-07-26',N'ADMIN'),
	 (N'/paragon/bbs/bbsWrite',N'공통게시판 - 작성',N'IS_AUTHENTICATED_FULLY',N'Y','2021-06-24',N'ADMIN','2021-06-24',N'ADMIN'),
	 (N'/paragon/cmm',N'공용',N'IS_AUTHENTICATED_FULLY',N'Y','2021-06-10',N'ADMIN','2021-06-10',N'ADMIN'),
	 (N'/paragon/file',N'첨부파일 모듈',N'IS_AUTHENTICATED_FULLY',N'Y','2021-06-08',N'ADMIN','2021-06-08',N'ADMIN'),
	 (N'/paragon/hr/deptMng/deptList',N'부서리스트 서비스',N'IS_AUTHENTICATED_FULLY',N'Y','2021-05-11',N'ADMIN','2021-05-11',N'ADMIN'),
	 (N'/paragon/hr/hrAprvTreeInfo',N'결재선 서비스',N'IS_AUTHENTICATED_FULLY',N'Y','2021-06-10',N'ADMIN','2021-06-10',N'ADMIN'),
	 (N'/paragon/hr/hrMng',N'인사정보 조회',N'IS_AUTHENTICATED_FULLY',N'Y','2021-08-19',N'ADMIN','2021-08-19',N'ADMIN'),
	 (N'/paragon/hr/hrUserTreeInfo',N'사용자 트리',N'IS_AUTHENTICATED_FULLY',N'Y','2021-09-13',N'ADMIN','2021-09-13',N'ADMIN'),
	 (N'/pw',N'암호변경',N'IS_AUTHENTICATED_FULLY',N'Y','2021-04-09',N'SYSTEM','2021-04-09',N'SYSTEM');
INSERT INTO DBD_TEST.dbo.T_SYS_URL (ACCES_URL,URL_DESC,ALW_DIV,USE_YN,REG_DTE,REG_LOGIN_ID,UPT_DTE,UPT_LOGIN_ID) VALUES
	 (N'/services',N'웹서비스',N'IS_AUTHENTICATED_ANONYMOUSLY',N'Y','2021-06-25',N'ADMIN','2021-06-25',N'ADMIN'),
	 (N'/viself/auth/authMember',N'권한관리 권한맴버 서비스',N'IS_AUTHENTICATED_FULLY',N'Y','2021-05-03',N'ADMIN','2021-05-03',N'ADMIN'),
	 (N'/viself/auth/authMenu',N'권한관리 권한메뉴 서비스',N'IS_AUTHENTICATED_FULLY',N'Y','2021-05-03',N'ADMIN','2021-05-03',N'ADMIN'),
	 (N'/viself/auth/authMenu/list',N'Left Menu List',N'IS_AUTHENTICATED_FULLY',N'Y','2021-04-30',N'ADMIN','2021-04-30',N'ADMIN'),
	 (N'/viself/auth/authMng',N'권한관리 서비스',N'IS_AUTHENTICATED_FULLY',N'Y','2021-05-03',N'ADMIN','2021-05-03',N'ADMIN'),
	 (N'/viself/auth/urlMng',N'Url관리',N'IS_AUTHENTICATED_FULLY',N'Y','2021-04-09',N'ADMI','2021-04-09',N'ADMI'),
	 (N'/viself/code/codeMng',N'코드관리',N'IS_AUTHENTICATED_FULLY',N'Y','2021-04-09',N'ADMI','2021-04-09',N'ADMI'),
	 (N'/viself/code/codeMngWrite',N'코드관리 작성',N'IS_AUTHENTICATED_FULLY',N'Y','2021-05-03',N'ADMIN','2021-05-03',N'ADMIN'),
	 (N'/viself/menu/menuMng',N'메뉴관리',N'IS_AUTHENTICATED_FULLY',N'Y','2021-04-09',N'ADMI','2021-04-09',N'ADMI'),
	 (N'/viself/menu/menuMngWrite',N'메뉴관리 작성',N'IS_AUTHENTICATED_FULLY',N'Y','2021-05-03',N'ADMIN','2021-05-03',N'ADMIN');
INSERT INTO DBD_TEST.dbo.T_SYS_URL (ACCES_URL,URL_DESC,ALW_DIV,USE_YN,REG_DTE,REG_LOGIN_ID,UPT_DTE,UPT_LOGIN_ID) VALUES
	 (N'/viself/mlang/mLangInit',N'다국어 초기화',N'IS_AUTHENTICATED_FULLY',N'Y','2021-07-30',N'ADMIN','2021-07-30',N'ADMIN'),
	 (N'/viself/mlang/mLangMng',N'다국어관리',N'IS_AUTHENTICATED_FULLY',N'Y','2021-04-09',N'ADMI','2021-04-09',N'ADMI'),
	 (N'/viself/mlang/mLangMng/deleteNoLang/json',N'다국어 미등록 삭제',N'IS_AUTHENTICATED_FULLY',N'Y','2021-05-25',N'ADMIN','2021-05-25',N'ADMIN'),
	 (N'/viself/mlang/mLangMng/listMaxVersion/json',N'다국어 버전 서비스',N'IS_AUTHENTICATED_FULLY',N'Y','2021-05-25',N'ADMIN','2021-05-25',N'ADMIN'),
	 (N'/viself/mlang/mLangMng/notYetInsert/json',N'다국어 미등록 입력',N'IS_AUTHENTICATED_FULLY',N'Y','2021-05-25',N'ADMIN','2021-05-25',N'ADMIN'),
	 (N'/viself/mlang/mLangMngList',N'다국어관리-다국어팝업',N'IS_AUTHENTICATED_FULLY',N'Y','2021-05-04',N'ADMIN','2021-05-04',N'ADMIN'),
	 (N'/viself/mlang/mLangUpdate',N'다국어 최신화 관련',N'IS_AUTHENTICATED_FULLY',N'Y','2021-05-25',N'ADMIN','2021-05-25',N'ADMIN'),
	 (N'/viself/module/moduleDialog',N'모듈 다이얼로그',N'IS_AUTHENTICATED_FULLY',N'Y','2021-12-23',N'ADMIN','2021-12-23',N'ADMIN'),
	 (N'/viself/module/moduleListDialog',N'모듈리스트 다이얼로그',N'IS_AUTHENTICATED_FULLY',N'Y','2021-05-03',N'ADMIN','2021-05-03',N'ADMIN'),
	 (N'/viself/module/moduleMng',N'모듈관리',N'IS_AUTHENTICATED_FULLY',N'Y','2021-04-09',N'ADMI','2021-04-09',N'ADMI');
INSERT INTO DBD_TEST.dbo.T_SYS_URL (ACCES_URL,URL_DESC,ALW_DIV,USE_YN,REG_DTE,REG_LOGIN_ID,UPT_DTE,UPT_LOGIN_ID) VALUES
	 (N'/viself/module/urlListDialog.include',N'모듈용 Url 리스트 다이얼로그',N'IS_AUTHENTICATED_FULLY',N'Y','2021-12-24',N'ADMIN','2021-12-24',N'ADMIN');