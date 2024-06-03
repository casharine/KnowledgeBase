# Oracleダンプ作成・復元手順

## １．ディレクトリの作成
Database\Oracle\DBA\Query\CreateDirectory.sql
```
CREATE OR REPLACE DIRECTORY DUMP_DIR AS 'D:\dirName\00_backup\'; 
exit; 
```

## ２．スキーマの作成
Database\Oracle\DBA\Query\CreateUSER.sql
```
CREATE USER MySchema IDENTIFIED BY "MySchema"
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON USERS
/
GRANT CONNECT TO MySchema
/
GRANT DBA TO MySchema
/
GRANT RESOURCE TO MySchema
/
GRANT DROP ANY TABLE TO MySchema
/
GRANT UNLIMITED TABLESPACE TO MySchema
/
GRANT READ,WRITE ON DIRECTORY DATA_PUMP_DIR TO MySchema
/
exit
```

## ３．出力バッチ実行
Database\Oracle\DBA\Batch\expdp_スキーマ変更_MySchema.batを実行

- DumpQueries内のクエリを参照するため配置注意同じディレクトリに配置する
- スキーマ名と実行日時を編集する
- 新バージョンから旧バージョン指定が必要とする

## ４．取込バッチ実行
Database\Oracle\DBA\Batch\impdp_MySchema.bat

- Database\Oracle\DBA\Batch にダンプファイルをコピー
- impdp のスキーマ名、実行日時を変更し実行




