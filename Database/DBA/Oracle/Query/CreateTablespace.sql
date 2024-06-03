-- テーブルスペース:Oracleデータベースにおいてデータの物理的な格納場所を定義
create tablespace USERS_M
datafile 'D:\app\Administrator\oradata\ORCLC\USERS_M.ORA' size 2000m autoextend on;
create tablespace USERS_R
datafile 'D:\app\Administrator\oradata\ORCLC\USERS_R01.ORA' size 10000m autoextend on;
create tablespace USERS_T
datafile 'D:\app\Administrator\oradata\ORCLC\USERS_T.ORA' size 2000m autoextend on;
create tablespace USERS_W
datafile 'D:\app\Administrator\oradata\ORCLC\USERS_W.ORA' size 1000m autoextend on;