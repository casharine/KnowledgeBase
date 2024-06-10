# Oracleデータ容量チェックとリサイズによる容量確保手順

## はじめに
Oracleデータベースでデータファイルがストレージを圧迫しパフォーマンスが落ちる事があったのでその場合の確認方法と対処方法をまとめます。

## ①各表領域の総スペース、空きスペース、空き割合取得
```
select a.tablespace_name,trunc(b.x,0)||'MB' tota_spac,trunc(a.y,0)||'MB' freespace,trunc(a.y/b.x*100,0)||'%' "空き割合"
from
(
select tablespace_name, sum(bytes)/1024/1024 y
from dba_free_space
group by tablespace_name
order by tablespace_name
) a,
(
select tablespace_name, sum(bytes)/1024/1024 x
from dba_data_files
group by tablespace_name
order by tablespace_name
)b
where a.tablespace_name=b.tablespace_name
```

## ②データファイルの圧縮
Oracleサービスやサーバーの再起動なしに、データファイルが縮小されます。

```
SELECT NAME
,BYTES / 1024 / 1024 AS SIZE_MB
,ROUND(BYTES / 1024 / 1024 / 1024,2) AS SIZE_GB
FROM V$DATAFILE
ORDER BY NAME

--③　①のクエリで空き割合が99%のデータファイルを縮小
ALTER DATABASE DATAFILE 'E:\ORADATA\ORCL\WEB_R.ORA' RESIZE 5000M;
```

