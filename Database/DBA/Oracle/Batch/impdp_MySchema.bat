@echo off
CLS

cd /d %~dp0

:環境に合わせて変更してください
set DATE=20240602
set DMPNM=FromSchema

rem 変更元情報
set USER1=FromSchema
set PASS1=FromSchema

rem 変更先情報
set USER2=ToSchema
set PASS2=ToSchema

set DB=ORCL

echo ---------------------------------------------
echo  %DB%の%USER1%に対して処理します  
echo ---------------------------------------------
pause

echo ---------------------------------------------
echo  バックアップ用ディレクトリを作成します
echo ---------------------------------------------

del %~dp0\DumpQueries\CreateDirectory.sql /Q /F

echo CREATE OR REPLACE DIRECTORY DUMP_DIR AS '%~dp0'; >>%~dp0\DumpQueries\CreateDirectory.sql
echo exit; >>%~dp0\DumpQueries\CreateDirectory.sql

sqlplus %USER1%/%PASS1%@%DB% @DumpQueries\CreateDirectory.sql

echo ---------------------------------------------
echo  オブジェクトを削除します
echo ---------------------------------------------
sqlplus %USER2%/%PASS2%@%DB% @DumpQueries\OBJECT削除.sql

echo ---------------------------------------------
echo  %USER2% をインポートします      
echo ---------------------------------------------
impdp %USER2%/%PASS2%@%DB% dumpfile=DUMP_DIR:%DATE%%DMPNM%.dmp logfile=DUMP_DIR:%DATE%imp.log exclude=STATISTICS table_exists_action=REPLACE REMAP_SCHEMA=%USER1%:%USER2%

echo ---------------------------------------------
echo  リコンパイル実行 FUNCTION                 
echo ---------------------------------------------
sqlplus %USER2%/%PASS2%@%DB% @DumpQueries\Recompire_FUNCTION.SQL

echo ---------------------------------------------
echo  リコンパイル実行 PACKAGE                
echo ---------------------------------------------
sqlplus %USER2%/%PASS2%@%DB% @DumpQueries\Recompire_PACKAGE.SQL

echo ---------------------------------------------
echo  リコンパイル実行 PROCEDURE                 
echo ---------------------------------------------
sqlplus %USER2%/%PASS2%@%DB% @DumpQueries\Recompire_PROCEDURE.SQL

echo ---------------------------------------------
echo  インデックス再構築   
echo ---------------------------------------------
sqlplus %USER2%/%PASS2%@%DB% @DumpQueries\IndexRebuild.SQL

echo ---------------------------------------------
echo  統計情報を再収集
echo ---------------------------------------------
sqlplus %USER2%/%PASS2%@%DB% @DumpQueries\GatherRecollect.sql %USER2%

echo ---------------------------------------------
echo  ログファイルを退避          
echo ---------------------------------------------
set DIRNAME=impdplog
mkdir %DIRNAME%

move %DATE%imp.log %DIRNAME%

echo ---------------------------------------------
echo  インポート済みのDMPを退避
echo ---------------------------------------------
set DIRNAME2=DMP_backup
mkdir %DIRNAME2%

move %DATE%%DMPNM%.dmp %DIRNAME2%

echo ---------------------------------------------
echo  インポートが完了          
echo ---------------------------------------------

pause