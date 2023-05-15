--WHEN TRYING TO CREATE A USERNAME FOR SAME EMPLOYEE OR A NON HR EMPLOYEE
CREATE OR REPLACE TRIGGER ALLOW_HR_LOGIN BEFORE
  INSERT OR UPDATE ON LOGIN FOR EACH ROW
DECLARE
  POSITION_TYPE VARCHAR2(10);
BEGIN
  SELECT
    POSITION_TYPE INTO POSITION_TYPE
  FROM
    EMPLOYEE
  WHERE
    EMP_ID = :NEW.EMP_ID;
  IF POSITION_TYPE <> 'HR' THEN
    RAISE_APPLICATION_ERROR(-20001, 'Only employees with position type HR can have a login.');
  END IF;
END;


