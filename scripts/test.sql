SERVEROUTPUT ON;

--Inserting a new employee 
INSERT INTO EMPLOYEE (EMP_ID,ENAME, POSITION_TYPE, GENDER, SALARY, DOB, HIREDATE, COMM, DNAME) VALUES
(290, 'Rii Roxas','HR','F',23000,'04-FEB-2002','19-FEB-2023', NULL,'RESEARCH');

CREATE PROCEDURE INSERT_EMPLOYEE(emp_id IN NUMBER, ename IN VARCHAR2, position_type IN VARCHAR2, gender IN VARCHAR2, 
salary IN NUMBER, dob IN DATE, hiredate IN DATE, comm IN NUMBER, dname IN VARCHAR2)
IS
BEGIN
  INSERT INTO EMPLOYEE (EMP_ID, ENAME, POSITION_TYPE, GENDER, SALARY, DOB, HIREDATE, COMM, DNAME)
  VALUES (emp_id, ename, position_type, gender, salary, dob, hiredate, comm, dname);
END;



--Remvoving an Employee
BEGIN
  DELETE FROM EMP_PHONE WHERE EMP_ID = 111;
  DELETE FROM LOGIN WHERE EMP_ID = 111;
  DELETE FROM TRANSACTIONS WHERE EMP_ID = 111;
  DELETE FROM VEHICLE WHERE EMP_ID = 111;
  DELETE FROM OVERTIME WHERE EMP_ID = 111;
  DELETE FROM EMPLOYEE WHERE EMP_ID = 111;
  COMMIT;
END;

DROP PROCEDURE REMOVE_EMPLOYEE;

CREATE PROCEDURE REMOVE_EMPLOYEE(emp_id IN NUMBER)
IS
BEGIN
  DELETE FROM EMP_PHONE WHERE EMP_ID = emp_id;
  DELETE FROM LOGIN WHERE EMP_ID = emp_id;
  DELETE FROM TRANSACTIONS WHERE EMP_ID = emp_id;
  DELETE FROM VEHICLE WHERE EMP_ID = emp_id;
  DELETE FROM OVERTIME WHERE EMP_ID = emp_id;
  DELETE FROM EMPLOYEE WHERE EMP_ID = emp_id;
  COMMIT;
END;

CALL REMOVE_EMPLOYEE (222);

--Update the Salary
UPDATE EMPLOYEE SET SALARY = 25000 WHERE EMP_ID = 290;

DROP PROCEDURE UPDATE_SALARY;

CREATE PROCEDURE UPDATE_SALARY(emp_id IN NUMBER, new_salary IN NUMBER)
IS
BEGIN
  UPDATE EMPLOYEE 
  SET SALARY = new_salary 
  WHERE EMP_ID = emp_id;
END;

CALL UPDATE_SALARY(111, 11000);

--Search by Employee number to retrieve information about his/her Allowances
SELECT ALLOWANCE.ALLOWANCE_TYPE, ALLOWANCE.AM0UNT
FROM EMPLOYEE
JOIN POS_ALL ON EMPLOYEE.POSITION_TYPE = POS_ALL.POSITION_TYPE
JOIN ALLOWANCE ON POS_ALL.ALLOWANCE_TYPE = ALLOWANCE.ALLOWANCE_TYPE
WHERE EMPLOYEE.EMP_ID = 111;

CREATE FUNCTION GET_EMPLOYEE_ALLOWANCES(emp_id IN NUMBER)
RETURN SYS_REFCURSOR
IS
  v_result SYS_REFCURSOR;
BEGIN
  OPEN v_result FOR
    SELECT ALLOWANCE.ALLOWANCE_TYPE, ALLOWANCE.AM0UNT
    FROM EMPLOYEE
    JOIN POS_ALL ON EMPLOYEE.POSITION_TYPE = POS_ALL.POSITION_TYPE
    JOIN ALLOWANCE ON POS_ALL.ALLOWANCE_TYPE = ALLOWANCE.ALLOWANCE_TYPE
    WHERE EMPLOYEE.EMP_ID = emp_id;
    
  RETURN v_result;
END;

SELECT GET_EMPLOYEE_ALLOWANCES(111) FROM DUAL;