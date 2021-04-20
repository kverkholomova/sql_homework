/*1.	Розробити та перевірити скалярну (scalar) функцію, що повертає загальну вартість книг виданих в певному році.*/

CREATE FUNCTION avgPrice(yearParam INT)
RETURNS DECIMAL
DETERMINISTIC
RETURN (
    SELECT SUM(books.book_price)
    FROM books
    WHERE YEAR(books.book_datee) = yearParam
);

-- SELECT avgPrice(2000);
/*2.	Розробити і перевірити табличну (inline) функцію, яка повертає список книг виданих в певному році.
 - mysql doesn't support returning tables from function*/

-- CREATE FUNCTION getBooks(yearParam INT)
-- RETURNS TABLE
-- DETERMINISTIC
-- RETURN (
--     SELECT *
--     FROM books
--     WHERE YEAR(books.book_date) = yearParam
-- );

/*3.	Розробити і перевірити функцію типу multi-statement, яка буде:
a.	приймати в якості вхідного параметра рядок, що містить список назв видавництв, розділених символом ‘;’;  
b.	виділяти з цього рядка назву видавництва;
c.	формувати нумерований список назв видавництв.

 3 this function also should return table, what isn't supported by mysql*/

/*4.	Виконати набір операцій по роботі з SQL курсором: оголосити курсор;
a.	використовувати змінну для оголошення курсору;
b.	відкрити курсор;
c.	переприсвоїти курсор іншої змінної;
d.	виконати вибірку даних з курсору;
e.	закрити курсор;

5.	звільнити курсор. Розробити курсор для виводу списка книг виданих у визначеному році.
-- 4, 5 - but mysql has limited support of returning tables*/

DELIMITER $$
CREATE PROCEDURE getBooks (
	INOUT bookNamesList varchar(4000),
    IN publishedYear INT
)
BEGIN
    DECLARE finished INTEGER DEFAULT 0;
    DECLARE currBookName varchar(255) DEFAULT "";

    DEClARE yearBooks 
        CURSOR FOR 
            SELECT book_name FROM books WHERE YEAR(books.book_datee) = publishedYear;

    DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET finished = 1;

    OPEN yearBooks;

    getBooksLoop: LOOP
        FETCH yearBooks INTO currBookName;
        IF finished = 1 THEN 
            LEAVE getBooksLoop;
        ELSE
            SET bookNamesList = CONCAT(bookNamesList, ', ', currBookName);
        END IF;
    END LOOP getBooksLoop;
    CLOSE yearBooks;

END$$
DELIMITER ;

SET @bookNames = '';
CALL getBooks(@bookNames, 2000);