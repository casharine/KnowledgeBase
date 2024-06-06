-- スキーマ内のすべてのユーザーオブジェクトを削除
begin
for cur in (SELECT OBJECT_NAME,OBJECT_TYPE FROM USER_OBJECTS)
loop
dbms_output.put_line('DROP ' || cur.OBJECT_TYPE || ' ' || cur.OBJECT_NAME);
begin
execute immediate 'DROP ' || cur.OBJECT_TYPE || ' ' || cur.OBJECT_NAME;
exception when others then
dbms_output.put_line('ERR' || cur.object_name);
end;
end loop;
end;

/
exit;
