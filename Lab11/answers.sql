--1
DECLARE
a NUMBER := 5;
b CONSTANT VARCHAR2(80) := 'Witam';
c DATE := TO_DATE('27-05-2002','DD-MM-YYYY');
BEGIN
    DBMS_OUTPUT.PUT_LINE(a);
    DBMS_OUTPUT.PUT_LINE(b);
    DBMS_OUTPUT.PUT_LINE(c);
END;
/

--2

DECLARE 
a DATE := TO_DATE('01-07-2001','DD-MM-YYYY');
b DATE  := SYSDATE;

liczba_dni NUMBER;
liczba_tygodni NUMBER;
liczba_miesiecy NUMBER;

BEGIN
    liczba_dni := b-a;
    liczba_tygodni := TRUNC(liczba_dni/7);
    liczba_miesiecy := MONTHS_BETWEEN(b,a);
    
    DBMS_OUTPUT.PUT_LINE(TRUNC(liczba_dni));
    DBMS_OUTPUT.PUT_LINE(liczba_tygodni);
    DBMS_OUTPUT.PUT_LINE(TRUNC(liczba_miesiecy));
END;
/

--3

DECLARE
    nazwisko emp.last_name%TYPE;
    imie emp.first_name%TYPE;
BEGIN
    SELECT first_name, last_name INTO imie,nazwisko FROM emp WHERE salary=(SELECT MAX(salary) FROM emp);
    DBMS_OUTPUT.PUT_LINE('MAX: imie: ' || imie || ', nazwisko: ' || nazwisko);
    
    SELECT first_name, last_name INTO imie, nazwisko FROM emp WHERE salary=(SELECT MIN(salary) FROM emp);
    DBMS_OUTPUT.PUT_LINE('MIN: imie: ' || imie || ', nazwisko: ' || nazwisko);
EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('Zapytanie nie zwrocilo danych.');
WHEN TOO_MANY_ROWS THEN
DBMS_OUTPUT.PUT_LINE('Zapytanie zwrocilo za duzo rekordow.');
END;
/

--4
--4a (jawny kursor)
DECLARE
    uv_nazwisko VARCHAR2(25);
    uv_imie VARCHAR2(25);
    
    CURSOR c_emp IS
    SELECT first_name, last_name
    FROM emp;
BEGIN
    OPEN c_emp;
    
    LOOP
        FETCH c_emp INTO uv_imie, uv_nazwisko;
        EXIT WHEN c_emp%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(c_emp%ROWCOUNT||'. '||uv_imie||' '||uv_nazwisko);
    END LOOP;
    CLOSE c_emp;
END;
/


--4b (niejawny kursor)
BEGIN
    FOR i IN (SELECT first_name, last_name FROM emp)
    LOOP
        DBMS_OUTPUT.PUT_LINE(i.first_name || ' ' || i.last_name);
    END LOOP;
END;
/

--5

DECLARE
    m_customer_id ord.customer_id%TYPE;
    m_customer_name customer.name%TYPE;
    m_date_ord_from DATE := TO_DATE('04-09-1992', 'DD-MM-YYYY');
    m_date_ord_to DATE := TO_DATE('30-12-1992','DD-MM-YYYY');
    m_id ord.id%TYPE;
    m_date_ordered ord.date_ordered%TYPE;
    m_date_shipped ord.date_shipped%TYPE;    
    m_sales_rep_name emp.first_name%TYPE;
    m_sales_rep_last_name emp.last_name%TYPE;
    m_sales_rep_id emp.id%TYPE;
    
    CURSOR i IS SELECT id, customer_id, sales_rep_id, date_ordered,date_shipped FROM ord WHERE date_ordered >= m_date_ord_from AND date_ordered <= m_date_ord_to ORDER BY id;
BEGIN
    OPEN i;
    LOOP
    FETCH i into m_id, m_customer_id, m_sales_rep_id, m_date_ordered, m_date_shipped;
    EXIT WHEN i%NOTFOUND;
    SELECT first_name, last_name INTO m_sales_rep_name, m_sales_rep_last_name FROM emp WHERE id=m_sales_rep_id;
    
    SELECT name INTO m_customer_name FROM customer WHERE id=m_customer_id;
    DBMS_OUTPUT.PUT_LINE(i%ROWCOUNT || ' id: ' || m_id || ' Nazwa klienta: ' || m_customer_name || ' data zamowienia: ' || TO_CHAR(m_date_ordered, 'DD-MM-YYYY') || ' data dostarczenia ' || TO_CHAR(m_date_shipped, 'DD-MM-YYYY') || ' pracownik obslugujacy: ' || m_sales_rep_name || ' ' || m_sales_rep_last_name);
    END LOOP;
    CLOSE i;
END;
/  


--6

CREATE TABLE emp_new AS SELECT * FROM emp;

DECLARE 
    m_avg NUMBER;
BEGIN
    SELECT AVG(salary) INTO m_avg FROM emp_new;
    
    FOR i IN (SELECT * FROM emp ORDER BY salary)
    LOOP
        IF (i.salary<m_avg/2) THEN
            UPDATE emp_new SET salary = (salary * 1.2) WHERE id=i.id;
        ELSIF (i.salary < m_avg/2 AND i.salary>m_avg * (5/6)) THEN
            UPDATE emp_new SET salary = (salary * 1.1) WHERE id = i.id;
        ELSE
            UPDATE emp_new SET salary = (salary*1.05) WHERE id = i.id;
            END IF;
    END LOOP;
END;
/

