-- 全てのシーケンスを削除
begin
	for cur in (SELECT OBJECT_NAME,OBJECT_TYPE FROM USER_OBJECTS)
	loop
		dbms_output.put_line('DROP SEQUENCE' || ' ' || cur.OBJECT_NAME);
		begin
			execute immediate 'DROP SEQUENCE' || ' ' || cur.OBJECT_NAME;
		exception when others then
			dbms_output.put_line('ERR' || cur.object_name);
		end;
	end loop;
end;

/
exit;
