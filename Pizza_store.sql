-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/cJhJeo
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE `orders` (
    `row_id` int  NOT NULL ,
    `order_id` varchar(10)  NOT NULL ,
    `created_at` date  NOT NULL ,
    `quantity` int  NOT NULL ,
    `cust_id` int  NOT NULL ,
    `item_id` int(10)  NOT NULL ,
    `delivery` boolean  NOT NULL ,
    `add_id` int  NOT NULL ,
    PRIMARY KEY (
        `row_id`
    )
);

CREATE TABLE `customers` (
    `cust_id` int  NOT NULL ,
    `cust_first_name` varchar(50)  NOT NULL ,
    `cust_last_name` varchar(50)  NOT NULL ,
    PRIMARY KEY (
        `cust_id`
    )
);

CREATE TABLE `address` (
    `add_id` int  NOT NULL ,
    `delivery_address1` varchar(200)  NOT NULL ,
    `delivery_address2` varchar(200)  NOT NULL ,
    `delivery_ciy` varchar(50)  NOT NULL ,
    `delivery_zip` varchar(50)  NOT NULL ,
    PRIMARY KEY (
        `add_id`
    )
);

CREATE TABLE `item` (
    `item_id` int  NOT NULL ,
    `sku` varchar(50)  NOT NULL ,
    `item_name` varchar(50)  NOT NULL ,
    `item_cat` varchar(50)  NOT NULL ,
    `item_size` varchar(20)  NOT NULL ,
    `item_price` decimal(6,2)  NOT NULL ,
    PRIMARY KEY (
        `item_id`
    )
);

CREATE TABLE `ingredients` (
    `ing_id` varchar(10)  NOT NULL ,
    `ing_name` varchar(200)  NOT NULL ,
    `ing_weight` int  NOT NULL ,
    `ing_mas` varchar(20)  NOT NULL 
);

CREATE TABLE `recepie` (
    `row_id` int  NOT NULL ,
    `recipe_id` varchar(50)  NOT NULL ,
    `ing_id` varchar(10)  NOT NULL ,
    `quantity` int  NOT NULL ,
    PRIMARY KEY (
        `row_id`
    )
);

CREATE TABLE `inventory` (
    `inventory_id` int  NOT NULL ,
    `item_id` varchar(10)  NOT NULL ,
    `quantity` int  NOT NULL ,
    PRIMARY KEY (
        `inventory_id`
    )
);

CREATE TABLE `staf` (
    `staff_id` varchar(20)  NOT NULL ,
    `first_name` varchar(20)  NOT NULL ,
    `last_name` varchar(50)  NOT NULL ,
    `position` varchar(100)  NOT NULL ,
    `hourly_rate` decima(5,2)  NOT NULL ,
    PRIMARY KEY (
        `staff_id`
    )
);

CREATE TABLE `rota` (
    `row_id` int  NOT NULL ,
    `rota_id` varchar(20)  NOT NULL ,
    `date` datetime  NOT NULL ,
    `shift_id` varchar(20)  NOT NULL ,
    `staff_id` varchar(20)  NOT NULL ,
    PRIMARY KEY (
        `row_id`
    )
);

CREATE TABLE `shift` (
    `shift_id` varchar(20)  NOT NULL ,
    `day_of_week` varchar(20)  NOT NULL ,
    `start_time` time  NOT NULL ,
    `end_time` time  NOT NULL ,
    PRIMARY KEY (
        `shift_id`
    )
);

ALTER TABLE `orders` ADD CONSTRAINT `fk_orders_item_id` FOREIGN KEY(`item_id`)
REFERENCES `item` (`item_id`);

ALTER TABLE `customers` ADD CONSTRAINT `fk_customers_cust_id` FOREIGN KEY(`cust_id`)
REFERENCES `orders` (`cust_id`);

ALTER TABLE `address` ADD CONSTRAINT `fk_address_add_id` FOREIGN KEY(`add_id`)
REFERENCES `orders` (`add_id`);

ALTER TABLE `item` ADD CONSTRAINT `fk_item_sku` FOREIGN KEY(`sku`)
REFERENCES `recepie` (`recipe_id`);

ALTER TABLE `recepie` ADD CONSTRAINT `fk_recepie_recipe_id` FOREIGN KEY(`recipe_id`)
REFERENCES `inventory` (`item_id`);

ALTER TABLE `recepie` ADD CONSTRAINT `fk_recepie_ing_id` FOREIGN KEY(`ing_id`)
REFERENCES `ingredients` (`ing_id`);

ALTER TABLE `rota` ADD CONSTRAINT `fk_rota_date` FOREIGN KEY(`date`)
REFERENCES `orders` (`created_at`);

ALTER TABLE `rota` ADD CONSTRAINT `fk_rota_shift_id` FOREIGN KEY(`shift_id`)
REFERENCES `shift` (`shift_id`);

ALTER TABLE `rota` ADD CONSTRAINT `fk_rota_staff_id` FOREIGN KEY(`staff_id`)
REFERENCES `staf` (`staff_id`);

