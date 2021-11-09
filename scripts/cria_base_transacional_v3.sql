-- Criação de base transacional
CREATE TABLE customer (
                customer_id VARCHAR(50) NOT NULL,
                customer_unique_id VARCHAR(50) NOT NULL,
                zip_code_prefix NUMERIC(6) NOT NULL,
                customer_city VARCHAR(50) NOT NULL,
                customer_state VARCHAR(2) NOT NULL,
                CONSTRAINT customer_id PRIMARY KEY (customer_id)
);


CREATE TABLE sellers (
                seller_id VARCHAR(50) NOT NULL,
                zip_code_prefix NUMERIC(6) NOT NULL,
                seller_city VARCHAR(50) NOT NULL,
                seller_state VARCHAR(2) NOT NULL,
                CONSTRAINT seller_id PRIMARY KEY (seller_id)
);


CREATE TABLE orders (
                order_id VARCHAR(50) NOT NULL,
                customer_id VARCHAR(50) NOT NULL,
                order_status VARCHAR(20) NOT NULL,
                order_purchase_timestamp TIMESTAMP NOT NULL,
                order_approved_at TIMESTAMP,
                order_delivered_carrier_date TIMESTAMP,
                order_delivered_customer_date TIMESTAMP,
                order_estimated_delivery_date DATE NOT NULL,
                CONSTRAINT order_id PRIMARY KEY (order_id)
);


CREATE TABLE order_reviews (
                review_id INTEGER NOT NULL,
                order_id VARCHAR(50) NOT NULL,
                review_score INTEGER,
                review_comment_title VARCHAR(50),
                review_comment_message VARCHAR(500),
                review_creation_date DATE,
                review_answer_timestamp TIMESTAMP,
                CONSTRAINT review_id PRIMARY KEY (review_id)
);


CREATE TABLE products (
                product_id VARCHAR(50) NOT NULL,
                product_category_name VARCHAR(50),
                product_name_lenght INTEGER,
                product_description_lenght INTEGER,
                product_photos_qty INTEGER,
                product_weight_g INTEGER,
                product_length_cm INTEGER,
                product_height_cm INTEGER,
                product_width_cm INTEGER,
                CONSTRAINT product_id PRIMARY KEY (product_id)
);


CREATE SEQUENCE order_items_item_id_seq;

CREATE TABLE order_items (
                item_id INTEGER NOT NULL DEFAULT nextval('order_items_item_id_seq'),
                order_id VARCHAR(50) NOT NULL,
                order_item_id VARCHAR(50) NOT NULL,
                product_id VARCHAR(50) NOT NULL,
                seller_id VARCHAR(50) NOT NULL,
                shipping_limit_date DATE NOT NULL,
                price REAL NOT NULL,
                freight_value REAL NOT NULL,
                CONSTRAINT item_id PRIMARY KEY (item_id)
);


ALTER SEQUENCE order_items_item_id_seq OWNED BY order_items.item_id;

CREATE SEQUENCE order_payments_payment_id_seq;

CREATE TABLE order_payments (
                payment_id INTEGER NOT NULL DEFAULT nextval('order_payments_payment_id_seq'),
                order_id VARCHAR(50) NOT NULL,
                payment_sequential INTEGER NOT NULL,
                payment_type VARCHAR(20),
                payment_installments INTEGER,
                payment_value REAL,
                CONSTRAINT payment_id PRIMARY KEY (payment_id)
);


ALTER SEQUENCE order_payments_payment_id_seq OWNED BY order_payments.payment_id;

ALTER TABLE orders ADD CONSTRAINT customer_orders_fk
FOREIGN KEY (customer_id)
REFERENCES customer (customer_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE order_items ADD CONSTRAINT sellers_order_items_fk
FOREIGN KEY (seller_id)
REFERENCES sellers (seller_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE order_reviews ADD CONSTRAINT orders_order_reviews_fk
FOREIGN KEY (order_id)
REFERENCES orders (order_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE order_items ADD CONSTRAINT orders_order_items_fk
FOREIGN KEY (order_id)
REFERENCES orders (order_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE order_payments ADD CONSTRAINT orders_order_payments_fk
FOREIGN KEY (order_id)
REFERENCES orders (order_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE order_items ADD CONSTRAINT products_order_items_fk
FOREIGN KEY (product_id)
REFERENCES products (product_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
