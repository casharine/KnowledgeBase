-- スキーマ内の全てのTriggerをON
begin
	for cur in (SELECT RTRIM(A.OWNER) OWN,A.TRIGGER_NAME TRNAME FROM ALL_TRIGGERS A WHERE A.OWNER IN ('MYSCHEMA','MYSCHEMA2'))
	loop
		dbms_output.put_line(cur.OWN);
		execute immediate 'ALTER TRIGGER ' || cur.OWN || '.' || cur.TRNAME || ' enable';
	end loop;
end;
/
exit;
