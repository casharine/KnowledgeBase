-- スキーマ内の全てのトリガーをOFF
begin
	for cur in (SELECT RTRIM(A.OWNER) OWN,A.TRIGGER_NAME TRNAME FROM ALL_TRIGGERS A WHERE A.OWNER IN ('MYSCHEMA1','MYSCHEMA'))
	loop
		dbms_output.put_line(cur.OWN);
		execute immediate 'ALTER TRIGGER ' || cur.OWN || '.' || cur.TRNAME || ' disable';
	end loop;
end;
/
exit;
