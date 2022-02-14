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
::     1. 소스코드를 SVN 으로 부터 업데이트 받고
::     2. 메이븐으로 빌드를 진행한다.
::
::     [주의]
::         Tortoise SVN 을 설치할 때 Command 부분도 설치해야 svn command 를 사용할 수 있다.
:: ============================================================

:: ------------------------------------------------------------
:: update and build
:: ============================================================
:: 0. change directory
CD "E:\workspace\Paragon-ELMS"

:: 1. update from svn
svn update

:: 2. build by maven
mvn clean install