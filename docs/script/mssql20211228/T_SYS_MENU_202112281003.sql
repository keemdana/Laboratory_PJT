INSERT INTO DBD_TEST.dbo.T_SYS_MENU (MENU_ID,PARENT_MENU_ID,ORD_NO,USE_YN,JSON_DATA,MODULE_ID,REG_DTE,REG_LOGIN_ID,UPT_DTE,UPT_LOGIN_ID,LANG_CD) VALUES
	 (N'ADMIN_MANAGER',NULL,0,N'1',N'[{"key":"","val":""}]',NULL,'2021-04-15',N'SYSTEM','2021-12-02',N'SYSTEM',N'L.관리_변경'),
	 (N'CMM_NOTICE',N'ADMIN_MANAGER',0,N'1',N'[{"key":"","val":""}]',N'cmmBoard','2021-04-15',N'SYSTEM','2021-11-30',N'SYSTEM',N'L.공지사항'),
	 (N'DEV_SETTINGS',NULL,0,N'1',N'[{"key":"","val":""}]',NULL,'2021-12-02',N'SYSTEM','2021-12-02',N'SYSTEM',N'L.개발_설정'),
	 (N'MENU_MANAGER',N'DEV_SETTINGS',7,N'1',N'[{"key":"","val":""}]',N'menuMng',NULL,N'SYSTEM','2021-12-02',N'SYSTEM',N'L.시스템메뉴관리'),
	 (N'SYS_AUTH',N'ADMIN_MANAGER',9,N'1',N'[{"key":"","val":""}]',N'authMng',NULL,N'SYSTEM','2021-11-30',N'SYSTEM',N'L.시스템권한관리'),
	 (N'SYS_CODE',N'ADMIN_MANAGER',4,N'1',N'[{"key":"","val":""}]',N'codeMng',NULL,N'SYSTEM','2021-11-30',N'SYSTEM',N'L.코드관리'),
	 (N'SYS_MLANG',N'ADMIN_MANAGER',7,N'1',N'[{"key":"","val":""}]',N'mlangMng',NULL,N'SYSTEM','2021-11-30',N'SYSTEM',N'L.다국어코드'),
	 (N'SYS_MODULE',N'DEV_SETTINGS',1,N'1',N'[{"key":"","val":""}]',N'moduleMng',NULL,N'SYSTEM','2021-12-02',N'SYSTEM',N'L.모듈관리'),
	 (N'URL_MNG',N'DEV_SETTINGS',0,N'1',N'[{"key":"","val":""}]',N'urlMng',NULL,N'SYSTEM','2021-12-02',N'SYSTEM',N'L.URL관리');