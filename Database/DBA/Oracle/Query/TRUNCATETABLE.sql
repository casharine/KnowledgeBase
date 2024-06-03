-- 全てのテーブルの削除
begin
	for cur in (SELECT OBJECT_NAME,OBJECT_TYPE FROM USER_OBJECTS WHERE OBJECT_TYPE = 'TABLE')
	loop
		dbms_output.put_line('TRUNCATE TABLE ' || cur.OBJECT_NAME);
		begin
			execute immediate 'TRUNCATE TABLE ' || cur.OBJECT_NAME;
		exception when others then
			dbms_output.put_line('ERR' || cur.object_name);
		end;
	end loop;
end;

/
exit;
