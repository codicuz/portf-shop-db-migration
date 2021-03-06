-- DROP TABLE IF EXISTS catalog;
CREATE TABLE catalogs (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) COMMENT 'Название разела'
) COMMENT = 'Разделы интернет-магазина';

-- CREATE TABLE catalogs (
--     id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT, -- Объявление первичного ключна (inline). С авто инкрементом
--     name VARCHAR(255) COMMENT 'Название разела'
-- ) COMMENT = 'Разделы интернет-магазина';

-- CREATE TABLE catalogs (
--     id INT UNSIGNED NOT NULL,
--     name VARCHAR(255) COMMENT 'Название разела',
--     PRIMARY KEY(id) -- Альтернативный способ объявления первичного ключа
-- ) COMMENT = 'Разделы интернет-магазина';

-- CREATE TABLE catalogs (
--     id INT UNSIGNED NOT NULL,
--     name VARCHAR(255) COMMENT 'Название разела',
--     PRIMARY KEY(id, name(10)) -- Будет создан первичный ключ по столбцу id и по первым 10-ти символам столбца name
-- ) COMMENT = 'Разделы интернет-магазина';

-- DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) COMMENT 'Имя покупателя',
    birthday_at DATE COMMENT 'Дата рождения',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

-- DROP TABLE IF EXISTS products;
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) COMMENT 'Название',
    description TEXT COMMENT 'Описание',
    price DECIMAL(11, 2) COMMENT 'Цена',
    catalog_id BIGINT UNSIGNED DEFAULT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY index_of_catalog_id(catalog_id) -- Содание индекса inline
) COMMENT = 'Товарные позиции';

-- ALTER TABLE products ADD CONSTRAINT fk_catalog_id FOREIGN KEY (catalog_id) REFERENCES catalogs (id) ON DELETE CASCADE ON UPDATE CASCADE;

-- CREATE INDEX index_of_catalog_id ON products (catalog_id); -- Создание индекса уже в существующей таблице
-- CREATE INDEX index_of_catalog_id USING BTREE ON products (catalog_id); -- Создание BTREE индекса уже в существующей таблице

-- DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    id SERIAL PRIMARY KEY, 
    user_id INT UNSIGNED,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY index_of_users_id(user_id)
) COMMENT = 'Заказы';

-- DROP TABLE IF IEXISTS orders_products;
CREATE TABLE orders_porducts (
    id SERIAL PRIMARY KEY,
    order_id INT UNSIGNED,
    products_id INT UNSIGNED,
    total INT UNSIGNED DEFAULT 1 COMMENT 'Количество заказанных товарных позиций',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    -- KEY order_id(order_id),
    -- KEY product_id(product_id)
    -- KEY order_id(order_id, product_id), -- Как вариант, используем составной
    -- KEY product_id(product_id, order_id) -- Как вариант, используем составной
) COMMENT = 'Состав заказа';

-- DROP TABLE IF EXISTS discounts;
CREATE TABLE discounts (
    id SERIAL PRIMARY KEY,
    user_id INT UNSIGNED,
    product_id INT UNSIGNED,
    discount FLOAT UNSIGNED COMMENT 'Величина скидки от 0.0 до 1.0',
    started_at DATETIME,
    finished_at DATETIME,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY index_of_id(user_id),
    KEY index_of_product_id(product_id)
) COMMENT = 'Скидки';

-- DROP TABLE IF EXISTS storehouses;
CREATE TABLE storehouses (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) COMMENT 'Название',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Склады';

-- DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
    id SERIAL PRIMARY KEY,
    storehouse_id INT UNSIGNED,
    product_id INT UNSIGNED,
    value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

CREATE TABLE accounts (
    id SERIAL PRIMARY KEY,
    user_id INT,
    total DECIMAL(11,2) COMMENT 'Счет',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Счета пользователей и интернет магазина';

CREATE OR REPLACE VIEW cat AS SELECT * FROM catalogs ORDER BY name ASC;

CREATE OR REPLACE VIEW namecat (id, name, total) AS SELECT ID, NAME, LENGTH(name) FROM catalogs;