-- criação de base multidimensional

CREATE TABLE dwprojetov2.dim_date (
                sk_date INTEGER NOT NULL,
                nk_date DATE NOT NULL,
                order_delivered_customer_date TIMESTAMP,
                order_estimated_delivery_date TIMESTAMP NOT NULL,
                CONSTRAINT sk_date PRIMARY KEY (sk_date)
);


CREATE TABLE dwprojetov2.dim_itemproducts (
                sk_itens INTEGER NOT NULL,
                nk_itens INTEGER NOT NULL,
                nk_order VARCHAR(50) NOT NULL,
                nk_product VARCHAR(50) NOT NULL,
                product_category_name VARCHAR(50),
                price REAL NOT NULL,
                seller_id VARCHAR(50) NOT NULL,
                seller_city VARCHAR(50) NOT NULL,
                seller_state VARCHAR(2) NOT NULL,
                CONSTRAINT sk_itens PRIMARY KEY (sk_itens)
);


CREATE TABLE dwprojetov2.dim_customer (
                sk_customer INTEGER NOT NULL,
                nk_customer VARCHAR(50) NOT NULL,
                customer_city VARCHAR(50) NOT NULL,
                customer_state VARCHAR(2) NOT NULL,
                CONSTRAINT sk_customer PRIMARY KEY (sk_customer)
);


CREATE TABLE dwprojetov2.dim_payment (
                sk_payment INTEGER NOT NULL,
                nk_payment INTEGER NOT NULL,
                payment_type VARCHAR(20),
                payment_value REAL,
                CONSTRAINT sk_payment PRIMARY KEY (sk_payment)
);


CREATE TABLE dwprojetov2.fact_orders (
                sk_payment INTEGER NOT NULL,
                sk_itens INTEGER NOT NULL,
                sk_customer INTEGER NOT NULL,
                sk_date INTEGER NOT NULL,
                order_status VARCHAR(20) NOT NULL--,
                --CONSTRAINT sk_orders PRIMARY KEY (sk_payment, sk_itens, sk_customer, sk_date)
);


ALTER TABLE dwprojetov2.fact_orders ADD CONSTRAINT dim_date_fact_orders_fk
FOREIGN KEY (sk_date)
REFERENCES dwprojetov2.dim_date (sk_date)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE dwprojetov2.fact_orders ADD CONSTRAINT dim_itens_fact_orders_fk
FOREIGN KEY (sk_itens)
REFERENCES dwprojetov2.dim_itemproducts (sk_itens)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE dwprojetov2.fact_orders ADD CONSTRAINT dim_customer_fact_orders_fk
FOREIGN KEY (sk_customer)
REFERENCES dwprojetov2.dim_customer (sk_customer)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE dwprojetov2.fact_orders ADD CONSTRAINT dim_payment_fact_orders_fk
FOREIGN KEY (sk_payment)
REFERENCES dwprojetov2.dim_payment (sk_payment)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
