--1
DROP TABLE customer cascade constraints;
DROP TABLE ord cascade constraints;
DROP TABLE item cascade constraints;
DROP TABLE longtext cascade constraints;
DROP TABLE product cascade constraints;
DROP TABLE emp cascade constraints;
DROP TABLE title cascade constraints;
DROP TABLE dept cascade constraints;
DROP TABLE dept cascade constraints;
DROP TABLE product cascade constraints;
DROP TABLE image cascade constraints;
DROP TABLE inventory cascade constraints;
DROP TABLE warehouse cascade constraints;
DROP TABLE region cascade constraints;

DROP TABLE albumy cascade constraints;
DROP TABLE klienci cascade constraints;
DROP TABLE wykonawca cascade constraints;
DROP TABLE zamówienia cascade constraints;
DROP TABLE "Zes-Wyk" cascade constraints;
DROP TABLE "ZESPÓŁ" cascade constraints;

--2

CREATE TABLE albumy (
    album_id           NUMBER(7) NOT NULL,
    tytuł              VARCHAR2(50) NOT NULL,
    ocena              NUMBER(2),
    zespół_id_zespołu  NUMBER(7) NOT NULL
);

CREATE UNIQUE INDEX albumy__idx ON
    albumy (
        zespół_id_zespołu
    ASC );

ALTER TABLE albumy ADD CONSTRAINT albumy_pk PRIMARY KEY ( album_id );

CREATE TABLE klienci (
    klient_id          NUMBER(7) NOT NULL,
    nazwisko           VARCHAR2(25) NOT NULL,
    imię               VARCHAR2(25),
    adres_zamieszkania VARCHAR2(40),
    miasto             VARCHAR2(25),
    kraj               VARCHAR2(2),
    kod_pocztowy       VARCHAR2(10)
);

ALTER TABLE klienci ADD CONSTRAINT klienci_pk PRIMARY KEY ( klient_id );

CREATE TABLE wykonawca (
    id_wykonawcy       NUMBER(7) NOT NULL,
    nazwisko_wykonawcy VARCHAR2(25) NOT NULL,
    imię_wykonawcy     VARCHAR2(25)
);

ALTER TABLE wykonawca ADD CONSTRAINT wykonawca_pk PRIMARY KEY ( id_wykonawcy );

CREATE TABLE zamówienia (
    id_zamówienia                 NUMBER(7) NOT NULL,
    data_zamówienia               DATE NOT NULL,
    data_zrealizowania_zamówienia DATE,
    typ_zamówienia                NUMBER(7),
    albumy_album_id               NUMBER(7) NOT NULL,
    klienci_klient_id             NUMBER(7) NOT NULL
);

ALTER TABLE zamówienia ADD CONSTRAINT zamówienia_pk PRIMARY KEY ( id_zamówienia );

CREATE TABLE zespół (
    id_zespołu    NUMBER(7) NOT NULL,
    nazwa_zespołu VARCHAR2(50) NOT NULL
);

ALTER TABLE zespół ADD CONSTRAINT zesp_pk PRIMARY KEY ( id_zespołu );

CREATE TABLE "Zes-Wyk" (
    zes_id_zespołu      NUMBER(7) NOT NULL,
    wyk_id_wykonawcy NUMBER(7) NOT NULL
);

ALTER TABLE zamówienia
    ADD CONSTRAINT zamówienia_albumy_fk FOREIGN KEY ( albumy_album_id )
        REFERENCES albumy ( album_id );

ALTER TABLE zamówienia
    ADD CONSTRAINT zamówienia_klienci_fk FOREIGN KEY ( klienci_klient_id )
        REFERENCES klienci ( klient_id );

ALTER TABLE "Zes-Wyk"
    ADD CONSTRAINT "Zes-Wyk_Wyk_FK" FOREIGN KEY ( wyk_id_wykonawcy )
        REFERENCES wykonawca ( id_wykonawcy );

ALTER TABLE "Zes-Wyk"
    ADD CONSTRAINT "Zes-Wyk_Zes_FK" FOREIGN KEY ( zes_id_zespołu )
        REFERENCES zespół ( id_zespołu );


--3

SELECT table_name FROM user_tables;

--4

SELECT table_name, column_name, data_type, data_length, data_precision, data_scale, nullable FROM  user_tab_columns WHERE table_name IN ('ALBUMY', 'KLIENCI', 'WYKONAWCA', 'ZAMOWIENIA', 'ZESPOL', 'ZES-WYK') ORDER BY table_name, column_name;
    
--5

DESCRIBE albumy;
DESCRIBE klienci;
DESCRIBE wykonawca;
DESCRIBE zamówienia;
DESCRIBE ZESPÓŁ;
DESCRIBE "Zes-Wyk"; 

--6

--metoda kolumnowa: 
CREATE TABLE opinia (
    opinia_id     NUMBER(7) NOT NULL,
    opis  VARCHAR2(50),
    ocena NUMERIC(2),
    album_id   NUMBER(7) NOT NULL
    CONSTRAINT opinia_id_fk REFERENCES albumy(album_id),
    CONSTRAINT opinia_pk PRIMARY KEY (opinia_id)
);

--metoda tablicowa: 
CREATE TABLE opinia (
    opinia_id     NUMBER(7) NOT NULL,
    opis          VARCHAR2(50),
    ocena         NUMERIC(2),
    album_id      NUMBER(7) NOT NULL,
    CONSTRAINT opinia_pk PRIMARY KEY (opinia_id),
    CONSTRAINT opinia_albumy_fk FOREIGN KEY (album_id)
        REFERENCES albumy (album_id)
);

--metoda ALTER TABLE
-- Tworzenie tabeli opinia bez ograniczenia klucza obcego
CREATE TABLE opinia (
    opinia_id     NUMBER(7) NOT NULL,
    opis          VARCHAR2(50),
    ocena         NUMERIC(2),
    album_id      NUMBER(7) NOT NULL,
    CONSTRAINT opinia_pk PRIMARY KEY (opinia_id)
);

-- Dodawanie ograniczenia klucza obcego za pomocą ALTER TABLE
ALTER TABLE opinia
ADD CONSTRAINT opinia_albumy_fk FOREIGN KEY (album_id)
    REFERENCES albumy (album_id);

--7


WPROWADZENIE I MODYFIKACJA DANYCH
--8 


INSERT INTO zespół (id_zespołu, nazwa_zespołu) VALUES (1, 'The Beatles');
INSERT INTO zespół (id_zespołu, nazwa_zespołu) VALUES (2, 'Queen');
INSERT INTO zespół (id_zespołu, nazwa_zespołu) VALUES (3, 'Led Zeppelin');

INSERT INTO wykonawca (id_wykonawcy, nazwisko_wykonawcy, imię_wykonawcy) VALUES (1, 'Lennon', 'John');
INSERT INTO wykonawca (id_wykonawcy, nazwisko_wykonawcy, imię_wykonawcy) VALUES (2, 'Mercury', 'Freddie');
INSERT INTO wykonawca (id_wykonawcy, nazwisko_wykonawcy, imię_wykonawcy) VALUES (3, 'Plant', 'Robert');

INSERT INTO klienci (klient_id, nazwisko, imię, adres_zamieszkania, miasto, kraj, kod_pocztowy) VALUES (1, 'Kowalski', 'Jan', 'ul. Polna 1', 'Warszawa', 'PL', '00-001');
INSERT INTO klienci (klient_id, nazwisko, imię, adres_zamieszkania, miasto, kraj, kod_pocztowy) VALUES (2, 'Nowak', 'Anna', 'ul. Miodowa 2', 'Kraków', 'PL', '30-002');
INSERT INTO klienci (klient_id, nazwisko, imię, adres_zamieszkania, miasto, kraj, kod_pocztowy) VALUES (3, 'Smith', 'John', '123 Main St', 'New York', 'US', '10001');

INSERT INTO albumy (album_id, tytuł, ocena, zespół_id_zespołu) VALUES (1, 'Abbey Road', 10, 1);
INSERT INTO albumy (album_id, tytuł, ocena, zespół_id_zespołu) VALUES (2, 'A Night at the Opera', 9, 2);
INSERT INTO albumy (album_id, tytuł, ocena, zespół_id_zespołu) VALUES (3, 'Led Zeppelin IV', 10, 3);

INSERT INTO zamówienia (id_zamówienia, data_zamówienia, data_zrealizowania_zamówienia, typ_zamówienia, albumy_album_id, klienci_klient_id) VALUES (1, TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2023-01-10', 'YYYY-MM-DD'), 1, 1, 1);
INSERT INTO zamówienia (id_zamówienia, data_zamówienia, data_zrealizowania_zamówienia, typ_zamówienia, albumy_album_id, klienci_klient_id) VALUES (2, TO_DATE('2023-02-01', 'YYYY-MM-DD'), TO_DATE('2023-02-15', 'YYYY-MM-DD'), 2, 2, 2);
INSERT INTO zamówienia (id_zamówienia, data_zamówienia, data_zrealizowania_zamówienia, typ_zamówienia, albumy_album_id, klienci_klient_id) VALUES (3, TO_DATE('2023-03-01', 'YYYY-MM-DD'), TO_DATE('2023-03-10', 'YYYY-MM-DD'), 1, 3, 3);


INSERT INTO "Zes-Wyk" (zes_id_zespołu, wyk_id_wykonawcy) VALUES (1, 1);
INSERT INTO "Zes-Wyk" (zes_id_zespołu, wyk_id_wykonawcy) VALUES (2, 2);
INSERT INTO "Zes-Wyk" (zes_id_zespołu, wyk_id_wykonawcy) VALUES (3, 3);

INSERT INTO opinia (opinia_id, opis, ocena, album_id) VALUES (1, 'Świetny album!', 5, 1);
INSERT INTO opinia (opinia_id, opis, ocena, album_id) VALUES (2, 'Bardzo dobry!', 4, 2);
INSERT INTO opinia (opinia_id, opis, ocena, album_id) VALUES (3, 'Klasyka rocka', 5, 3);


--9

SELECT * FROM wykonawca;

--10


--poniższy update spowoduje blad poniewaz probujemy zmienic id wykonawcy, do ktorego odwolanie jest z tabeli zes-wyk
UPDATE wykonawca
SET id_wykonawcy=3
WHERE wykonawca.id_wykonawcy=1;

--dodanie przykladowego wykonawcy, ktorego nie bedzie w tabeli zes-wyk
INSERT INTO wykonawca(id_wykonawcy, nazwisko_wykonawcy, imię_wykonawcy) VALUES (4,'cos','coss');

--update wykona sie poniewaz nie ma odwolania do danego wykonawcy w tabeli zes-wyk
UPDATE wykonawca
SET id_wykonawcy=120
WHERE wykonawca.id_wykonawcy = 4;

--11

SELECT * FROM wykonawca;

--12


CREATE TABLE region 
(id                         NUMBER(7) 
   CONSTRAINT region_id_nn NOT NULL,
 name                       VARCHAR2(50) 
   CONSTRAINT region_name_nn NOT NULL,
     CONSTRAINT region_id_pk PRIMARY KEY (id),
     CONSTRAINT region_name_uk UNIQUE (name));

INSERT INTO region VALUES (
   101, 'North America');
INSERT INTO region VALUES (
   102, 'South America');
INSERT INTO region VALUES (
   103, 'Africa / Middle East');
INSERT INTO region VALUES (
   104, 'Asia');
INSERT INTO region VALUES (
   105, 'Europe');
COMMIT;

--13

INSERT INTO  zespół (id_zespołu, nazwa_zespołu) SELECT id, name FROM region;

--14

SELECT * from zespół;