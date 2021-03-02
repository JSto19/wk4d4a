--Table 1
CREATE TABLE customer(
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(25),
	last_name VARCHAR(25),
	phone VARCHAR(15)
);
--Table 2
CREATE TABLE sales_person(
	sales_person_id SERIAL PRIMARY KEY,
	first_name VARCHAR(25),
	last_name VARCHAR(25)
);
--Table 3
CREATE TABLE mechanic(
	mech_staff_id SERIAL PRIMARY KEY,
	first_name VARCHAR(25),
	last_name VARCHAR(25)
);
--Table 4
CREATE TABLE vehicle(
	serial_num SERIAL PRIMARY KEY,
	make VARCHAR(25),
	model VARCHAR(25),
	price NUMERIC(10,2),
	year_ INT,
	used BOOLEAN,
	sold BOOLEAN
);
--Table 5
CREATE TABLE parts(
	part_id SERIAL PRIMARY KEY,
	part_name VARCHAR(25),
	part_price NUMERIC(6,2)
);
--Table 6
CREATE TABLE sale(
	sale_id SERIAL PRIMARY KEY,
	sale_amount NUMERIC(8,2),
	loan_sale NUMERIC(20,2),
	serial_num INT,
	FOREIGN KEY(serial_num) REFERENCES vehicle(serial_num)
);
--Table 7
CREATE TABLE services(
	service_id SERIAL PRIMARY KEY,
	service_amount NUMERIC(4,2),
	task VARCHAR(25),
	part_id INT,
	FOREIGN KEY(part_id) REFERENCES parts(part_id)
);
--Table 8
CREATE TABLE mechanic_services(
	mech_services_id SERIAL PRIMARY KEY,
	service_id INT,
	FOREIGN KEY (service_id) REFERENCES services(service_id),
	mech_staff_id INT,
	FOREIGN KEY (mech_staff_id) REFERENCES mechanic(mech_staff_id)
);
--Table 9
CREATE TABLE invoice(
	invoice_id SERIAL PRIMARY KEY,
	customer_id INT,
	FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
	sales_person_id INT,
	FOREIGN KEY (sales_person_id) REFERENCES sales_person(sales_person_id),
	sale_id INT,
	FOREIGN KEY (sale_id) REFERENCES sale(sale_id),
	service_id INT,
	FOREIGN KEY (service_id) REFERENCES services(service_id),
	date_ TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
--Input Data for tables
INSERT INTO customer(
	first_name,
	last_name,
	phone
)
VALUES(
	'Momma',
	'Stoneman',
	'(608)123-6789)'
),
(
	'Larry',
	'Stoneman',
	'(608)123-6789)'
),
(
	'Si',
	'Stoneman',
	'(608)123-6789)'
),
(
	'Bodero',
	'Borre',
	'(217)623-8456)'
);
INSERT INTO sales_person(
	first_name,
	last_name
)
VALUES(
	'Jeff',
	'El'
),
(
	'Jomoma',
	'Saidso'
),
(
	'Bo',
	'Didley'
),
(
	'Bad',
	'Breaking'
);
INSERT INTO mechanic(
	first_name,
	last_name
)
VALUES(
	'Sherwin',
	'Williams'
),
(
	'Monty',
	'Python'
),
(
	'Theguyfrom',
	'Downperiscope'
),
(
	'W40K',
	'Techpriest'
),
(
	'Rain',
	'Man'
);
INSERT INTO vehicle(
	make,
	model,
	price,
	year_,
	used,
	sold
)
VALUES(
	'Jeep',
	'Wrangler Rubicon',
	12000.00,
	2005,
	TRUE,
	FALSE
),
(
	'Honda',
	'CRV-Supra',
	4000.00,
	1986,
	TRUE,
	FALSE
),
(
	'GM',
	'E-Humvee',
	112000.00,
	2021,
	FALSE,
	FALSE
);
INSERT INTO parts(
	part_name,
	part_price
)
VALUES(
	'E-Battery EHUM',
	999.99
),
(
	'EHum main comp',
	999.99
),
(
	'Jeep lift kit',
	799.99
),
(
	'Syn Oil per change',
	69.99
),
(
	'Regular Oil',
	39.99
),
(
	'Tires EHum',
	229.99
),
(
	'Tires',
	115.99
),(
	'Tires Jeep',
	149.99
),
(
	'Set Tires EHum',
	669.99
),
(
	'Jeep Set Tires',
	459.99
),
(
	'Reg Set Tires',
	399.99
);
INSERT INTO sale(
	sale_amount,
	loan_sale,
	serial_num
)
VALUES(
	12000.00,
	0.00,
	1
);
INSERT INTO services(
	service_amount,
	task,
	part_id
)
VALUES(
	69.99,
	'Oil Change',
	1
),
(
	89.99,
	'Tuneup',
	2
),	
(
	59.99,
	'Fluid, system, tire check',
	Null
);
INSERT INTO mechanic_services(
	service_id,
	mech_staff_id
)
VALUES(
	1,
	1
),
(
	2,
	4
);
INSERT INTO invoice(
	customer_id,
	sales_person_id,
	sale_id,
	service_id
)
VALUES(
	1,
	1,
	1,
	NULL
),
(
	3,
	2,
	NULL,
	1
),
(
	2,
	3,
	NULL,
	2
);
-- Function to check data
CREATE OR REPLACE PROCEDURE vehiclePurchase(
	serial_number INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN 
	UPDATE vehicle
	SET sold = TRUE
	WHERE serial_num = serial_number;
	
	COMMIT;
	
END;
$$