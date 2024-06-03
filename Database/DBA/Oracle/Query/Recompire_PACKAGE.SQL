--パッケージリコンパイルを各スキーマで実行
begin
	for cur in (select object_name, object_type from user_objects/* where status = 'INVALID'*/)
	loop
		dbms_output.put_line(cur.object_name);
		begin
			execute immediate 'alter ' || cur.object_type || ' ' || cur.object_name || ' compile';
			
			IF cur.object_name = 'PACKAGE' OR cur.object_name = 'PACKAGE BODY' THEN
				execute immediate 'alter PACKAGE ' || cur.object_name || ' compile BODY';
			END IF;
		exception when others then
			dbms_output.put_line('ERR' || cur.object_name);
		end;
	end loop;
end;

/
exit;
