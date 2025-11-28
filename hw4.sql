-- Завдання 1. Створення БД та таблиць

DROP DATABASE IF EXISTS librarymanagement;
CREATE DATABASE librarymanagement;
USE librarymanagement;

CREATE TABLE authors (
    author_id   INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(100) NOT NULL
);

CREATE TABLE genres (
    genre_id   INT AUTO_INCREMENT PRIMARY KEY,
    genre_name VARCHAR(100) NOT NULL
);

CREATE TABLE books (
    book_id          INT AUTO_INCREMENT PRIMARY KEY,
    title            VARCHAR(200) NOT NULL,
    publication_year YEAR,
    author_id        INT,
    genre_id         INT,
    FOREIGN KEY (author_id) REFERENCES authors(author_id),
    FOREIGN KEY (genre_id)  REFERENCES genres(genre_id)
);

CREATE TABLE users (
    user_id  INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    email    VARCHAR(150) NOT NULL
);

CREATE TABLE borrowed_books (
    borrow_id   INT AUTO_INCREMENT PRIMARY KEY,
    book_id     INT NOT NULL,
    user_id     INT NOT NULL,
    borrow_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Завдання 2. Тестові дані

INSERT INTO authors (author_name) VALUES
('Тарас Шевченко'),
('Агата Крісті');

INSERT INTO genres (genre_name) VALUES
('Поезія'),
('Детектив');

INSERT INTO books (title, publication_year, author_id, genre_id) VALUES
('Кобзар', 1901, 1, 1),
('Вбивство у Східному експресі', 1934, 2, 2);

INSERT INTO users (username, email) VALUES
('ivan_petrenko', 'ivan@example.com'),
('olena_sydorenko', 'olena@example.com');

INSERT INTO borrowed_books (book_id, user_id, borrow_date, return_date) VALUES
(1, 1, '2025-11-01', NULL),
(2, 2, '2025-11-10', '2025-11-22');

-- Завдання 3. Запит до Теми 3

USE goit_rdb_hw_03;

SELECT
    od.*,
    o.*,
    c.*,
    p.*,
    cat.*,
    e.*,
    sh.*,
    s.*
FROM order_details AS od
INNER JOIN orders AS o
    ON od.order_id = o.id
INNER JOIN customers AS c
    ON o.customer_id = c.id
INNER JOIN employees AS e
    ON o.employee_id = e.employee_id
INNER JOIN products AS p
    ON od.product_id = p.id
INNER JOIN categories AS cat
    ON p.category_id = cat.id
INNER JOIN shippers AS sh
    ON o.shipper_id = sh.id
INNER JOIN suppliers AS s
    ON p.supplier_id = s.id;

-- Завдання 4. Виконання запитів

-- Завдання 4.1. Порахувати кількість рядків (COUNT)

SELECT COUNT(*) AS total_rows
FROM order_details AS od
INNER JOIN orders AS o
    ON od.order_id = o.id
INNER JOIN customers AS c
    ON o.customer_id = c.id
INNER JOIN employees AS e
    ON o.employee_id = e.employee_id
INNER JOIN products AS p
    ON od.product_id = p.id
INNER JOIN categories AS cat
    ON p.category_id = cat.id
INNER JOIN shippers AS sh
    ON o.shipper_id = sh.id
INNER JOIN suppliers AS s
    ON p.supplier_id = s.id;

-- Завдання 4.2. Замінити кілька INNER на LEFT/RIGHT і знову порахувати рядки

SELECT COUNT(*) AS total_rows_left
FROM order_details AS od
LEFT JOIN orders AS o
    ON od.order_id = o.id
LEFT JOIN customers AS c
    ON o.customer_id = c.id
LEFT JOIN employees AS e
    ON o.employee_id = e.employee_id
LEFT JOIN products AS p
    ON od.product_id = p.id
LEFT JOIN categories AS cat
    ON p.category_id = cat.id
LEFT JOIN shippers AS sh
    ON o.shipper_id = sh.id
LEFT JOIN suppliers AS s
    ON p.supplier_id = s.id;

-- Завдання 4.3 Вибрати тільки рядки, де employee_id > 3 та ≤ 10

SELECT
    od.*,
    o.*,
    c.*,
    p.*,
    cat.*,
    e.*,
    sh.*,
    s.*
FROM order_details AS od
INNER JOIN orders AS o
    ON od.order_id = o.id
INNER JOIN customers AS c
    ON o.customer_id = c.id
INNER JOIN employees AS e
    ON o.employee_id = e.employee_id
INNER JOIN products AS p
    ON od.product_id = p.id
INNER JOIN categories AS cat
    ON p.category_id = cat.id
INNER JOIN shippers AS sh
    ON o.shipper_id = sh.id
INNER JOIN suppliers AS s
    ON p.supplier_id = s.id
WHERE e.employee_id > 3
  AND e.employee_id <= 10;

-- Завдання 4.4 GROUP BY за назвою категорії, COUNT + AVG(quantity)

SELECT
    cat.name       AS category_name,
    COUNT(*)       AS rows_count,
    AVG(od.quantity) AS avg_quantity
FROM order_details AS od
INNER JOIN orders AS o
    ON od.order_id = o.id
INNER JOIN customers AS c
    ON o.customer_id = c.id
INNER JOIN employees AS e
    ON o.employee_id = e.employee_id
INNER JOIN products AS p
    ON od.product_id = p.id
INNER JOIN categories AS cat
    ON p.category_id = cat.id
INNER JOIN shippers AS sh
    ON o.shipper_id = sh.id
INNER JOIN suppliers AS s
    ON p.supplier_id = s.id
GROUP BY cat.name;

-- Завдання 4.5 HAVING: середня кількість товару > 21

SELECT
    cat.name       AS category_name,
    COUNT(*)       AS rows_count,
    AVG(od.quantity) AS avg_quantity
FROM order_details AS od
INNER JOIN orders AS o
    ON od.order_id = o.id
INNER JOIN customers AS c
    ON o.customer_id = c.id
INNER JOIN employees AS e
    ON o.employee_id = e.employee_id
INNER JOIN products AS p
    ON od.product_id = p.id
INNER JOIN categories AS cat
    ON p.category_id = cat.id
INNER JOIN shippers AS sh
    ON o.shipper_id = sh.id
INNER JOIN suppliers AS s
    ON p.supplier_id = s.id
GROUP BY cat.name
HAVING AVG(od.quantity) > 21;

-- Завдання 4.6 Відсортувати за спаданням кількості рядків

SELECT
    cat.name       AS category_name,
    COUNT(*)       AS rows_count,
    AVG(od.quantity) AS avg_quantity
FROM order_details AS od
INNER JOIN orders AS o
    ON od.order_id = o.id
INNER JOIN customers AS c
    ON o.customer_id = c.id
INNER JOIN employees AS e
    ON o.employee_id = e.employee_id
INNER JOIN products AS p
    ON od.product_id = p.id
INNER JOIN categories AS cat
    ON p.category_id = cat.id
INNER JOIN shippers AS sh
    ON o.shipper_id = sh.id
INNER JOIN suppliers AS s
    ON p.supplier_id = s.id
GROUP BY cat.name
HAVING AVG(od.quantity) > 21
ORDER BY rows_count DESC;

-- Завдання 4.7 Вивести 4 рядки, пропустивши перший (LIMIT + OFFSET)

SELECT
    cat.name       AS category_name,
    COUNT(*)       AS rows_count,
    AVG(od.quantity) AS avg_quantity
FROM order_details AS od
INNER JOIN orders AS o
    ON od.order_id = o.id
INNER JOIN customers AS c
    ON o.customer_id = c.id
INNER JOIN employees AS e
    ON o.employee_id = e.employee_id
INNER JOIN products AS p
    ON od.product_id = p.id
INNER JOIN categories AS cat
    ON p.category_id = cat.id
INNER JOIN shippers AS sh
    ON o.shipper_id = sh.id
INNER JOIN suppliers AS s
    ON p.supplier_id = s.id
GROUP BY cat.name
HAVING AVG(od.quantity) > 21
ORDER BY rows_count DESC
LIMIT 4 OFFSET 1;
