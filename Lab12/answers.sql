SET SERVEROUTPUT ON;

--część do zadania (6)

CREATE TABLE top_n_emp (
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    salary NUMBER
);

--(1) utworzyć pakiet o nazwie pracownicy, zaimplementować podane  procedury i funkcje
CREATE OR REPLACE PACKAGE pracownicy IS

--(2) dodaj_emp – zadaniem procedury ma być dodawanie nowego pracownika do tabeli emp
    PROCEDURE dodaj_emp (
        in_first_name     IN emp.first_name%TYPE,
        in_last_name      IN emp.last_name%TYPE,
        in_userid         IN emp.userid%TYPE,
        in_start_date     IN emp.start_date%TYPE,
        in_comments       IN emp.comments%TYPE,
        in_manager_id     IN emp.manager_id%TYPE,
        in_title          IN emp.title%TYPE,
        in_dept_id        IN emp.dept_id%TYPE,
        in_salary         IN emp.salary%TYPE,
        in_commission_pct IN emp.commission_pct%TYPE
    );

--(3) zmień_emp – procedura modyfikująca dane wskazanego pracownika.
    PROCEDURE zmień_emp (
        in_id             IN emp.id%TYPE,
        in_first_name     IN emp.first_name%TYPE DEFAULT NULL,
        in_last_name      IN emp.last_name%TYPE DEFAULT NULL,
        in_userid         IN emp.userid%TYPE DEFAULT NULL,
        in_start_date     IN emp.start_date%TYPE DEFAULT NULL,
        in_comments       IN emp.comments%TYPE DEFAULT NULL,
        in_manager_id     IN emp.manager_id%TYPE DEFAULT NULL,
        in_title          IN emp.title%TYPE DEFAULT NULL,
        in_dept_id        IN emp.dept_id%TYPE DEFAULT NULL,
        in_salary         IN emp.salary%TYPE DEFAULT NULL,
        in_commission_pct IN emp.commission_pct%TYPE DEFAULT NULL
    );
    
--(4) kasuj_emp – procedura kasująca dane wskazanego pracownika.
    PROCEDURE kasuj_emp (
        in_id IN emp.id%TYPE
    );
    
--(5) zmiana_salary – zadaniem tej procedury jest zmiana zarobków wskazanego pracownika.
    PROCEDURE zmiana_salary (
        in_id             IN emp.id%TYPE,
        percentage_change IN NUMBER
    );
    
--(6) top_n_emp – wyświetla listę n pracowników, którzy zarabiają najwięcej
    PROCEDURE top_n_emp(in_n IN NUMBER);

--(7) zmiana_dept – procedura zmienia przypisanie pracownika do wydziału (tabela dept)
    PROCEDURE zmiana_dept (
    in_id IN emp.id%TYPE, 
    in_dept_id IN emp.dept_id%TYPE);
    
--(8) stat_emp – zadaniem funkcji jest zwrócenie jednej wartości
    FUNCTION stat_emp(stat_type IN VARCHAR2) 
        RETURN NUMBER;
END pracownicy;
/

CREATE OR REPLACE PACKAGE BODY pracownicy IS

--(2)dodaj_emp – zadaniem procedury ma być dodawanie nowego pracownika do tabeli emp
    PROCEDURE dodaj_emp (
        in_first_name     IN emp.first_name%TYPE,
        in_last_name      IN emp.last_name%TYPE,
        in_userid         IN emp.userid%TYPE,
        in_start_date     IN emp.start_date%TYPE,
        in_comments       IN emp.comments%TYPE,
        in_manager_id     IN emp.manager_id%TYPE,
        in_title          IN emp.title%TYPE,
        in_dept_id        IN emp.dept_id%TYPE,
        in_salary         IN emp.salary%TYPE,
        in_commission_pct IN emp.commission_pct%TYPE
    ) IS
        uv_max_id emp.id%TYPE;
    BEGIN
        SELECT
            MAX(id)
        INTO uv_max_id
        FROM
            emp;

        INSERT INTO emp (
            id,
            last_name,
            first_name,
            userid,
            start_date,
            comments,
            manager_id,
            title,
            dept_id,
            salary,
            commission_pct
        ) VALUES (
            uv_max_id + 1,
            in_last_name,
            in_first_name,
            in_userid,
            in_start_date,
            in_comments,
            in_manager_id,
            in_title,
            in_dept_id,
            in_salary,
            in_commission_pct
        );
        dbms_output.put_line('Nowy pracownik dodany');
    END dodaj_emp;

--(3) zmień_emp – procedura modyfikująca dane wskazanego pracownika.

    PROCEDURE zmień_emp (
        in_id             IN emp.id%TYPE,
        in_first_name     IN emp.first_name%TYPE DEFAULT NULL,
        in_last_name      IN emp.last_name%TYPE DEFAULT NULL,
        in_userid         IN emp.userid%TYPE DEFAULT NULL,
        in_start_date     IN emp.start_date%TYPE DEFAULT NULL,
        in_comments       IN emp.comments%TYPE DEFAULT NULL,
        in_manager_id     IN emp.manager_id%TYPE DEFAULT NULL,
        in_title          IN emp.title%TYPE DEFAULT NULL,
        in_dept_id        IN emp.dept_id%TYPE DEFAULT NULL,
        in_salary         IN emp.salary%TYPE DEFAULT NULL,
        in_commission_pct IN emp.commission_pct%TYPE DEFAULT NULL
    ) IS
    BEGIN
        UPDATE emp
        SET
            first_name = nvl(first_name, in_first_name),
            last_name = nvl(last_name, in_last_name),
            userid = nvl(userid, in_userid),
            start_date = nvl(start_date, in_start_date),
            comments = nvl(comments, in_comments),
            manager_id = nvl(manager_id, in_manager_id),
            title = nvl(title, in_title),
            dept_id = nvl(dept_id, in_dept_id),
            salary = nvl(salary, in_salary),
            commission_pct = nvl(commission_pct, in_commission_pct);

    END zmień_emp;
    
 --(4) kasuj_emp – procedura kasująca dane wskazanego pracownika.

    PROCEDURE kasuj_emp (
        in_id IN emp.id%TYPE
    ) IS
    BEGIN
        DELETE FROM emp
        WHERE
            id = in_id;

        dbms_output.put_line('Pracownik zostal usuniety');
    END kasuj_emp;
    
    
--(5) zmiana_salary – zadaniem tej procedury jest zmiana zarobków wskazanego pracownika.

    PROCEDURE zmiana_salary (
        in_id             IN emp.id%TYPE,
        percentage_change IN NUMBER
    ) IS
    BEGIN
        UPDATE emp
        SET
            salary = salary * ( 1 + in_id / 100 )
        WHERE
            id = in_id;

        dbms_output.put_line('Zmieniono zarobki!');
    END zmiana_salary;

--(6) top_n_emp – wyświetla listę n pracowników, którzy zarabiają najwięcej

    PROCEDURE top_n_emp (
        in_n IN NUMBER
    ) IS
    BEGIN
        DELETE FROM top_n_emp;
        
        INSERT INTO top_n_emp (first_name,last_name, salary)
        SELECT first_name, last_name, salary FROM (SELECT first_name, last_name, salary FROM emp ORDER BY salary) WHERE ROWNUM <=in_n;
        DBMS_OUTPUT.PUT_LINE('Liczba pracownikow zapisanych do top_n_emp : ' || in_n);
    END top_n_emp;
    
--(7) zmiana_dept – procedura zmienia przypisanie pracownika do wydziału (tabela dept)
    PROCEDURE zmiana_dept (
        in_id      IN emp.id%TYPE,
        in_dept_id IN emp.dept_id%TYPE
    ) IS
    BEGIN
        UPDATE emp
        SET
            dept_id = in_dept_id
        WHERE
            id = in_id;

        dbms_output.put_line('Zmiana wydziału pracownika');
    END zmiana_dept;

--(8) stat_emp – zadaniem funkcji jest zwrócenie jednej wartości

    FUNCTION stat_emp (
        stat_type IN VARCHAR2
    ) RETURN NUMBER IS
        stat_value NUMBER;
    BEGIN
        CASE stat_type
            WHEN 'MAX' THEN
                SELECT
                    MAX(salary)
                INTO stat_value
                FROM
                    emp;

            WHEN 'MIN' THEN
                SELECT
                    MIN(salary)
                INTO stat_value
                FROM
                    emp;

            WHEN 'AVG' THEN
                SELECT
                    AVG(salary)
                INTO stat_value
                FROM
                    emp;

            WHEN 'SUM' THEN
                SELECT
                    SUM(salary)
                INTO stat_value
                FROM
                    emp;

            ELSE
                dbms_output.put_line('Podano niepoprawny typ, dostepne opcje to MAX,MIN,AVG,SALARY');
        END CASE;

        RETURN stat_value;
    END stat_emp;
END pracownicy;
/


--TESTY:

--Procedura (2) dodaj_emp - test

BEGIN
    pracownicy.dodaj_emp(
    in_first_name => 'Dominik', 
    in_last_name => 'Jastrzab', 
    in_userid => 'djast34', 
    in_start_date => TO_DATE('2024-07-24','YYYY-MM-DD'), 
    in_comments => 'Nowy pracownik', 
    in_manager_id => 3, 
    in_title => 'Sales Representative', 
    in_dept_id => 32,
    in_salary => 1400, in_commission_pct => 15);
END;
/

--Procedura (3) zmień_emp - test
BEGIN
    pracownicy.zmień_emp(
    in_id => 26, 
    in_first_name => 'Marcin', 
    in_last_name => 'Jastrzab', 
    in_userid => 'djast34', 
    in_start_date => TO_DATE('2024-07-24','YYYY-MM-DD'), 
    in_comments => 'Super pracownik', 
    in_manager_id => 1, 
    in_title => 'Manager', 
    in_dept_id => 32,
    in_salary => 4000, 
    in_commission_pct => 15);
END;
/

--Procedura (4) kasuj_emp - test
BEGIN
    pracownicy.kasuj_emp(in_id => 26);
END;
/

--Procedura (5) zmiana_salary - test
BEGIN
    pracownicy.zmiana_salary(  
    in_id => 26, 
    percentage_change => 25);

END;
/

--Procedura (6) top_n_emp - test

BEGIN
    pracownicy.top_n_emp(in_n =>8);
END;
/
SELECT * FROM top_n_emp;

--Procedura (7) zmiana_dept - test
BEGIN
pracownicy.zmiana_dept(in_id => 26, in_dept_id => 33);

end;
/

--Funkcja (8) stat_emp - test
DECLARE 
    max_salary NUMBER;
BEGIN 
    max_salary :=pracownicy.stat_emp('MAX');
    DBMS_OUTPUT.PUT_LINE('Max zarobki pracownikow: ' || max_salary);
 END;
/