--�t�@���N�V�������R���p�C�����e�X�L�[�}�Ŏ��s
BEGIN
for cur in (SELECT object_name, object_type FROM user_objects WHERE object_type = 'FUNCTION')
loop
dbms_output.put_line(cur.object_name);
BEGIN
dbms_output.put_line('ALTER ' || cur.object_type || ' ' || cur.object_name || ' COMPILE');
execute immediate 'ALTER ' || cur.object_type || ' ' || cur.object_name || ' COMPILE';
exception when others then
dbms_output.put_line('ERR' || cur.object_name);
END;
end loop;
END;
/
EXIT;