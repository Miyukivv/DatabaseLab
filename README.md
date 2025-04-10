# DatabaseLab

### Zajęcia (labs) 
  - [Lab08](Lab08/)
  - [Lab09](Lab09/)
  - [Lab10](Lab10/)
  - [Lab11](Lab11/)
  - [Lab12](Lab12/)

## Opisy (descriptions)

### [Lab08](Lab08/) – Tworzenie przykładowej bazy danych

- Poznano podstawowe zasady działania relacyjnych baz danych.
- Tworzono tabele z odpowiednią strukturą oraz zastosowano klucze główne i obce.
- Użyto polskiego nazewnictwa przy definiowaniu danych i struktur.
- Wprowadzano przykładowe dane testowe – imiona, nazwiska, stanowiska, itp.
- Odwzorowano strukturę organizacyjną w postaci bazy danych.

**Creating a Sample Database**

- Learned the basic principles of relational database systems.
- Created tables with appropriate structure, applying primary and foreign keys.
- Used Polish naming conventions when defining data and structures.
- Entered sample test data – first names, last names, job positions, etc.
- Reflected the organizational structure in the form of a database.

---

### [Lab09](Lab09/) – Modelowanie bazy danych

- Zrozumiano różnice między modelem logicznym, relacyjnym i fizycznym.
- Projektowano własną bazę danych w oparciu o zasady modelowania.
- Zidentyfikowano encje, relacje oraz ich właściwe atrybuty.
- Wprowadzono więzy integralności, takie jak klucze główne i obce.
- Opracowano kompletną strukturę bazy umożliwiającą wygenerowanie kodu SQL.

**Database Modeling**

- Understood the differences between logical, relational, and physical models.
- Designed a custom database based on modeling principles.
- Identified entities, relationships, and their relevant attributes.
- Applied integrity constraints such as primary and foreign keys.
- Developed a complete database structure enabling SQL code generation.

---

### [Lab10](Lab10/) – Zarządzanie strukturą bazy i operacje na danych

- Doskonalono umiejętność zarządzania schematem bazy danych (usuwanie, tworzenie tabel).
- Analizowano strukturę tabel: kolumny, typy danych, długości, ograniczenia.
- Wykorzystano różne sposoby definiowania kluczy obcych: kolumnowo, tablicowo oraz przez ALTER TABLE.
- Dodano wewnętrzne ograniczenie klucza obcego – odwołanie do tej samej tabeli.
- Tworzono skrypty do ładowania danych z uwzględnieniem integralności.
- Modyfikowano dane i obserwowano reakcje systemu na naruszenia więzów.
- Przeprowadzono kopiowanie danych między tabelami przy użyciu INSERT INTO ... SELECT.

**Database Schema Management and Data Operations**

- Improved skills in managing the database schema (deleting and creating tables).
- Analyzed table structure: columns, data types, lengths, constraints.
- Used various methods to define foreign keys: column-level, table-level, and via ALTER TABLE.
- Added an internal foreign key constraint – referencing the same table.
- Created scripts for loading data while maintaining data integrity.
- Modified data and observed system reactions to constraint violations.
- Performed data copying between tables using INSERT INTO ... SELECT.

---

### [Lab11](Lab11/) – Programowanie w PL/SQL

- Poznano sposób deklarowania zmiennych w języku PL/SQL.
- Wykorzystywano typy danych oraz stałe w kodzie (CONSTANT).
- Obliczano różnice czasu (dni, tygodnie, miesiące) względem wybranej daty.
- Stosowano kursory jawne i niejawne do pobierania danych z tabel.
- Tworzono kursory z parametrami umożliwiającymi filtrowanie wyników.
- Modyfikowano dane w tabeli w zależności od warunków logicznych.
- Wszystkie operacje wykonywano na kopii tabeli w celu zachowania oryginalnych danych.

**PL/SQL Programming**

- Learned how to declare variables in PL/SQL.
- Used data types and constants (CONSTANT) in the code.
- Calculated time differences (days, weeks, months) from a specific date.
- Applied explicit and implicit cursors to retrieve data from tables.
- Created parameterized cursors for filtered queries.
- Modified data in the table based on logical conditions.
- All operations were performed on a copy of the table to preserve original data.

---

### [Lab12](Lab12/) – Tworzenie pakietów PL/SQL i procedur zarządzających danymi

- Poznano sposób tworzenia pakietów w PL/SQL oraz ich wykorzystania w praktyce.
- Utworzono pakiet `pracownicy`, zawierający zbiór procedur i funkcji operujących na tabeli `emp`.
- Zautomatyzowano dodawanie nowych pracowników poprzez użycie sekwencji generującej identyfikator.
- Zaimplementowano procedury do modyfikacji, usuwania oraz zmiany zarobków pracowników.
- Umożliwiono procentową modyfikację wynagrodzenia (zarówno wzrost, jak i obniżkę).
- Opracowano procedurę `top_n_emp`, wyświetlającą n najlepiej opłacanych pracowników oraz zapisującą ich dane do osobnej tabeli.
- Przeanalizowano możliwość tworzenia tabel dynamicznie w kodzie procedury.
- Dodano funkcjonalność zmiany przypisania pracownika do innego działu (`dept`).
- Stworzono funkcję `stat_emp`, która na podstawie zadanego parametru zwraca statystyczne dane o zarobkach: maksymalne, minimalne, średnie lub ich sumę.
- Obsłużono sytuacje błędne – np. przekazanie nieprawidłowego parametru do funkcji.

**Creating PL/SQL Packages and Data Management Procedures**

- Learned how to create packages in PL/SQL and apply them in practice.
- Created a package named `pracownicy`, containing a set of procedures and functions operating on the `emp` table.
- Automated adding new employees using a sequence to generate the ID.
- Implemented procedures for modifying, deleting, and changing employee salaries.
- Enabled percentage-based salary modification (both increase and decrease).
- Developed the `top_n_emp` procedure to display the top n highest-paid employees and store their data in a separate table.
- Analyzed the possibility of dynamically creating tables within procedure code.
- Added functionality to reassign an employee to a different department (`dept`).
- Created a function `stat_emp` that returns statistical salary data (max, min, avg, or total) based on a given parameter.
- Handled error scenarios – e.g., when an invalid parameter is passed to the function.
