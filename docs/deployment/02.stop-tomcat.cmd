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
:: DESCRIPTION
:: ------------------------------------------------------------
::     변경된 빌드를 반영하기위해 운영중인 Tomcat 을 종료한다.
::     종료방법은 Tomcat 운영방법에 따라 서비스 종료, 혹은 console 종료로 구분한다.
::
::     1. Window service 로 Tomcat 이 운영된다면 서비스 종료를
::     2. CMD 에서 콘솔로 운영된다면 console 종료를 수행한다.
:: ============================================================

:: ------------------------------------------------------------
:: stop tomcat
:: ============================================================

:: 1. stop service: 서비스로 운영하면 아래명령의 주석을 해제한다.
:: NET STOP "Tomcat9"

:: 2. stop console: CMD 로 운영되면 아래블럭의 주석을 해제한다.
:: 2.1. change tomcat directory
CD "E:\Program Files\Apache Software Foundation\apache-tomcat-9.0.39\bin"
:: 2.2. shutdown tomcat
shutdown.bat