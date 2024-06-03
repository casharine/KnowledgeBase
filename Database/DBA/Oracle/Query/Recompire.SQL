--ユーザーオブジェクトのリコンパイルを各スキーマで実行
begin
	for cur in (select object_name, object_type from user_objects)
	loop
		--dbms_output.put_line(cur.object_type || ':' || cur.object_name);
		begin
			execute immediate 'alter ' || cur.object_type || ' ' || cur.object_name || ' REBUILD';
		exception when others then
			dbms_output.put_line('ERR' || cur.object_name);
		end;
	end loop;

	for cur in (select object_name, object_type from user_objects)
	loop
		--dbms_output.put_line(cur.object_type || ':' || cur.object_name);
		begin
			execute immediate 'alter ' || cur.object_type || ' ' || cur.object_name || ' compile';
		exception when others then
			dbms_output.put_line('ERR' || cur.object_name);
		end;
	end loop;

end;
/
exit;
