-- インデックスの再構築を各スキーマで実行
BEGIN
	for cur in (SELECT object_name, object_type FROM user_objects WHERE object_type = 'INDEX')
	loop
		dbms_output.put_line(cur.object_name);
		BEGIN
			dbms_output.put_line('ALTER ' || cur.object_type || ' ' || cur.object_name || ' REBUILD');
			execute immediate 'ALTER ' || cur.object_type || ' ' || cur.object_name || ' REBUILD';
		exception when others then
			dbms_output.put_line('ERR' || cur.object_name);
		END;
	end loop;
END;

/
EXIT;
