/*1.	Вивести значення наступних колонок: назва книги, ціна, назва видавництва, формат.*/
DELIMITER
    //
CREATE PROCEDURE GetBookData()
BEGIN
    SELECT
        books.book_name, book_price, publishing.name AS publishing_name, book_format
    FROM
        books
    JOIN publishing ON books.book_id_publishing = publishing.id
END ;
DELIMITER
    ;
    
    /*2.	Вивести значення наступних колонок: тема, категорія, назва книги, назва видавництва. Фільтр по темам і категоріям.*/
DELIMITER
    //
CREATE PROCEDURE GetBookData2()
BEGIN
    SELECT
        topic.name topic_name, category.name AS category_name, books.book_name AS book_name, book_price, publishing.name AS publishing_name
    FROM
        books
    JOIN publishing ON books.id_publishing = publishing.id
    JOIN topic ON books.id_topic = topic.id
    JOIN category ON books.id_category = category.id
END ;
DELIMITER
    ;

    /*3.	Вивести книги видавництва 'BHV', видані після 2000 р*/
DELIMITER
    //
CREATE PROCEDURE GetBookData3(pub_id INT, year_num INT)
BEGIN
    SELECT
        *
    FROM
        books
    WHERE
        books.book_id_publishing = pub_id AND YEAR(book_datee) > year_num
END ;
DELIMITER
    ;
CALL
    GetBookData4(1, 2000);

    /*4.	Вивести загальну кількість сторінок по кожній назві категорії. Фільтр по спадаючій / зростанню кількості сторінок.*/
DELIMITER
    //
CREATE PROCEDURE GetBookData3(pub_id INT, year_num INT)
BEGIN
    SELECT
        category.name AS category_name,
        SUM(book_pages) AS pages_count
    FROM
        books
    JOIN category ON books.id_category = category.id
    GROUP BY
        category
    ORDER BY
        pages_count ;
END //
DELIMITER
    ;
CALL
    GetBookData4(1, 2000);

    /*5.	Вивести середню вартість книг по темі 'Використання ПК' і категорії 'Linux'.*/
DELIMITER
    //
CREATE PROCEDURE GetBookData5(
    topic_id INT,
    category_id INT,
    OUT COUNT INT
)
BEGIN
    SELECT
        AVG(price)
    INTO COUNT
FROM
    books
WHERE
    books.book_topic = topic_id AND books.book_id_category = category_id ;
END //
DELIMITER
    ;
CALL
    GetBookData5(1, 6, @count);
SELECT
    @count AS avgCount;

    /*6.	Вивести всі дані універсального відношення.*/
DELIMITER
    //
CREATE PROCEDURE GetBookData6()
BEGIN
    SELECT
        books.*, publishing.name AS publishing_name, category.name AS category_name, topic.name AS topic_name
    FROM
        books
    LEFT JOIN publishers ON books.id_publishing = publishing.id
    LEFT JOIN topic ON books.id_topic = topic.id
    LEFT JOIN category ON books.id_category = category.id
END //
DELIMITER
    ;
CALL
    GetBookData6;

    /*7.	Вивести пари книг, що мають однакову кількість сторінок.*/
DELIMITER
    //
CREATE PROCEDURE GetBookData7()
BEGIN
    SELECT DISTINCT
        b.name AS 1_book_name, b2.name 2_book_name
    FROM
        books b
    JOIN books b2 ON
        b.pages = b2.pages AND b.n != b2.n ;
END //
DELIMITER
    ;
CALL
    GetBookData7;

    /*8.	Вивести тріади книг, що мають однакову ціну.*/
DELIMITER
    //
CREATE PROCEDURE GetBookData8()
BEGIN
    SELECT DISTINCT
        b.name AS 1 _book_name, b2.name 2 _book_name, b3.name 3 _book_name
    FROM
        books b
    JOIN books b2 ON
        b.price = b2.price AND b.n != b2.n
    JOIN books b3 ON
        b.price = b3.price AND b.n != b3.n ;
END //
DELIMITER
    ;
CALL
    GetBookData8;

    /*9.	Вивести всі книги категорії 'C ++'.*/
DELIMITER
    //
CREATE PROCEDURE GetBookData9(category_name VARCHAR(255))
BEGIN
    SELECT
        *
    FROM
        books
    WHERE
        category =(
        SELECT
            id
        FROM
            category
        WHERE
            category.name = category_name
    END //
DELIMITER
    ;
CALL
    GetBookData9('C&C++');

    /*10.	Вивести список видавництв, у яких розмір книг перевищує 400 сторінок.*/
DELIMITER
    //
CREATE PROCEDURE GetBookData10(min_pages_count INT)
BEGIN
    SELECT
        *
    FROM
        publishing
    WHERE
        (
        SELECT
            MIN(book_pages)
        FROM
            books
        WHERE
            books.book_id_publishing = publishing.id
    ) > min_pages_count ;
END //
DELIMITER
    ;
CALL
    GetBookData10(400);

    /*11.	Вивести список категорій за якими більше 3-х книг.*/
DELIMITER
    //
CREATE PROCEDURE GetBookData11(min_books_count INT)
BEGIN
    SELECT
        *
    FROM
        category
    WHERE
        (
        SELECT
            COUNT(*)
        FROM
            books
        WHERE
            books.book_id_category = category.id
    ) > min_books_count ;
END //
DELIMITER
    ;
CALL
    GetBookData11(3);

    /*12.	Вивести список книг видавництва 'BHV', якщо в списку є хоча б одна книга цього видавництва.*/
DELIMITER
    //
CREATE PROCEDURE GetBookData12(publisher_name VARCHAR(255))
BEGIN
    SELECT
        *
    FROM
        books
    WHERE EXISTS
        (
        SELECT
            *
        FROM
            publishing
        WHERE
            publishing.name = publisher_name AND books.book_id_publishing = publishing.id
    ) ;
END //
DELIMITER
    ;
CALL
    GetBookData12('BHV С.-Петербург');

    /*13.	Вивести список книг видавництва 'BHV', якщо в списку немає жодної книги цього видавництва.*/
DELIMITER
    //
CREATE PROCEDURE GetBookData13(publisher_name VARCHAR(255))
BEGIN
    SELECT
        *
    FROM
        books
    WHERE NOT EXISTS
        (
        SELECT
            *
        FROM
            publishing
        WHERE
            publishing.name = publisher_name AND books.book_id_publishing = publishing.id
    ) AND id_publishing =(
    SELECT
        publishing.id
    FROM
        publishing
    WHERE
        publishing.name = publisher_name
) ;
END //
DELIMITER
    ;
CALL
    GetBookData13('BHV С.-Петербург');

    /*14.	Вивести відсортоване загальний список назв тем і категорій.*/
DELIMITER
    //
CREATE PROCEDURE GetBookData14()
BEGIN
        (
            (
        SELECT
            *
        FROM
            topic
        )
    UNION
        (
    SELECT
        *
    FROM
        category
    )
        )
    ORDER BY NAME
        ;
    END //
DELIMITER
    ;
CALL
    GetBookData14();

    /*15.	Вивести відсортований в зворотному порядку загальний список перших слів назв книг і категорій що не повторюються*/
DELIMITER
    //
CREATE PROCEDURE GetBookData15()
BEGIN
    SELECT DISTINCT NAME
FROM
    (
        (
        SELECT
            REGEXP_SUBSTR(TRIM(NAME),
            '^[^\\s]+') AS NAME
        FROM
            books
    )
UNION ALL
    (
    SELECT
        REGEXP_SUBSTR(TRIM(NAME),
        '^[^\\s]+') AS NAME
    FROM
        category
)
    ) NAMES
ORDER BY NAME
DESC
    ;
END //
DELIMITER
    ;
CALL
    GetBookData15();