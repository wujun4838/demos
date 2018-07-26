@echo off
color 0a
call:loadConfig

REM -------start------------菜单目录-------------------
:start
echo ========================================
call:colstr b "#" 2 2 0
call:colstr c "hello world" 0 0 0
call:colstr b "请输入你想要的操作" 0 0 1

echo.
call:colstr e "#" 2 4 0
call:colstr e "1  - 开启大厅服务器" 0 0 1

call:colstr e "#" 2 4 0
call:colstr e "2  - 关闭大厅服务器" 0 0 1

call:colstr e "#" 2 4 0
call:colstr e "3  - 重启大厅服务器" 0 0 1

call:colstr e "#" 2 4 0
call:colstr e "4  - 查看大厅服务器列表" 0 0 1

echo.
call:colstr e "#" 2 4 0
call:colstr e "5  - 开启推筒子服务器" 0 0 1

call:colstr e "#" 2 4 0
call:colstr e "6  - 关闭推筒子服务器" 0 0 1

call:colstr e "#" 2 4 0
call:colstr e "7  - 重启推筒子服务器" 0 0 1

call:colstr e "#" 2 4 0
call:colstr e "8  - 查看推筒子服务器列表" 0 0 1

echo.
call:colstr e "#" 2 4 0
call:colstr e "9  - 开启名牌牛牛服务器" 0 0 1

call:colstr e "#" 2 4 0
call:colstr e "10 - 关闭名牌牛牛服务器" 0 0 1

call:colstr e "#" 2 4 0
call:colstr e "11 - 重启名牌牛牛服务器" 0 0 1

call:colstr e "#" 2 4 0
call:colstr e "12 - 查看名牌牛牛服务器列表" 0 0 1



echo.
call:colstr b "#" 2 4 0
call:colstr b "q  - dbl_同步" 0 0 1

call:colstr b "#" 2 4 0
call:colstr b "w  - dbl_更新推送" 0 0 1

echo.
call:colstr b "#" 2 4 0
call:colstr b "z  - hotfix_同步" 0 0 1

call:colstr b "#" 2 4 0
call:colstr b "x  - hotfix_更新推送" 0 0 1

echo.
call:colstr d "#" 2 4 0
call:colstr d "d  - 编辑dns" 0 0 1
call:colstr d "#" 2 4 0
call:colstr d "f  - 刷新dns" 0 0 1

call:colstr d "#" 2 4 0
call:colstr d "m  - 观看小电影" 0 0 1

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



REM -------error------------输入非法操作,没有匹配的就显示错误从新选择-------------------
:error
echo.
call:colstr c "#" 2 8 0
call:colstr c "输入错误，无法识别操作下表，请重新输入！" 0 0 2
goto start
REM -------------------end---------------------------------

:exitFun
exit



REM -------loadConfig------------读取配置文件config.ini-------------------

:loadConfig
SET CONFIG_FILE=%ROOT%config.ini

FOR /F "tokens=1,2 delims==" %%i in (%CONFIG_FILE%) DO (
 SET %%i=%%j
)
goto:eof

REM -------loadConfig------------end-------------------







REM -------Colstr------------输出颜色文字------------------
:Colstr <颜色> <"文字"> <文字后加多少空格> <输出文字后换多少行>
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









REM -------hall服务器------------大厅服务器相关操作------------------
:start_hall
start /D %hallSrc% pomelo start -e development
echo 已在新窗口开启大厅服务器，端口为：%hallPort%
goto start

:stop_hall
call pomelo stop -P %hallPort%
echo 已关闭 大厅服务器
goto start


:restart_hall
call pomelo stop -P %hallPort%
call:_sleep 5
goto start_hall


:list_hall
call pomelo list -P %hallPort%
echo.
goto start
REM -------hall服务器-----------end-------------------





REM -------mpnn服务器------------明牌牛牛服务器相关操作------------------
:start_mpnn
start /D %mpnnSrc% pomelo start -e development
echo 已在新窗口开启明牌牛牛服务器，端口为：%mpnnPort%
goto start

:stop_mpnn
call pomelo stop -P %mpnnPort%
echo 已关闭 名牌牛牛服务器
goto start


:restart_mpnn
call pomelo stop -P %mpnnPort%
call:_sleep 5
goto start_mpnn

:list_mpnn
call pomelo list -P %mpnnPort%
echo.
goto start
REM -------mpnn服务器-----------end-------------------


REM -------ttz服务器------------推筒子服务器相关操作------------------
:start_ttz
start /D %ttzSrc% pomelo start -e development
echo 已在新窗口开启推筒子服务器，端口为：%ttzPort%
goto start

:stop_ttz
call pomelo stop -P %ttzPort%
echo 已关闭 推筒子服务器
goto start


:restart_ttz
call pomelo stop -P %ttzPort%
call:_sleep 5
goto start_mpnn

:list_ttz
call pomelo list -P %ttzPort%
echo.
goto start
REM -------ttz服务器-----------end-------------------


REM -------_sleep------------暂停指定秒数时间再继续操作------------------
:_sleep <second>
echo slee。。。  %1秒
@ping 127.0.0.1 -n %1 -w 1000>nul
goto:eof

REM -------_sleep------------end-------------------



REM -------_git------------------------------------
:pull_git  <同步dbl_git>

cd /d %git_push_dir%
echo 同步中。。。
git pull
goto:start




:push_git  <推送dbl_git>
cd /d %git_push_dir%
echo 正在add新文件。。。
git add .

echo 正在commit新文件。。。
git commit -m "吴俊-批处理提交%date%%time:~0,2%:%time:~3,2%"

echo 正在推送到远程服务器。。。
git push origin master

echo 推送完成.
goto:start
REM -------git------------end-------------------






REM -------_git------------------------------------
:pull_git_hotfix  <推送dbl_git_hotfix>

cd /d %git_hotfix_push_dir%
echo 同步中。。。
git pull
goto:start




:push_git_hotfix  <推送db_git_hotfix>
cd /d %git_hotfix_push_dir%
echo 正在add新文件。。。
git add .

echo 正在commit新文件。。。

git commit -m "吴俊-批处理提交%date%%time:~0,2%:%time:~3,2%"

echo 正在推送到远程服务器。。。
git push origin master

echo 推送完成.
goto:start
REM -------git------------end-------------------




:movie <观看bat小电影>
start telnet towel.blinkenlights.nl
goto:start


:edit_dns <编辑dns>
%note++% "%systemroot%%hostsSrc%"
goto:start


:refresh_dns <刷新dns>
ipconfig /flushdns
goto:start











REM 鍚岀悊锛屽湪涓�鏉¤鍙ヤ腑涔熻兘瀹炵幇澶氫釜鏉′欢鐨勨�滀笌鈥濓紝濡傦細
REM if '%1'=='a' if '%2'=='b' if '%3'=='c' if '%4'=='d' goto c











REM pomelo start -e production -D