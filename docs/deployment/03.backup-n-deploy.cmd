@ECHO OFF
:: ============================================================
:: LICENSE
:: ------------------------------------------------------------
:: Copyright 2021 Vertex ID.
::
:: Licensed under the Apache License, Version 2.0 (the "License");
:: you may not use this file except in compliance with the License.
:: You may obtain a copy of the License at
::
::     http://www.apache.org/licenses/LICENSE-2.0
::
:: Unless required by applicable law or agreed to in writing, software
:: distributed under the License is distributed on an "AS IS" BASIS,
:: WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
:: See the License for the specific language governing permissions and
:: limitations under the License.
:: ============================================================
@ECHO ON

:: ============================================================
:: Descriptions
:: ------------------------------------------------------------
::    1. 기존에 운영되고 있는 빌드를 zip 으로 백업하고
::    2. 변경된 빌드를 반영한다.
::
::    [주의]
::        오픈소스이며 command 를 지원하는 7zip 이 설치되어 있어야 한다.
:: ============================================================

:: ------------------------------------------------------------
:: 0. backup script settings
:: ============================================================
:: 7zip
SET ZIP7="C:\Program Files\7-Zip\7z.exe"
:: build dir
SET BUILD_DIR="E:\workspace\Pragon-ELMS\target\paragon-elms"
:: deploy dir: 디렉터리 경로
SET DEPLOY_DIR="E:\workspace\paragon-elms.war"
:: backup dir
SET BACKUP_DIR="E:\workspace\backup"
:: backup file name
SET BACKUP_FILENAME="paragon-elms"
:: retention day
SET RETENTION_DAY=7

:: ------------------------------------------------------------
:: 0.1. set file name
:: ============================================================
FOR /F "tokens=2-4 delims=/ " %%i IN ('date /t') DO SET DATE=%%i-%%j-%%k
FOR /F "tokens=1-3 delims=: " %%i IN ('time /t') DO SET TIME=%%i-%%j-%%k
SET BAK_TIME=%DATE%
SET BAK_FILEPATH=%BACKUP_DIR%\%BACKUP_FILENAME%_%BAK_TIME%.zip
SET LOG_FILEPATH=%BACKUP_DIR%\%BACKUP_FILENAME%_%BAK_TIME%.log


:: ------------------------------------------------------------
:: 1. backup: backup old build
:: ============================================================
:: 1.1. make compress file
%ZIP7% a -y %BAK_FILEPATH% %DEPLOY_DIR% > %LOG_FILEPATH%

:: 1.2. delete old backup
forfiles /p %BACKUP_DIR% /M *.zip /D -%RETENTION_DAY% /C "cmd /c del /q @file"

:: ------------------------------------------------------------
:: 2. deployment
:: ============================================================
:: 2.1. delete old build
RD %DEPLOY_DIR% /s /q
MD %DEPLOY_DIR%

:: 2.2. copy new build
XCOPY %BUILD_DIR% %DEPLOY_DIR% /s