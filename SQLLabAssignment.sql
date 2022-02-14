1. Create Database if not exists `order-directory` ;

create table if not exists `supplier`(
`SUPP_ID` int primary key,
`SUPP_NAME` varchar(50) ,
`SUPP_CITY` varchar(50),
`SUPP_PHONE` varchar(10)
);
CREATE TABLE IF NOT EXISTS `customer` (
  `CUS_ID` INT NOT NULL,
  `CUS_NAME` VARCHAR(20) NULL DEFAULT NULL,
  `CUS_PHONE` VARCHAR(10),
  `CUS_CITY` varchar(30) ,
  `CUS_GENDER` CHAR,
  PRIMARY KEY (`CUS_ID`));

CREATE TABLE IF NOT EXISTS `category` (
`CAT_ID` INT NOT NULL,

`CAT_NAME` VARCHAR(20) NULL DEFAULT NULL,

PRIMARY KEY (`CAT_ID`)

);

CREATE TABLE IF NOT EXISTS `product` (
`PRO_ID` INT NOT NULL,

`PRO_NAME` VARCHAR(20) NULL DEFAULT NULL,

`PRO_DESC` VARCHAR(60) NULL DEFAULT NULL,

`CAT_ID` INT NOT NULL,

PRIMARY KEY (`PRO_ID`),

FOREIGN KEY (`CAT_ID`) REFERENCES CATEGORY (`CAT_ID`)

);

CREATE TABLE IF NOT EXISTS `product_details` (
  `PROD_ID` INT NOT NULL,
 `PRO_ID` INT NOT NULL,
  `SUPP_ID` INT NOT NULL,
  `PROD_PRICE` INT NOT NULL,
  PRIMARY KEY (`PROD_ID`),
  FOREIGN KEY (`PRO_ID`) REFERENCES PRODUCT (`PRO_ID`),
  FOREIGN KEY (`SUPP_ID`) REFERENCES SUPPLIER(`SUPP_ID`)
  
  );


CREATE TABLE IF NOT EXISTS `order` (
  `ORD_ID` INT NOT NULL,
  `ORD_AMOUNT` INT NOT NULL,
  `ORD_DATE` DATE,
  `CUS_ID` INT NOT NULL,
  `PROD_ID` INT NOT NULL,
  PRIMARY KEY (`ORD_ID`),
  FOREIGN KEY (`CUS_ID`) REFERENCES CUSTOMER(`CUS_ID`),
  FOREIGN KEY (`PROD_ID`) REFERENCES PRODUCT_DETAILS(`PROD_ID`)
  );
CREATE TABLE IF NOT EXISTS `rating` (
  `RAT_ID` INT NOT NULL,
  `CUS_ID` INT NOT NULL,
  `SUPP_ID` INT NOT NULL,
  `RAT_RATSTARS` INT NOT NULL,
  PRIMARY KEY (`RAT_ID`),
  FOREIGN KEY (`SUPP_ID`) REFERENCES SUPPLIER (`SUPP_ID`),
  FOREIGN KEY (`CUS_ID`) REFERENCES CUSTOMER(`CUS_ID`)
  );
===============================================================================

2. insert into `supplier` values(1,"Rajesh Retails","Delhi",'1234567890');
insert into `supplier` values(2,"Appario Ltd.","Mumbai",'2589631470');
insert into `supplier` values(3,"Knome products","Banglore",'9785462315');
insert into `supplier` values(4,"Bansal Retails","Kochi",'8975463285');
insert into `supplier` values(5,"Mittal Ltd.","Lucknow",'7898456532');

INSERT INTO `CUSTOMER` VALUES(1,"AAKASH",'9999999999',"DELHI",'M');
INSERT INTO `CUSTOMER` VALUES(2,"AMAN",'9785463215',"NOIDA",'M');
INSERT INTO `CUSTOMER` VALUES(3,"NEHA",'9999999999',"MUMBAI",'F');
INSERT INTO `CUSTOMER` VALUES(4,"MEGHA",'9994562399',"KOLKATA",'F');
INSERT INTO `CUSTOMER` VALUES(5,"PULKIT",'7895999999',"LUCKNOW",'M');

INSERT INTO `CATEGORY` VALUES( 1,"BOOKS");
INSERT INTO `CATEGORY` VALUES(2,"GAMES");
INSERT INTO `CATEGORY` VALUES(3,"GROCERIES");
INSERT INTO `CATEGORY` VALUES (4,"ELECTRONICS");
INSERT INTO `CATEGORY` VALUES(5,"CLOTHES");

INSERT INTO `PRODUCT` VALUES(1,"GTA V","DFJDJFDJFDJFDJFJF",2);
INSERT INTO `PRODUCT` VALUES(2,"TSHIRT","DFDFJDFJDKFD",5);
INSERT INTO `PRODUCT` VALUES(3,"ROG LAPTOP","DFNTTNTNTERND",4);
INSERT INTO `PRODUCT` VALUES(4,"OATS","REURENTBTOTH",3);
INSERT INTO `PRODUCT` VALUES(5,"HARRY POTTER","NBEMCTHTJTH",1);

INSERT INTO PRODUCT_DETAILS VALUES(1,1,2,1500);
INSERT INTO PRODUCT_DETAILS VALUES(2,3,5,30000);
INSERT INTO PRODUCT_DETAILS VALUES(3,5,1,3000);
INSERT INTO PRODUCT_DETAILS VALUES(4,2,3,2500);
INSERT INTO PRODUCT_DETAILS VALUES(5,4,1,1000);

INSERT INTO `ORDER` VALUES (50,2000,"2021-10-06",2,1);
INSERT INTO `ORDER` VALUES(20,1500,"2021-10-12",3,5);
INSERT INTO `ORDER` VALUES(25,30500,"2021-09-16",5,2);
INSERT INTO `ORDER` VALUES(26,2000,"2021-10-05",1,1);
INSERT INTO `ORDER` VALUES(30,3500,"2021-08-16",4,3);

INSERT INTO `RATING` VALUES(1,2,2,4);
INSERT INTO `RATING` VALUES(2,3,4,3);
INSERT INTO `RATING` VALUES(3,5,1,5);
INSERT INTO `RATING` VALUES(4,1,3,2);
INSERT INTO `RATING` VALUES(5,4,5,4);
 
===============================================================================

3. select cust.cus_gender,count(cust.cus_gender) as count from customer cust inner join 'order' o on
cust.cus_id = o.cus_id where o.ord_amount >= 3000 group by cust.cus_gender;

4. select o.*, prod.pro_name from `order` o , product_details pd product prod where
o.cus_id = 2 and o.prod_id = pd.prod_id and pd.prod_id = prod.pro_id;

5. select supp.* from supplier supp, product_details pd where supp.supp_id in
(select supp_id from product_details group by supp_id having count(supp_id) > 1 ) group by supp.supp_id;
	

6. select cat.* from `order` o inner join product_details pd on o.prod_id = pd.prod_id
inner join product prod on prod.prod_id = pd.prod_id inner join category cat on cat.cat_id = prod.cat_id
having min(o.order_amount);

7. select prod.prod_id,prod.pro_name from `order` o inner join product_details pd on pd.pro_id = o.pro_id
inner join product prod on prod.pro_id = pd.pro_id where o.ord_date > "2021-10-05";

8. select cus_name,gender from customer where cus_name like 'A%' or cus_name like '%A';

9. 	delimiter $$
	create procedure supplier_rating()

	begin

		select s.supp_id, s.supp_name,
		case when rat_ratstars >4 then 'Genuine Supplier'
		when rat_ratstars >2 and rat_ratstars <=4 then 'Average Supplier'
		else 'Supplier should not be considered'
		end as rating from rating inner join supplier s on rating.supp_id = s.supp_id;

	end $$

	delimiter ;
