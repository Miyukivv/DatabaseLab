-- 1-4
set echo off

alter session set nls_date_language='american';
alter session set nls_date_format='dd-mon-yyyy';
alter session set nls_numeric_characters='.,';

Rem Drop tables.
DROP TABLE pracownicy cascade constraints;
DROP TABLE stanowiska cascade constraints;
DROP TABLE oddziały cascade constraints;
DROP TABLE regiony cascade constraints;
DROP TABLE klienci cascade constraints;
DROP TABLE zamówienia cascade constraints;
DROP TABLE statusy cascade constraints;

Rem Create and populate tables.

CREATE TABLE pracownicy
(nr                  NUMBER(7) 
    CONSTRAINT pracownicy_nr_nn NOT NULL,
imię                VARCHAR2(40) 
    CONSTRAINT pracownicy_imię_nn NOT NULL,
nazwisko            VARCHAR2(40) 
    CONSTRAINT pracownicy_nazwisko_nn NOT NULL,
stanowisko          VARCHAR2(30),
oddział_nr          NUMBER(10),
zarobki             NUMBER(11,2),
przełożony_nr       NUMBER(7),
    CONSTRAINT pracownicy_nr_pk PRIMARY KEY(nr));
    
INSERT INTO pracownicy VALUES(
1, 'Karolina', 'Jastrzębiak', 'Menadżer', 101, 5000.00, NULL);

INSERT INTO pracownicy VALUES(
2, 'Anna', 'Włodarz', 'Kierownik', 101, 4500.00, 1);

INSERT INTO pracownicy VALUES (
3, 'Krzysztof', 'Giernek', 'Magazynier', 102, 3500.00, 4);

INSERT INTO pracownicy VALUES (
4, 'Monika', 'Kowal','Specjalista', 103, 4300.00,1);


CREATE TABLE stanowiska(
stanowisko              VARCHAR2(40) 
    CONSTRAINT stanowiska_stanowisko_nr_nn NOT NULL,
    CONSTRAINT stanowiska_stanowisko_pk PRIMARY KEY(stanowisko)); 

INSERT INTO stanowiska VALUES ('Menadżer');
INSERT INTO stanowiska VALUES ('Kierownik');
INSERT INTO stanowiska VALUES ('Specjalista');
INSERT INTO stanowiska VALUES ('Magazynier');

CREATE TABLE oddziały (
nr                      NUMBER(7) 
    CONSTRAINT oddziały_nr_nn NOT NULL,
nazwa                   VARCHAR2(40)    
    CONSTRAINT oddziały_nazwa_nn NOT NULL,
region_nr               NUMBER(7),  
    CONSTRAINT oddziały_region_nr_pk PRIMARY KEY (nr), 
    CONSTRAINT oddziały_name_region_nr_uk UNIQUE (nazwa, region_nr)); 

INSERT INTO oddziały VALUES(101, 'Dział zarządzania', 3);
INSERT INTO oddziały VALUES (102, 'Dział magazynowania', 2);
INSERT INTO oddziały VALUES (103, 'Dział przemysłowy', 1);

CREATE TABLE regiony(
nr                      NUMBER(7)   
    CONSTRAINT regiony_nr_nn NOT NULL,
nazwa                   VARCHAR2(50)    
    CONSTRAINT regiony_name_nn NOT NULL,
    CONSTRAINT region_nr_pk PRIMARY KEY (nr),
    CONSTRAINT region_nazwa_uk UNIQUE(nazwa)
);

INSERT INTO regiony VALUES (1, 'Europa');
INSERT INTO regiony VALUES (2, 'Azja');
INSERT INTO regiony VALUES (3, 'Ameryka Południowa');

CREATE TABLE klienci(
nr                          NUMBER(7) 
    CONSTRAINT klienci_nr_nn NOT NULL,
nazwa                      VARCHAR2(30) 
    CONSTRAINT klienci_nazwa_nn NOT NULL,
telefon                    VARCHAR2(25),
adres                      VARCHAR2(40),
miasto                     VARCHAR2(30),
kraj                       VARCHAR2(30),
pracownicy_nr              NUMBER(7),
region_nr                  NUMBER(7),
    CONSTRAINT klienci_nr_pk PRIMARY KEY(nr));

INSERT INTO klienci VALUES  (1, 'Tomasz Wrzesień', '661-462-789', 'ul. Moliera 8', 'Warszawa', 'Polska', 4, 1);
INSERT INTO klienci VALUES (2, 'Jan Kociuba', '653-537-321', 'ul. Fabryczna 2', 'Poznań', 'Polska', 3, 1);

CREATE TABLE zamówienia(
nr                         NUMBER(7) 
   CONSTRAINT zamówienia_nr_nn NOT NULL,
 nr_klienta               NUMBER(7) 
   CONSTRAINT zamówienia_nr_klienta_nn NOT NULL,
 data_zamówienia            DATE,
 data_wysyłki               DATE,
 pracownicy_nr              NUMBER(7),
 cena_całościowa            NUMBER(11, 2),
     CONSTRAINT zamówienia_nr_pk PRIMARY KEY(nr));

INSERT INTO zamówienia VALUES(1,1,TO_DATE('2024-05-10', 'YYYY-MM-DD'), TO_DATE('2024-05-12', 'YYYY-MM-DD'), 3, 1500.00);
INSERT INTO zamówienia VALUES(2,2, TO_DATE('2024-05-11', 'YYYY-MM-DD'), TO_DATE('2024-05-13', 'YYYY-MM-DD'), 4, 2000.00);

Rem Add foreign key constraints.

ALTER TABLE pracownicy
   ADD CONSTRAINT pracownicy_przełożony_nr_fk
   FOREIGN KEY (przełożony_nr) REFERENCES pracownicy(nr);
ALTER TABLE pracownicy
   ADD CONSTRAINT pracownicy_oddział_nr_fk
   FOREIGN KEY (oddział_nr) REFERENCES oddziały(nr);
ALTER TABLE pracownicy 
   ADD CONSTRAINT pracownicy_stanowisko_fk
   FOREIGN KEY (stanowisko) REFERENCES stanowiska(stanowisko);
ALTER TABLE oddziały 
   ADD CONSTRAINT oddziały_regiony_id_fk
   FOREIGN KEY (region_nr) REFERENCES regiony(nr);
ALTER TABLE klienci
   ADD CONSTRAINT pracownicy_nr_fk
   FOREIGN KEY (pracownicy_nr) REFERENCES pracownicy(nr);
ALTER TABLE klienci
   ADD CONSTRAINT klienci_regiony_nr_fk
   FOREIGN KEY (region_nr) REFERENCES regiony(nr);
   
ALTER TABLE zamówienia
   ADD CONSTRAINT zamówienia_nr_klienta_fk
   FOREIGN KEY (nr_klienta) REFERENCES klienci(nr);
   
ALTER TABLE zamówienia
   ADD CONSTRAINT zamówienia_pracownicy_id_fk
   FOREIGN KEY (pracownicy_nr) REFERENCES pracownicy(nr);

set echo on

--2 część

--5
ALTER TABLE klienci 
ADD adres_email VARCHAR2(100);

ALTER TABLE klienci
ADD CONSTRAINT unique_adres_email UNIQUE(adres_email);


--6
ALTER TABLE zamówienia
ADD zrealizowane_za VARCHAR2(3);

ALTER TABLE zamówienia 
    ADD CONSTRAINT zamówienia_zrealizowane_za_ck 
        CHECK (zrealizowane_za in ('Tak','Nie'));


--7
ALTER TABLE zamówienia
ADD data_zrealizowania TIMESTAMP;


--8
ALTER TABLE zamówienia
    ADD status_zam VARCHAR(20);

ALTER TABLE zamówienia
    ADD CONSTRAINT zamówienia_status_zam_ck
        CHECK (status_zam IN ('Nowe zamówienie','Realizowane','Przesyłka wysłana','Zakończone'));


        
--9
CREATE TABLE statusy (
nr                  NUMBER(7) 
    CONSTRAINT statusy_nr_pk  PRIMARY KEY,
nazwa                VARCHAR2(20) 
    CONSTRAINT statusy_nazwa_nn NOT NULL);

INSERT INTO statusy VALUES(1,'Nowe zamówienie');
INSERT INTO statusy VALUES(2,'Realizowane');
INSERT INTO statusy VALUES(3,'Przesyłka wysłana');
INSERT INTO statusy VALUES(4,'Zakończone');

ALTER TABLE zamówienia
    ADD status_nr NUMBER(7) 
        CONSTRAINT zamówienia_status_nr_fk REFERENCES statusy(nr);