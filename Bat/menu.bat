@echo off
color 0a
call:loadConfig

REM -------start------------�˵�Ŀ¼-------------------
:start
echo ========================================
call:colstr b "#" 2 2 0
call:colstr c "hello world" 0 0 0
call:colstr b "����������Ҫ�Ĳ���" 0 0 1

echo.
call:colstr e "#" 2 4 0
call:colstr e "1  - ��������������" 0 0 1

call:colstr e "#" 2 4 0
call:colstr e "2  - �رմ���������" 0 0 1

call:colstr e "#" 2 4 0
call:colstr e "3  - ��������������" 0 0 1

call:colstr e "#" 2 4 0
call:colstr e "4  - �鿴�����������б�" 0 0 1

echo.
call:colstr e "#" 2 4 0
call:colstr e "5  - ������Ͳ�ӷ�����" 0 0 1

call:colstr e "#" 2 4 0
call:colstr e "6  - �ر���Ͳ�ӷ�����" 0 0 1

call:colstr e "#" 2 4 0
call:colstr e "7  - ������Ͳ�ӷ�����" 0 0 1

call:colstr e "#" 2 4 0
call:colstr e "8  - �鿴��Ͳ�ӷ������б�" 0 0 1

echo.
call:colstr e "#" 2 4 0
call:colstr e "9  - ��������ţţ������" 0 0 1

call:colstr e "#" 2 4 0
call:colstr e "10 - �ر�����ţţ������" 0 0 1

call:colstr e "#" 2 4 0
call:colstr e "11 - ��������ţţ������" 0 0 1

call:colstr e "#" 2 4 0
call:colstr e "12 - �鿴����ţţ�������б�" 0 0 1



echo.
call:colstr b "#" 2 4 0
call:colstr b "q  - dbl_ͬ��" 0 0 1

call:colstr b "#" 2 4 0
call:colstr b "w  - dbl_��������" 0 0 1

echo.
call:colstr b "#" 2 4 0
call:colstr b "z  - hotfix_ͬ��" 0 0 1

call:colstr b "#" 2 4 0
call:colstr b "x  - hotfix_��������" 0 0 1

echo.
call:colstr d "#" 2 4 0
call:colstr d "d  - �༭dns" 0 0 1
call:colstr d "#" 2 4 0
call:colstr d "f  - ˢ��dns" 0 0 1

call:colstr d "#" 2 4 0
call:colstr d "m  - �ۿ�С��Ӱ" 0 0 1

echo ========================================

set /p id=




if '%id%'=='1' goto start_hall
if '%id%'=='2' goto stop_hall
if '%id%'=='3' goto restart_hall
if '%id%'=='4' goto list_hall

if '%id%'=='5' goto start_ttz
if '%id%'=='6' goto stop_ttz
if '%id%'=='7' goto restart_ttz
if '%id%'=='8' goto list_ttz

if '%id%'=='9' goto start_mpnn
if '%id%'=='10' goto stop_mpnn
if '%id%'=='11' goto restart_mpnn
if '%id%'=='12' goto list_mpnn

if '%id%'=='q' goto pull_git
if '%id%'=='w' goto push_git
if '%id%'=='z' goto pull_git_hotfix
if '%id%'=='x' goto push_git_hotfix
if '%id%'=='d' goto edit_dns
if '%id%'=='f' goto refresh_dns
if '%id%'=='m' goto movie


if /i '%id%'=='exit' goto exitFun
if /i '%id%'=='cls' cls & goto start
goto error

REM -------start------------end----------------------------



REM -------error------------����Ƿ�����,û��ƥ��ľ���ʾ�������ѡ��-------------------
:error
echo.
call:colstr c "#" 2 8 0
call:colstr c "��������޷�ʶ������±����������룡" 0 0 2
goto start
REM -------------------end---------------------------------

:exitFun
exit



REM -------loadConfig------------��ȡ�����ļ�config.ini-------------------

:loadConfig
SET CONFIG_FILE=%ROOT%config.ini

FOR /F "tokens=1,2 delims==" %%i in (%CONFIG_FILE%) DO (
 SET %%i=%%j
)
goto:eof

REM -------loadConfig------------end-------------------







REM -------Colstr------------�����ɫ����------------------
:Colstr <��ɫ> <"����"> <���ֺ�Ӷ��ٿո�> <������ֺ󻻶�����>
pushd %tmp% & setlocal ENABLEEXTENSIONS

if exist "%~2?" del/a/q "%~2?">nul 2>nul

call:Colstr_bs %4 sp " "
if %3 gtr 0 (call:Colstr_bs %3 bk "") else set "bk="
call:Colstr_bs %4 sp " "

set/p=%bk%%sp%<nul>"%~2" & findstr /a:%1 .* "%~2?" 2>nul


if not %5 equ 0 for /l %%a in (1 1 %5)do echo.

endlocal & popd & goto:eof



:Colstr_bs
set "p=" & for /l %%a in (1 1 %1)do call set "p=%%p%%%~3"
set "%2=%p%" & goto:eof

REM -------Colstr------------end-------------------









REM -------hall������------------������������ز���------------------
:start_hall
start /D %hallSrc% pomelo start -e development
echo �����´��ڿ����������������˿�Ϊ��%hallPort%
goto start

:stop_hall
call pomelo stop -P %hallPort%
echo �ѹر� ����������
goto start


:restart_hall
call pomelo stop -P %hallPort%
call:_sleep 5
goto start_hall


:list_hall
call pomelo list -P %hallPort%
echo.
goto start
REM -------hall������-----------end-------------------





REM -------mpnn������------------����ţţ��������ز���------------------
:start_mpnn
start /D %mpnnSrc% pomelo start -e development
echo �����´��ڿ�������ţţ���������˿�Ϊ��%mpnnPort%
goto start

:stop_mpnn
call pomelo stop -P %mpnnPort%
echo �ѹر� ����ţţ������
goto start


:restart_mpnn
call pomelo stop -P %mpnnPort%
call:_sleep 5
goto start_mpnn

:list_mpnn
call pomelo list -P %mpnnPort%
echo.
goto start
REM -------mpnn������-----------end-------------------


REM -------ttz������------------��Ͳ�ӷ�������ز���------------------
:start_ttz
start /D %ttzSrc% pomelo start -e development
echo �����´��ڿ�����Ͳ�ӷ��������˿�Ϊ��%ttzPort%
goto start

:stop_ttz
call pomelo stop -P %ttzPort%
echo �ѹر� ��Ͳ�ӷ�����
goto start


:restart_ttz
call pomelo stop -P %ttzPort%
call:_sleep 5
goto start_mpnn

:list_ttz
call pomelo list -P %ttzPort%
echo.
goto start
REM -------ttz������-----------end-------------------


REM -------_sleep------------��ָͣ������ʱ���ټ�������------------------
:_sleep <second>
echo slee������  %1��
@ping 127.0.0.1 -n %1 -w 1000>nul
goto:eof

REM -------_sleep------------end-------------------



REM -------_git------------------------------------
:pull_git  <ͬ��dbl_git>

cd /d %git_push_dir%
echo ͬ���С�����
git pull
goto:start




:push_git  <����dbl_git>
cd /d %git_push_dir%
echo ����add���ļ�������
git add .

echo ����commit���ļ�������
git commit -m "�⿡-�������ύ%date%%time:~0,2%:%time:~3,2%"

echo �������͵�Զ�̷�����������
git push origin master

echo �������.
goto:start
REM -------git------------end-------------------






REM -------_git------------------------------------
:pull_git_hotfix  <����dbl_git_hotfix>

cd /d %git_hotfix_push_dir%
echo ͬ���С�����
git pull
goto:start




:push_git_hotfix  <����db_git_hotfix>
cd /d %git_hotfix_push_dir%
echo ����add���ļ�������
git add .

echo ����commit���ļ�������

git commit -m "�⿡-�������ύ%date%%time:~0,2%:%time:~3,2%"

echo �������͵�Զ�̷�����������
git push origin master

echo �������.
goto:start
REM -------git------------end-------------------




:movie <�ۿ�batС��Ӱ>
start telnet towel.blinkenlights.nl
goto:start


:edit_dns <�༭dns>
%note++% "%systemroot%%hostsSrc%"
goto:start


:refresh_dns <ˢ��dns>
ipconfig /flushdns
goto:start











REM 同理，在一条语句中也能实现多个条件的“与”，如：
REM if '%1'=='a' if '%2'=='b' if '%3'=='c' if '%4'=='d' goto c











REM pomelo start -e production -D