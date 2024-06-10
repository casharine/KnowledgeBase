# クエリ集
## 目次
- [クエリ集](#クエリ集)
  - [目次](#目次)
  - [はじめに](#はじめに)
  - [SQLServer管理関連](#sqlserver管理関連)
      - [接続中セッションの確認](#接続中セッションの確認)
      - [復元していますで停まってしまったDBを使用可能にする](#復元していますで停まってしまったdbを使用可能にする)
      - [シングルユーザーモードを解除する](#シングルユーザーモードを解除する)
      - [SQLServerのGrep検索](#sqlserverのgrep検索)
  - [Oracle管理関連](#oracle管理関連)
      - [全てのオブジェクトの更新時間や作成時間を確認する](#全てのオブジェクトの更新時間や作成時間を確認する)
      - [異なるスキーマのテーブル構造を比較する](#異なるスキーマのテーブル構造を比較する)
  - [保守関連](#保守関連)
      - [Select結果の一部を変更してINSERT文を生成する方法](#select結果の一部を変更してinsert文を生成する方法)
      - [Select結果の一部を変更してUPD文を生成する方法](#select結果の一部を変更してupd文を生成する方法)

## はじめに
便利なクエリ、よくコピペするクエリ、簡単だが忘れてしまうクエリ等まとめていきます

## SQLServer管理関連
#### 接続中セッションの確認
```select * from sys.dm_exec_sessions where host_name is not NULL```
#### 復元していますで停まってしまったDBを使用可能にする
```restore database [データベース名] with recovery```
#### シングルユーザーモードを解除する
```ALTER DATABASE  [データベース名] SET MULTI_USER```
#### SQLServerのGrep検索
  ```
  SELECT 
      o.name AS Object_Name,
      o.type_desc AS Object_Type,
      m.definition AS Object_Definition
  FROM 
      sys.sql_modules AS m
      INNER JOIN sys.objects AS o ON m.object_id = o.object_id
  WHERE 
      m.definition LIKE '%検索文字列%'
  ORDER BY 
      o.type_desc, o.name;
  ```

## Oracle管理関連
#### 全てのオブジェクトの更新時間や作成時間を確認する
本番のスキーマとの差分比較を行いリリースにそなえます
```
SELECT a.OBJECT_NAME, a.OBJECT_TYPE, a.CREATED, a.LAST_DDL_TIME, a.TIMESTAMP, a.STATUS
FROM user_objects a
order by a.LAST_DDL_TIME desc
```

#### 異なるスキーマのテーブル構造を比較する
- FullOuter
```select * from(
    select  table_name
        ,column_name
    from        all_tab_columns
    where        owner='SchemaNameA'
) SchemaNameA
full outer join (select
          table_name
        ,column_name
    from        all_tab_columns
    where        owner='SchemaNameB') SchemaNameB
on SchemaNameA.TABLE_NAME = SchemaNameB.TABLE_NAME
and SchemaNameA.COLUMN_NAME = SchemaNameB.COLUMN_NAME
order by SchemaNameA.TABLE_NAME, SchemaNameB.TABLE_NAME , SchemaNameA.COLUMN_NAME, SchemaNameB.COLUMN_NAME 
```
- 差分のみ
```
select  table_name
    ,column_name
    ,'check'
from        all_tab_columns
where        owner='SchemaNameA'
minus
select  table_name
    ,column_name
    ,'check'
from        all_tab_columns
where        owner='SchemaNameB'
```

## 保守関連
#### Select結果の一部を変更してINSERT文を生成する方法
```
INSERT INTO TableA
SELECT   
        40
        ,OriginalCode
        ,OriginalName
        ,GroupKey
        ,ConvertCode
        ,ConvertCode
        ,SakujoFlg
        ,SakuseiNichiji
        ,SakuseiShaCode
        ,KoushinNichiji
        ,KoushinShaCode
FROM TableA a
LEFT JOIN  AS TableB b
ON a.GroupKey = b.GroupKey
WHERE a.GroupKey = 6
```
#### Select結果の一部を変更してUPD文を生成する方法
```
UPDATE Table
SET
    Table.col1 = other_table.col1,
    Table.col2 = other_table.col2
FROM
    Table
INNER JOIN
    other_table
ON
    Table.id = other_table.id
```

