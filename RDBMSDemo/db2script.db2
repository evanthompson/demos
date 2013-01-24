--DROP database ass4;
CREATE database ass4;
CONNECT to ass4;

DROP TABLE sales_person;
DROP TABLE supervisor;
DROP TABLE leg_rep;
DROP TABLE quote;
DROP TABLE quote_products;
DROP TABLE sale;
DROP TABLE customer;
DROP TABLE company;
DROP TABLE individual;
DROP TABLE product;
DROP TABLE computer_part;
DROP TABLE computer;
DROP TABLE accessory;
DROP TABLE contains;

CREATE TABLE supervisor(
	id_sup INT NOT NULL,
	name VARCHAR(32),
	PRIMARY KEY (id_sup)
);

CREATE TABLE sales_person (
	id_sales INT NOT NULL,
	id_sup INT NOT NULL,
	name VARCHAR(32), 
	position VARCHAR(32), 
	base_salary DECIMAL(7,2), 
	sales_made INT,
	PRIMARY KEY (id_sales),
	FOREIGN KEY (id_sup) REFERENCES supervisor(id_sup)
);

CREATE TABLE customer (
	id_c INT NOT NULL,
	name VARCHAR(32),
	address VARCHAR(32),
	work_phone BIGINT,
	PRIMARY KEY (id_c)
);

CREATE TABLE leg_rep(
	id_law INT NOT NULL,
	id_c INT,
	name VARCHAR(32),
	work_phone BIGINT,
	PRIMARY KEY (id_law),
	FOREIGN KEY (id_c) REFERENCES customer (id_c)
);

CREATE TABLE company (
	id_com INT NOT NULL,
	id_c INT NOT NULL,
	id_law INT NOT NULL,
	PRIMARY KEY (id_com),
	FOREIGN KEY (id_c) REFERENCES customer (id_c),
	FOREIGN KEY (id_law) REFERENCES leg_rep (id_law)
);

CREATE TABLE individual(
	id_ind INT NOT NULL,
	id_c INT NOT NULL,
	mobile_phone BIGINT,
	home_phone BIGINT,
	email VARCHAR(32),
	PRIMARY KEY (id_ind),
	FOREIGN KEY (id_c) REFERENCES customer (id_c)
);

CREATE TABLE product(
	product_code INT NOT NULL,
	description VARCHAR(50),
	price DECIMAL(7,2),
	name VARCHAR(32),
	PRIMARY KEY (product_code)
);

CREATE TABLE computer_part(
	product_code INT NOT NULL,
	serial_num VARCHAR(32),
	PRIMARY KEY (product_code),
	FOREIGN KEY (product_code) REFERENCES product (product_code)
);

CREATE TABLE computer(
	product_code INT NOT NULL,
	type VARCHAR(32),
	PRIMARY KEY (product_code),
	FOREIGN KEY (product_code) REFERENCES product (product_code)
);

CREATE TABLE accessory(
	product_code INT NOT NULL,
	stock INT,
	PRIMARY KEY (product_code),
	FOREIGN KEY (product_code) REFERENCES product (product_code)

);

CREATE TABLE contains(
	part_product_code INT NOT NULL,
	comp_product_code INT NOT NULL,
	PRIMARY KEY (part_product_code, comp_product_code),
	FOREIGN KEY (part_product_code) REFERENCES computer_part(product_code),
	FOREIGN KEY (comp_product_code) REFERENCES computer(product_code)
);

CREATE TABLE quote (
	qc_code INT NOT NULL,
	price DECIMAL(7,2),
	id_c INT NOT NULL,
	id_sales INT NOT NULL,
	PRIMARY KEY (qc_code),
	FOREIGN KEY (id_c) REFERENCES customer (id_c),
	FOREIGN KEY (id_sales) REFERENCES sales_person (id_sales)
);

CREATE TABLE quote_products (
	qc_code INT NOT NULL,
	product_code INT NOT NULL,
	quantity INT NOT NULL,
	PRIMARY KEY (qc_code, product_code),
	FOREIGN KEY (qc_code) REFERENCES quote(qc_code),
	FOREIGN KEY (product_code) REFERENCES product(product_code)
);

CREATE TABLE sale (
	qc_code INT NOT NULL,
	final_sale DECIMAL(7,2),
	discount DECIMAL(7,2),
	sale_date TIMESTAMP,
	PRIMARY KEY (qc_code),
	FOREIGN KEY (qc_code) REFERENCES sale (qc_code)
);

INSERT INTO customer VALUES (100, 'Evan Thompson', 'Ottawa! Say what?','6135551234');
INSERT INTO customer VALUES (101, 'Mike Martino', 'North Bay','6135551235');
INSERT INTO customer VALUES (102, 'Vin Diesel', 'California','6135551236');
INSERT INTO customer VALUES (103, 'Paul Walker', 'California','6135551237');
INSERT INTO customer VALUES (104, 'James Caan', 'Ohio','6135551238');
INSERT INTO customer VALUES (105, 'Nortel', 'Ottawa','6135351234');
INSERT INTO customer VALUES (106, 'Mr.Peanut', 'Halifax','6135551115');
INSERT INTO customer VALUES (107, 'BiotechInc', 'New York','6135297627');
INSERT INTO customer VALUES (108, 'Stick To It', 'New Zealand','2191392012');
INSERT INTO customer VALUES (109, 'FrenchFry Face', 'Denmark','3242551238');

INSERT INTO individual VALUES (200,100,6131234567,6131231234,'et@phonehome.com');
INSERT INTO individual VALUES (201,101,6131234568,6131123234,'mm@phonehome.com');
INSERT INTO individual VALUES (202,102,6131234569,6131277234,'vin@phonehome.com');
INSERT INTO individual VALUES (203,103,6131234560,6131231774,'pw@phonehome.com');
INSERT INTO individual VALUES (204,104,6131234561,6131231277,'JC@phonehome.com');

INSERT INTO leg_rep VALUES (300, 102, 'Vin Diesel', 6135551233);
INSERT INTO leg_rep VALUES (301, 103, 'Paul Walker', 6135551666);
INSERT INTO leg_rep VALUES (302, 104, 'James Caan', 6135552338);
INSERT INTO leg_rep VALUES (303, NULL, 'Alex Spatouski', 6131351234);
INSERT INTO leg_rep VALUES (304, NULL, 'Lee Elroy', 8273048826);
INSERT INTO leg_rep VALUES (305, NULL, 'Quel Quune', 9996870092);
INSERT INTO leg_rep VALUES (306, NULL, 'Uno Notre', 1172283399);
INSERT INTO leg_rep VALUES (307, NULL, 'Mr. Dernier', 6782637715);

INSERT INTO company VALUES (400,105,300);
INSERT INTO company VALUES (401,106,300);
INSERT INTO company VALUES (402,107,305);
INSERT INTO company VALUES (403,108,302);
INSERT INTO company VALUES (404,109,307);

INSERT INTO supervisor VALUES (500, 'Jesse James');
INSERT INTO supervisor VALUES (501, 'James Franco');
INSERT INTO supervisor VALUES (502, 'Jared Leto');
INSERT INTO supervisor VALUES (503, 'James Dean');
INSERT INTO supervisor VALUES (504, 'Carrot Top');

INSERT INTO sales_person VALUES (600,502,'Stapler Guy','Master Stapler',32000.23,12);
INSERT INTO sales_person VALUES (601,501,'Michael Bolton','Master Rock Star',45000.21,99);
INSERT INTO sales_person VALUES (602,503,'Boss Hog','Master Driver',40000.27,0);
INSERT INTO sales_person VALUES (603,503,'Mike Wazoski','Master Chief',34000.12,8);
INSERT INTO sales_person VALUES (604,504,'Michael Smith','Master Baiterlol',65000.00,123);

INSERT INTO product VALUES (700,'I''m a GForce GTX!',200,'GForce GTX');
INSERT INTO product VALUES (701,'I''m a Radeon HD 6800!',450,'Radeon HD 6800');
INSERT INTO product VALUES (702,'I''m a GForce ASUS!',580,'GForce ASUS');
INSERT INTO product VALUES (703,'I''m a sound card A!',120,'Sound Card A');
INSERT INTO product VALUES (704,'I''m a sound card B!',180,'Sound Card B');
INSERT INTO product VALUES (705,'I''m a sound card C!',240,'Sound Card C');
INSERT INTO product VALUES (706,'I''m a CPU A!',200,'CPU A');
INSERT INTO product VALUES (707,'I''m a CPU B!',400,'CPU B');
INSERT INTO product VALUES (708,'I''m a CPU C!',600,'CPU C');
INSERT INTO product VALUES (709,'I''m a Memory A!',30,'Memory A');
INSERT INTO product VALUES (710,'I''m a Memory B!',70,'Memory B');
INSERT INTO product VALUES (711,'I''m a Memory C!',100,'Memory C');
INSERT INTO product VALUES (712,'I''m a Hard Disk A!',150,'Hard Disk A');
INSERT INTO product VALUES (713,'I''m a Hard Disk B!',240,'Hard Disk B');
INSERT INTO product VALUES (714,'I''m a Hard Disk C!',350,'Hard Disk C');
--
INSERT INTO product VALUES (715,'I''m a Acer',600,'Acer');
INSERT INTO product VALUES (716,'I''m a A Really ...',950,'A Really Awesome Notebook');
INSERT INTO product VALUES (717,'I''m a The Serving Machine',1500,'The Serving Machine');
INSERT INTO product VALUES (718,'I''m a Nothing-But-A-Lemming',350,'Nothing-But-A-Lemming');
INSERT INTO product VALUES (719,'I''m a Speedy Gonzalez',3000,'Speedy Gonzalez');
--
INSERT INTO product VALUES (720,'I''m a Printer A!',120,'Printer');
INSERT INTO product VALUES (721,'I''m a Mouse!',30,'Mouse');
INSERT INTO product VALUES (722,'I''m a Keyboard!',40,'Keyboard');
INSERT INTO product VALUES (723,'I''m a Speakers!',60,'Speakers');
INSERT INTO product VALUES (724,'I''m a Monitor!',150,'Monitor');

INSERT INTO computer_part VALUES (700,'jMB6IDlWqoZRJ4d');
INSERT INTO computer_part VALUES (701,'wZOmihQFidADYgi');
INSERT INTO computer_part VALUES (702,'JYW3jz309aJ8raw');
INSERT INTO computer_part VALUES (703,'ZLfIeFPrVacuPVp');
INSERT INTO computer_part VALUES (704,'2jWNppSPZmTStf1');
INSERT INTO computer_part VALUES (705,'HIC2EAxr3QxvEtV');
INSERT INTO computer_part VALUES (706,'DINe5A0Dl03X4og');
INSERT INTO computer_part VALUES (707,'jDWnRrTkv09aJ8r');
INSERT INTO computer_part VALUES (708,'Eb0lzc7fkx6sGcN');
INSERT INTO computer_part VALUES (709,'ECeVmAEJeBEEFcw');
INSERT INTO computer_part VALUES (710,'JYW3jz3OwYNRjxP');
INSERT INTO computer_part VALUES (711,'D8EFIHc0Q4Y7u6o');
INSERT INTO computer_part VALUES (712,'Uuqwb4wgStJpOdZ');
INSERT INTO computer_part VALUES (713,'x8CI6CutdvCLkVn');
INSERT INTO computer_part VALUES (714,'uh2VDgdv3ZFZs26');

INSERT INTO computer VALUES (715,'PC');
INSERT INTO computer VALUES (716,'Notebook');
INSERT INTO computer VALUES (717,'Server');
INSERT INTO computer VALUES (718,'Lemming');
INSERT INTO computer VALUES (719,'Superdooper fast compooper');

INSERT INTO accessory VALUES (720, 8);
INSERT INTO accessory VALUES (721, 20);
INSERT INTO accessory VALUES (722, 40);
INSERT INTO accessory VALUES (723, 42);
INSERT INTO accessory VALUES (724, 1);

INSERT INTO contains VALUES (701,715);
INSERT INTO contains VALUES (705,715);
INSERT INTO contains VALUES (710,715);
INSERT INTO contains VALUES (700,716);
INSERT INTO contains VALUES (703,716);
INSERT INTO contains VALUES (711,716);
INSERT INTO contains VALUES (714,716);
INSERT INTO contains VALUES (702,717);
INSERT INTO contains VALUES (706,717);
INSERT INTO contains VALUES (710,717);
INSERT INTO contains VALUES (713,717);
INSERT INTO contains VALUES (700,718);
INSERT INTO contains VALUES (703,718);
INSERT INTO contains VALUES (711,718);
INSERT INTO contains VALUES (713,718);
INSERT INTO contains VALUES (703,719);
INSERT INTO contains VALUES (704,719);
INSERT INTO contains VALUES (708,719);

INSERT INTO quote VALUES (801,893.23,102,601);
INSERT INTO quote VALUES (802,200.00,102,603);
INSERT INTO quote VALUES (803,324.63,104,604);
INSERT INTO quote VALUES (804,551.33,106,601);
INSERT INTO quote VALUES (805,21.20,107,602);
INSERT INTO quote VALUES (806,12.50,106,602);
INSERT INTO quote VALUES (807,100.50,109,600);
INSERT INTO quote VALUES (808,250.50,108,604);

INSERT INTO quote_products VALUES (801,715,12);
INSERT INTO quote_products VALUES (803,717,8);
INSERT INTO quote_products VALUES (803,720,15);
INSERT INTO quote_products VALUES (804,718,4);
INSERT INTO quote_products VALUES (805,716,10);
INSERT INTO quote_products VALUES (806,716,7);
INSERT INTO quote_products VALUES (805,715,15);
INSERT INTO quote_products VALUES (801,720,11);
INSERT INTO quote_products VALUES (802,721,9);
INSERT INTO quote_products VALUES (804,722,2);
INSERT INTO quote_products VALUES (802,722,3);
INSERT INTO quote_products VALUES (805,723,5);
INSERT INTO quote_products VALUES (806,724,1);
INSERT INTO quote_products VALUES (801,724,9);
INSERT INTO quote_products VALUES (804,723,5);
INSERT INTO quote_products VALUES (807,718,3);
INSERT INTO quote_products VALUES (807,707,2);
INSERT INTO quote_products VALUES (807,708,10);
INSERT INTO quote_products VALUES (808,702,5);
INSERT INTO quote_products VALUES (808,715,8);
INSERT INTO quote_products VALUES (808,711,2);

INSERT INTO sale VALUES (802,212.23,0.10,'2011-04-08 08:37:00');
INSERT INTO sale VALUES (801,900.10,0.08,'2011-03-08 08:38:00');
INSERT INTO sale VALUES (805,21.20,0.06,'2011-05-08 08:40:00');
INSERT INTO sale VALUES (804,570,0.00,'2011-07-08 08:50:00');
INSERT INTO sale VALUES (803,330.59,0.05,'2011-04-08 03:10:00');
INSERT INTO sale VALUES (807,100.50,0.15,'2011-04-01 01:01:01');

-- #1 -----------------------------------------------------
SELECT 	cus.name AS companyName, lr.name AS legRepName
FROM 	customer cus, company com, leg_rep lr
WHERE 	com.id_c = cus.id_c AND com.id_law = lr.id_law;

-- #2 -----------------------------------------------------
SELECT leg_rep.name AS lepRepAndCustomer
FROM leg_rep, customer
WHERE leg_rep.id_c = customer.id_c;

-- #3 -----------------------------------------------------
DROP VIEW hourTable;
CREATE 	VIEW hourTable AS
	SELECT qc_code, HOUR(sale_date) AS hour
	FROM sale;

DROP 	VIEW counted_hours;
CREATE	VIEW counted_hours AS
	SELECT 	DISTINCT hour, COUNT(hour) AS count
	FROM hourTABLE
	GROUP BY hour;

SELECT 	hour AS hourOfMaxSales
FROM 	counted_hours
WHERE 	count=(SELECT MAX(count) FROM counted_hours);

-- #4  ---------------------------------------------------
DROP	VIEW salesWithQuote;
CREATE	VIEW salesWithQuote AS
	SELECT quote.qc_code, quote.id_sales, sale.sale_date
	FROM sale, quote
	WHERE sale.qc_code = quote.qc_code;

DROP	VIEW interA;
CREATE 	VIEW interA AS
	SELECT	sales_person.name, salesWithQuote.id_sales, computer.type, quote_products.quantity, salesWithQuote.sale_date, quote_products.qc_code
	FROM	sales_person, salesWithQuote, computer, quote_products
	WHERE	salesWithQuote.id_sales = sales_person.id_sales AND
		salesWithQuote.qc_code = quote_products.qc_code AND
		computer.product_code = quote_products.product_code;

DROP	VIEW productSpecific;
CREATE	VIEW productSpecific AS
SELECT 	name AS salesman, id_sales AS idSales, sale_date AS saleDate, qc_code
FROM	interA
WHERE	type = 'PC' AND quantity >= 10 OR
	type = 'Notebook' AND quantity >= 8 OR
	type = 'Server' AND quantity >=2;

SELECT 	salesman, idSales, DATE(saleDate) AS firstCommissionDate, qc_code AS qcCode
FROM 	productSpecific
WHERE 	saleDate=(SELECT MIN(saleDate) FROM productSpecific);

-- #5 --------------------------
DROP	VIEW allAccessoriesSold;
CREATE	VIEW allAccessoriesSold AS
	SELECT 	product.name, quote.qc_code, quote_products.quantity
	FROM 	quote_products, accessory, product, quote
	WHERE 	quote_products.qc_code = quote.qc_code AND
		quote_products.product_code = accessory.product_code AND
		accessory.product_code = product.product_code;

DROP	VIEW summedAccessories;
CREATE	VIEW summedAccessories AS
	SELECT 	DISTINCT name, SUM(quantity) AS totalQuantitySold
	FROM allAccessoriesSold
	GROUP BY name;

SELECT		SA.name AS accessoryName, SA.totalQuantitySold, product.price AS unitPrice, (SA.totalQuantitySold * product.price) AS totalPrice
FROM 		summedAccessories AS SA
INNER JOIN	product
ON		SA.name = product.name
ORDER BY 	SA.name;

-- #6 --------------------------
DROP VIEW expensivePart;
CREATE VIEW expensivePart AS
SELECT	comp.name AS compName, part.name AS partName, part.price
FROM	product comp, product part, computer, contains
WHERE	comp.product_code = computer.product_code AND
	computer.product_code = contains.comp_product_code AND
	contains.part_product_code = part.product_code;

SELECT		expensivePart.compName, expensivePart.partName AS mostExpPartName, expensivePart.price AS partPrice
FROM		expensivePart
INNER JOIN	(SELECT DISTINCT compName AS origCompName, MAX(price) AS mostExpPrice 
		FROM 	expensivePart
		GROUP BY	compName)
ON		expensivePart.compName = origCompName AND
		expensivePart.price = mostExpPrice
ORDER BY	expensivePart.compName;

-- #7 --------------------------
DROP VIEW question7A;
CREATE VIEW question7a AS
	SELECT	*
	FROM (	SELECT  leg_rep.name AS legRepName, product.name AS productName, product.price AS unitPrice, quote_products.quantity, (product.price * quote_products.quantity) AS totalPrice, sale.sale_date
		FROM	leg_rep, customer, sale, quote, quote_products, product
		WHERE	quote.qc_code = sale.qc_code AND
			quote.qc_code = quote_products.qc_code AND
			quote_products.product_code = product.product_code AND
			quote.id_c = customer.id_c AND
			customer.id_c = leg_rep.id_c
		ORDER BY legRepName
		)
	AS testView;

SELECT legRepName, productName, unitPrice, quantity, totalPrice, DATE(sale_date) AS saleDate
FROM question7a;

SELECT 	DISTINCT legRepName, SUM(totalPrice) AS totalAmountOfAllPurchases
FROM 	question7a
GROUP BY legRepName;

-- #8 --------------------------
DROP VIEW topSalesOfMonth;
CREATE VIEW topSalesOfMonth AS
SELECT	quote.qc_code AS topSaleQcCode, sales_person.name AS salesName, sale.discount AS salesDiscount, DATE(sale.sale_date) AS inMonthOfApril
FROM	sales_person, quote, sale
WHERE	sales_person.id_sales = quote.id_sales AND
	quote.qc_code = sale.qc_code AND
	MONTH(sale.sale_date) = 4;

DROP	VIEW allProductsSold;
CREATE	VIEW allProductsSold AS
	SELECT 	topSaleQcCode, salesName, product.name AS productName, product.price AS unitPrice, quote_products.quantity, salesDiscount, inMonthOfApril
	FROM	topSalesOfMonth, quote_products, product
	WHERE	topSaleQcCode = quote_products.qc_code AND
 		quote_products.product_code = product.product_code;

SELECT * FROM allProductsSold;

DROP	VIEW summedProducts;
CREATE	VIEW summedProducts AS
	SELECT 	DISTINCT topSaleQcCode, SUM(unitPrice * quantity) AS totalBeforeDis, SUM(unitPrice * quantity * (1 - salesDiscount)) AS totalAfterDis
	FROM allProductsSold
	GROUP BY topSaleQcCode;

SELECT * FROM summedProducts;

SELECT		DISTINCT summedProducts.topSaleQcCode, allProductsSold.salesName, allProductsSold.salesDiscount, DECIMAL(summedProducts.totalAfterDis, 8, 2) AS totalAfterDisc, allProductsSold.inMonthOfApril
FROM		summedProducts
INNER JOIN	allProductsSold
ON		summedProducts.topSaleQcCode = allProductsSold.topSaleQcCode
ORDER BY	totalAfterDisc DESC;

-- #9 -----------------------------
DROP VIEW	notSold;
CREATE VIEW	notSold AS
SELECT 		qc_code, id_sales
FROM		quote
WHERE		NOT EXISTS(	SELECT *
				FROM	sale
				WHERE	sale.qc_code = quote.qc_code
		);

DROP VIEW	notAcc;
CREATE VIEW	notAcc AS
SELECT		product_code, name
FROM		product
WHERE		NOT EXISTS(	SELECT 	*
				FROM	accessory
				WHERE	accessory.product_code = product.product_code
		);

DROP VIEW	notAccQP;
CREATE VIEW	notAccQP AS
SELECT		quote_products.qc_code, product.name
FROM		quote_products
INNER JOIN	product
ON		product.product_code = quote_products.product_code;

DROP VIEW	notSoldSP;
CREATE VIEW	notSoldSP AS
SELECT		sales_person.name, notSold.qc_code
FROM		sales_person
INNER JOIN	notSold
ON		notSold.id_sales = sales_person.id_sales;

SELECT 	notAccQP.name AS compsAndPartsNotSold, notSoldSP.name AS salesPerson
FROM		notAccQP, notSoldSP
WHERE		notAccQP.qc_code = notSoldSP.qc_code AND
		SUBSTR(notSoldSP.name, LENGTH(notSoldSP.name) - 4, LENGTH('Smith')) = 'Smith';

-- #10 ----------------------------------------------------
-- list the details of products grouped by qc_code
SELECT		quote_products.qc_code AS qcCode, product.name AS productName, product.description AS details
FROM		quote_products, product
WHERE		quote_products.product_code = product.product_code
ORDER BY	qcCode;

-- #11 ----------------------------------------------------
DROP VIEW allSalesmenWithCom;
CREATE VIEW allSalesmenWithCom AS
SELECT	DISTINCT quote.qc_code, sales_person.name, sale.discount, sales_person.id_sales
FROM	sales_person, quote, sale, productSpecific
WHERE	quote.qc_code = sale.qc_code AND
	sales_person.id_sales = quote.id_sales AND
	sales_person.id_sales = productSpecific.idSales;


DROP VIEW	tempCommissionTable;
CREATE VIEW	tempCommissionTable AS
SELECT DISTINCT	allSalesmenWithCom.qc_code, SUM(product.price * quote_products.quantity * (1 - allSalesMenWithCom.discount) * 0.1) AS totalCom
FROM		quote_products, product, allSalesMenWithCom
WHERE		allSalesmenWithCom.qc_code = quote_products.qc_code AND
		quote_products.product_code = product.product_code
GROUP BY	allSalesmenWithCom.qc_code;


DROP VIEW	realCommissionTable;
CREATE VIEW	realCommissionTable AS
SELECT		allSalesmenWithCom.id_sales, SUM(totalCom) AS totalComm
FROM 		allSalesmenWithCom, tempCommissionTable
WHERE		tempCommissionTable.qc_code = allSalesmenWithCom.qc_code
GROUP BY	allSalesmenWithCom.id_sales;


DROP VIEW	almostSalesmanTable;
CREATE VIEW	almostSalesmanTable AS
SELECT		SP.id_sales, SP.ID_SUP, SP.NAME, SP.position, SP.base_salary, SP.sales_made, realCommissionTable.totalComm
FROM		sales_person AS SP
LEFT JOIN	realCommissionTable
ON		SP.id_sales = realCommissionTable.id_sales;


DROP VIEW	totalSalesmanTable;
CREATE VIEW	totalSalesmanTable AS
	SELECT	AST.id_sales, AST.id_sup, AST.name, AST.position, AST.base_salary, 0 AS totalComm
	FROM	almostSalesmanTable AS AST
	WHERE	totalComm IS NULL
	UNION
	SELECT	AST.id_sales, AST.id_sup, AST.name, AST.position, AST.base_salary, AST.totalComm
	FROM	almostSalesmanTable AS AST
	WHERE	totalComm IS NOT NULL;

SELECT 	supervisor.name AS supervisor, AST.name AS salesman, AST.position, DECIMAL((AST.base_salary + AST.totalComm), 8,2) AS totalSalary
FROM	supervisor, totalSalesmanTable AS AST
WHERE	AST.id_sup = supervisor.id_sup
ORDER BY totalSalary DESC;
	
-- #12 ----------------------------------------------------

DROP VIEW customerInApril;
CREATE VIEW customerInApril AS
SELECT	customer.name AS customer, quote.qc_code, QP.quantity, QP.product_code
FROM	sale, quote, customer, quote_products AS QP
WHERE	customer.id_c = quote.id_c AND
	quote.qc_code = sale.qc_code AND
	MONTH(sale.sale_date) = 4 AND
	quote.qc_code = QP.qc_code AND
	QP.product_code = 720;

DROP VIEW	listOfProductCodes;
CREATE VIEW 	listOfProductCodes AS
SELECT	quote_products.product_code, customerInApril.qc_code
FROM	quote_products, customerInApril
WHERE	quote_products.qc_code = customerInApril.qc_code;

DROP VIEW	notParts;
CREATE VIEW	notParts AS
SELECT	*
FROM	listOfProductCodes
WHERE	NOT EXISTS(	SELECT	*	
		FROM	computer_part
		WHERE	computer_part.product_code = listOfProductCodes.product_code
		);

DROP VIEW	validProducts;
CREATE VIEW 	validProducts AS
SELECT		DISTINCT product.price, quote_products.quantity, notParts.qc_code	
FROM		notParts, quote_products, product
WHERE		notParts.qc_code = quote_products.qc_code AND
		quote_products.product_code = product.product_code;

DROP VIEW lastViewEver;
CREATE VIEW lastViewEver AS
SELECT *
FROM	(SELECT	validProducts.qc_code, SUM(validProducts.price * validProducts.quantity) AS totalPrice
	FROM	validProducts
	GROUP BY qc_code
	)
WHERE	totalPrice > 10000;

SELECT	customer.name, customer.address, customer.work_phone, lastViewEver.totalPrice
FROM	customer, lastViewEver, quote
WHERE 	lastViewEver.qc_code = quote.qc_code AND
	quote.id_c = customer.id_c;
 
terminate;