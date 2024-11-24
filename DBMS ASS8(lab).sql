CREATE TABLE Library (
    book_id NUMBER PRIMARY KEY,
    title VARCHAR2(100),
    author VARCHAR2(100),
    publish_year NUMBER
);

drop table Library;

INSERT INTO Library (book_id, title, author, publish_year)
VALUES (1, 'Book 1', 'Author 1', 2020);

INSERT INTO Library (book_id, title, author, publish_year)
VALUES (2, 'Book 2', 'Author 2', 2015);

INSERT INTO Library (book_id, title, author, publish_year)
VALUES (3, 'Book 3', 'Author 3', 2018);

CREATE TABLE LibraryAudit (
    audit_id NUMBER PRIMARY KEY,
    action_type VARCHAR2(10),
    old_book_id NUMBER,
    old_title VARCHAR2(100),
    old_author VARCHAR2(100),
    audit_date TIMESTAMP
);

CREATE OR REPLACE TRIGGER Library_BeforeUpdate
BEFORE UPDATE ON Library FOR EACH ROW
BEGIN
    INSERT INTO LibraryAudit (audit_id, action_type, old_book_id, old_title, old_author, audit_date)
    VALUES (:OLD.book_id, 'UPDATE', :OLD.book_id, :OLD.title, :OLD.author, SYSTIMESTAMP);
END;
/

CREATE OR REPLACE TRIGGER Library_AfterUpdate
AFTER UPDATE ON Library FOR EACH ROW
BEGIN
    NULL;
END;
/

CREATE OR REPLACE TRIGGER Library_BeforeDelete
BEFORE DELETE ON Library
FOR EACH ROW
BEGIN
    INSERT INTO LibraryAudit (audit_id, action_type, old_book_id, old_title, old_author, audit_date)
    VALUES (:OLD.book_id, 'DELETE', :OLD.book_id, :OLD.title, :OLD.author, SYSTIMESTAMP);
END;
/

CREATE OR REPLACE TRIGGER Library_AfterDelete
AFTER DELETE ON Library FOR EACH ROW
BEGIN
    NULL;
END;
/

UPDATE Library
SET title = 'Updated Title'
WHERE book_id = 1;

DELETE FROM Library
WHERE book_id = 2;

SELECT * FROM Library;

SELECT * FROM LibraryAudit;