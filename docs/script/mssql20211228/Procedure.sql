create FUNCTION F_SYS_CD_ABB_LANG (
    @IN_PARENT_CD VARCHAR
, @IN_CD_ABB VARCHAR
) RETURNS VARCHAR(1000)
AS
BEGIN

	DECLARE @V_RES VARCHAR(1000);
	SET @V_RES = '';

	IF @IN_CD_ABB IS NOT NULL
BEGIN
SELECT @V_RES = T1.LANG_CD
FROM V_SYS_CODE T1
WHERE T1.CD_ABB = @IN_CD_ABB
  AND T1.PARENT_CD = @IN_PARENT_CD
;
END;

RETURN @V_RES;

END;

CREATE FUNCTION [dbo].[F_SYS_CD_ABB_LANGS]
(
	  @P_PARENT_CODE_ID VARCHAR(50)
	, @P_CODE VARCHAR(50)
)
RETURNS NVARCHAR(100)

AS
BEGIN
		DECLARE @V_RES NVARCHAR(100)
		SET @V_RES = ''

		IF (ISNULL(@P_CODE,'') <> '')
BEGIN
SELECT @V_RES =(
    STUFF((
        SELECT ',' + V1.LANG_CD
        FROM V_SYS_CODE V1
                 INNER JOIN dbo.FN_SPLIT(@P_CODE,',') FS
                            ON V1.CD_ABB = FS.VAL
                                AND V1.PARENT_CD = @P_PARENT_CODE_ID
        GROUP BY LANG_CD
        FOR XML PATH('')
        ),1,1,'')
    )


END




RETURN @V_RES
END;

CREATE FUNCTION [dbo].[F_SYS_LANG]
(
	@P_CODE VARCHAR(30),
	@P_LANG VARCHAR(10)
)
RETURNS VARCHAR(255)
AS
BEGIN
		DECLARE
@V_RES VARCHAR(255)
		SET
			@V_RES = ''

		IF ISNULL(@P_CODE, '') <> '' BEGIN
SELECT @V_RES = (
    CASE @P_LANG
        WHEN 'EN' THEN T1.EN
        WHEN 'JA' THEN T1.JA
        WHEN 'ZH' THEN T1.ZH
        ELSE T1.KO
        END)
FROM T_SYS_LANG_MAS T1
WHERE T1.LANG_CD =  @P_CODE;
END

RETURN @V_RES
END;

CREATE FUNCTION [dbo].[F_SYS_UID]()
RETURNS CHAR(32)
AS
/******************************************************************************
   NAME:     F_SYS_UID
   PURPOSE:  [AIR-SYSTEM] 32자리 랜덤 UUID값 반환

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2013-03-12   KANGSEWON       1. 32자리 UUID 반환(MS-SQL)


******************************************************************************/
BEGIN

RETURN (SELECT replace(UID,'-','') FROM V_SYS_UID)

END;

CREATE FUNCTION [dbo].[FN_SPLIT]
(
@리스트 VARCHAR(MAX)
,@분리자 VARCHAR(10)
)
RETURNS @TB TABLE
(
POS int IDENTITY PRIMARY KEY,
VAL varchar(200)
)
AS
/*
- '' 값도 반환한다
- 마지막은 분리자로 끝낸다
SELECT * FROM  dbo.[FN_SPLIT]('^1^^333^2^222^3^333^4^444^5^555^6^666^7^777^8^888^9^999','^') A
SELECT * FROM  dbo.[FN_SPLIT]('1^^22^^^^^^444444','^^') A
*/
BEGIN
 DECLARE
@시작위치 SMALLINT
 ,@마지막위치 SMALLINT
 ,@카운터 SMALLINT
 ,@분리자크기 SMALLINT
SELECT @분리자크기 = LEN(@분리자)

           IF RIGHT(@리스트,@분리자크기)!=@분리자
BEGIN
  SET @리스트=@리스트+@분리자
END
 SET @리스트=@분리자+@리스트

 SET @시작위치 = 1
SELECT @마지막위치 = CHARINDEX (@분리자,@리스트 ,@시작위치+@분리자크기)
    SET @카운터 = 0
 WHILE (1=1)
BEGIN
  SET @시작위치 = CHARINDEX (@분리자,@리스트 )
SELECT @마지막위치 = CHARINDEX (@분리자,@리스트 ,@시작위치+@분리자크기)
           IF @마지막위치 <= 0 BREAK
    INSERT INTO @TB(VAL) VALUES (SUBSTRING(@리스트,@시작위치+@분리자크기,@마지막위치-@시작위치-@분리자크기))
SELECT @리스트 = STUFF(@리스트,@시작위치,@분리자크기,'')
    SET @카운터 = @카운터 + 1
END
 RETURN
END;
