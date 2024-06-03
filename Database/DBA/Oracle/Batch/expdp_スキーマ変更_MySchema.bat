@echo off
CLS

cd /d %~dp0

:環境に合わせて変更してください
SET DATE=20240602
SET USER=FromSchema
SET PASS=FromSchema

echo ---------------------------------------------
echo  %USER%に対して処理します          
echo ---------------------------------------------
pause

echo ---------------------------------------------
echo  バックアップ用ディレクトリを作成します 
echo ---------------------------------------------

del %~dp0\DumpQueries\CreateDirectory.sql /Q /F

echo CREATE OR REPLACE DIRECTORY DUMP_DIR AS '%~dp0'; >>%~dp0\DumpQueries\CreateDirectory.sql
echo exit; >>%~dp0\DumpQueries\CreateDirectory.sql

sqlplus %USER%/%PASS% @DumpQueries\CreateDirectory.sql

echo ---------------------------------------------
echo  WEBデータをエクスポートします           
echo ---------------------------------------------
expdp %USER%/%PASS% dumpfile=DUMP_DIR:%DATE%%USER%.dmp logfile=DUMP_DIR:%DATE%exp%USER%.log schemas=%USER%

echo ---------------------------------------------
echo  ログファイルを退避します               
echo ---------------------------------------------
set DIRNAME=expdplog
mkdir %DIRNAME%

move %DATE%exp%USER%.log %DIRNAME%

echo ---------------------------------------------
echo  エクスポートが完了しました             
echo ---------------------------------------------

pause