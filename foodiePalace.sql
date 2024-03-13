-- drop database if exists foodiepalace;
create database foodiepalace;
use foodiepalace;

create table Staff(
staffId int not null auto_increment primary key,
firstName varchar(64) not null,
lastName  varchar(64) not null,
mobile varchar(14) not null unique,
email varchar(64) not null,
salary int not null,
streetAddress varchar(64),
aptNumber int, 
city varchar(64), 
state varchar(64), 
zipcode varchar(5),
chef boolean not null default false,
administrator boolean not null default false
);

create table Customer(
customerId int not null auto_increment primary key,
firstName varchar(64) not null,
lastName  varchar(64) not null,
mobile varchar(14) not null unique,
email varchar(64) not null,
streetAddress varchar(64),
aptNumber int, 
city varchar(64), 
state varchar(64), 
zipcode varchar(5)
);

create table Menu(
menuId int not null auto_increment primary key, 
title varchar(64) not null
);



create table Dish(
dishId int not null auto_increment primary key, 
dishName varchar(64) not null, 
price float not null,  
cuizine varchar(64) not null,
isVegan boolean not null, 
menuId int, 
instructions text not null,
constraint fk_menu_dish 
foreign key (menuId) 
references Menu(menuId) 
on update cascade on delete cascade
);

create table Ingredient(
ingredientId int not null auto_increment primary key, 
ingredientName varchar(64) not null, 
quantity varchar(64) not null
); 

create table CustomerOrder(
orderId int not null auto_increment primary key,
orderStatus enum("Ongoing", "Completed") not null,
subTotal float not null default 0, 
promo varchar(10), 
discount float default 0, 
grandTotal float not null default 0
);


create table CustomerOrderContainsDish(
orderId int not null,
dishId int not null, 
quantity int not null default 1,
primary key(orderId, dishId),
constraint fk_CustomerOrderContainsDish_CustomerOrder
foreign key (orderId) 
references CustomerOrder(orderId) 
on update cascade on delete cascade,
constraint fk_CustomerOrderContainsDish_Dish
foreign key (dishId) 
references Dish(dishId) 
on update cascade on delete cascade
);

create table RestaurantTable(
tableNumber int not null auto_increment primary key,
tableStatus enum("Reserved", "Ongoing", "Free") not null,
tableCapacity int default 1
);


create table Payment(
paymentMode enum("Credit Card", "Cash") not null,
paymentStatus enum("Ongoing", "Successful", "Failed") not null,
orderId int not null, 
customerId int not null, 
primary key(orderId, customerId),
constraint fk_Payment_CustomerOrder
foreign key (orderId) 
references CustomerOrder(orderId) 
on update cascade on delete cascade,
constraint fk_Payment_Customer
foreign key (customerId) 
references Customer(customerId) 
on update cascade on delete cascade
);

create table DishMadeFromIngredient(
dishId int not null,
ingredientId int not null,
primary key(dishId,ingredientId),
constraint fk_DishMadeFromIngredient_dish
foreign key (dishId)
references Dish(dishId)
on update cascade on delete cascade,
constraint fk_DishMadeFromIngredient_ingredient
foreign key (ingredientId)
references Ingredient(ingredientId)
on update cascade on delete cascade

);


create table CustomerWithOrderAtTable(
tableNumber int not null, 
customerId int not null, 
orderId int not null, 
primary key(tableNumber, customerId, orderId), 
constraint fk_CustomerWithOrderAtTable_table
foreign key (tableNumber)
references RestaurantTable(tableNumber),
constraint fk_CustomerWithOrderAtTable_customer
foreign key (customerId)
references Customer(customerId),
constraint fk_CustomerWithOrderAtTable_order
foreign key (orderId)
references CustomerOrder(orderId)

);




-- -----------------------------------------INSERT

-- PROCEDURE FOR INSERT STAFF TABLE


DROP PROCEDURE IF EXISTS insertStaffAdmin;
delimiter $$
create procedure insertStaffAdmin(in firstName varchar(64) , in lastName  varchar(64) ,in mobile varchar(14),in email varchar(64) ,in salary int,
in streetAddress varchar(64), in aptNumber int, in city varchar(64),  in state varchar(64), in zipcode varchar(5))
begin
GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
SELECT @full_error;

if length(mobile)>10 and length(mobile)<10 THEN
SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'Mobile number greater than 10 digits';
END IF;

if length(zipcode)>6 THEN
SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'Invalid zip code';
END IF;

if length(firstName) = 0 or length(firstName) <3 then
SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'first name is of Invalid length.';
end if;
 
if length(lastName) = 0 or length(lastName) < 3 then
SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'last name is of Invalid length.';
end if;

if length(salary) <= 0 or length(salary) >500000 then
SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'Invalid salary';
end if;
	insert into Staff(firstName, lastName, mobile, email, salary, streetAddress, aptNumber, city,state,zipcode,administrator) 
    values(firstName, lastName, mobile, email, salary, streetAddress, aptNumber, city,state,zipcode,true);
end $$
delimiter ;


call insertStaffAdmin('Robert','May','7626567899','robertmay@gmail.com','95000','Boylston Street','1203','Boston','Massachusetts','02215');
call insertStaffAdmin("Racheal","Green",7812064500,"greenracheal@gmail.com",98000,"Beacon Street",2341,"Boston","Massachusetts",02213);

-- PROCEDURE FOR UPDATE STAFF 

DROP PROCEDURE IF EXISTS updateStaff;
delimiter $$
create procedure updateStaff(in staffId int,in firstName varchar(64) , in lastName  varchar(64) ,in mobile varchar(14),in email varchar(64) ,in salary int,
in streetAddress varchar(64), in aptNumber int, in city varchar(64),  in state varchar(64), in zipcode varchar(5))
begin
GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
SELECT @full_error;

if length(salary) <= 0 or length(salary) >500000 then
SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'Invalid salary';
end if;

UPDATE Staff s SET s.firstName = firstName, s.lastName = lastName, s.mobile=mobile, s.email=email, s.salary=salary, s.streetAddress=streetAddress,
s.aptNumber=aptNumber, s.city=city, s.state=state, s.zipcode=zipcode where s.staffId=staffId;

end $$
delimiter ;

call updateStaff(5,'Mary','Fernadez','7732345688','maryfernandez@gmail.com','105000','Jersey Street','1111','Boston','Massachusetts','02135');

-- PROCEDURE FOR DELETING STAFF

DROP PROCEDURE IF EXISTS deleteStaff;
delimiter $$
create procedure deleteStaff(in staffId int)
begin
GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
SELECT @full_error;

IF not EXISTS (SELECT s.staffId FROM Staff s where s.staffId=staffId) THEN
SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'Staff does not exist';
END IF;

delete from Staff s where s.staffId=staffId;

end $$
delimiter ;
call deleteStaff(1);



-- PROCEDURE FOR INSERT STAFF CHEF

DROP PROCEDURE IF EXISTS insertStaffChef;
delimiter $$
create procedure insertStaffChef(in firstName varchar(64) , in lastName  varchar(64) ,in mobile varchar(14),in email varchar(64) ,in salary int,
in streetAddress varchar(64), in aptNumber int, in city varchar(64),  in state varchar(64), in zipcode varchar(5))
begin
GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
SELECT @text;

if length(mobile)>10 and length(mobile)<10 THEN
SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'Mobile number greater than 10 digits';
END IF;

if length(zipcode)>6 THEN
SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'Invalid zip code';
END IF;

if length(firstName) = 0 or length(firstName) <3 then
SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'first name is of Invalid length.';
end if;
 
if length(lastName) = 0 or length(lastName) < 3 then
SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'last name is of Invalid length.';
end if;

if length(salary) <= 0 or length(salary) >500000 then
SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'Invalid salary';
end if;
	insert into Staff(firstName, lastName, mobile, email, salary, streetAddress, aptNumber, city,state,zipcode,chef) 
    values(firstName, lastName, mobile, email, salary, streetAddress, aptNumber, city,state,zipcode,true);
end $$
delimiter ;


insert into Staff( firstName, lastName, mobile, email, salary, streetAddress, aptNumber, city, state, zipcode, chef)
values('Mary','Fernandez','7732345688','maryfernandez@gmail.com','95000','Jersey Street','1111','Boston','Massachusetts','02135',true);
call insertStaffChef("Liu","Huan",8912064508,"lihuan@gmail.com",90000,"Washington Street",1341,"Boston","Massachusetts",02212);
call insertStaffChef("Venkatesh","Bhatt",4562064508,"venkatbhatt@gmail.com",100000,"Brooklyn Street",41,"Boston","Massachusetts",04512);
call insertStaffChef(" Enrique", "Olvera",7562064570," enriqueolvera@gmail.com",103000,"Park Drive",1241,"Boston","Massachusetts",06512);



-- PROCEDURE FOR INSERTING INTO CustomerWithOrderAtTable

DROP PROCEDURE IF EXISTS insertCustomerWithOrderAtTable;
delimiter $$
create procedure insertCustomerWithOrderAtTable(in tableNumber int, in customerId int, in orderId int)
begin
insert into CustomerWithOrderAtTable values(tableNumber, customerId, orderId);
end $$
delimiter ;



-- PROCEDURE FOR GETTING DATA FROM CustomerWithOrderAtTable

DROP PROCEDURE IF EXISTS getTableDetails;
delimiter $$
create procedure getTableDetails(in tableNumber int)
begin
select * from CustomerWithOrderAtTable c where c.tableNumber = tableNumber limit 1;
end $$
delimiter ;


call getTableDetails(2);


-- PROCEDURE FOR GETTING ALL CHEFS

DROP PROCEDURE IF EXISTS getAllChef;
delimiter $$
create procedure getAllChef()
begin
select * from Staff where chef=true;
end $$
delimiter ;

call getAllChef();

-- PROCEDURE FOR GETTING ALL ADMINS

DROP PROCEDURE IF EXISTS getAllAdmin;
delimiter $$
create procedure getAllAdmin()
begin
select * from Staff where administrator=true;
end $$
delimiter ;

call getAllAdmin();

-- PROCEDURE FOR GETTING CHEF WITH STAFFID

DROP PROCEDURE IF EXISTS getChef;
delimiter $$
create procedure getChef(in staffId int )
begin
select * from Staff s where chef=true and s.staffId=staffId;
end $$
delimiter ;

call getChef(2);

-- PROCEDURE FOR GETTING CHEF WITH STAFFID

DROP PROCEDURE IF EXISTS getAdmin;
delimiter $$
create procedure getAdmin(in staffId int )
begin
select * from Staff s where administrator=true and s.staffId=staffId;
end $$
delimiter ;

call getAdmin(11);
select * from staff where administrator=true;


-- PROCEDURE FOR INSERT CUSTOMER TABLE


DROP PROCEDURE IF EXISTS insertCustomer;
delimiter $$
create procedure insertCustomer(in firstName varchar(64), in lastName  varchar(64), in mobile varchar(14), in email varchar(64),
in streetAddress varchar(64), in aptNumber int, in city varchar(64), in state varchar(64), in zipcode varchar(5))
begin
GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
SELECT @full_error;

if length(mobile)>10 and length(mobile)<10 THEN
SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'Invalid mobile number';
END IF;

if length(zipcode)>6 THEN
SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'Invalid zip code';
END IF;

 if length(firstName) = 0 or length(firstName) <3 then
    SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'first name is of Invalid length.';
 end if;
 if length(lastName) = 0 or length(lastName) < 3 then
    SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'last name is of Invalid length.';
 end if;
insert into Customer(firstName, lastName, mobile, email, streetAddress, aptNumber, city, state,  zipcode) 
values(firstName, lastName, mobile, email, streetAddress, aptNumber, city, state,  zipcode);
end $$
delimiter ;

call insertCustomer('Paul','Christian','7651236541','christianpaul@gmail.com','Washington Street',1278,'Boston','Massachusetts','02213');
call insertCustomer('Emma','Olivia','7632236541','emmaolivia@gmail.com','Washington Street',1978,'Boston','Massachusetts','02213');
call insertCustomer('Noah','Charlotte','6632236549','charlottenoah@gmail.com','kenmore Street',78,'Boston','Massachusetts','01213');
call insertCustomer('Logan','Carl','6718906549','logancarl@gmail.com','Columbia Street',78,'Boston','Massachusetts','01213');
call insertCustomer('Anna','Hudson','7812043566','annahudson@gmail.com','Harvest Street',189,'Boston','Massachusetts','02219');


-- PROCEDURE TO GET ALL CUSTOMERS

DROP PROCEDURE IF EXISTS getAllCustomers;
delimiter $$
create procedure getAllCustomers()
begin
select * from Customer;
end $$
delimiter ;

call getAllCustomers();



-- insert MENU

insert into Menu()
values(1,'Chinese');

insert into Menu()
values(2,'Mexican');

insert into Menu()
values(3,'Indian');


-- PROCEDURE FOR INSERT DISH

DROP PROCEDURE IF EXISTS insertDish;
delimiter $$
create procedure insertDish( in dishName varchar(64), in price float,in isVegan boolean, in menuId int, in instructions text) 
begin
declare cuisine varchar(64);
GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
SELECT @full_error;

IF EXISTS (SELECT d.dishName FROM Dish d where d.dishName=dishName) THEN
SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'Dish already present. Enter a new dish';
END IF;

if (price>100) then
SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'Invalid price for a dish';
END IF;

IF NOT EXISTS (SELECT m.menuId FROM Menu m where m.menuId=menuId) THEN
SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'Menu does not exist';
END IF;

select title into cuisine from menu m where m.menuId=menuId;
insert into Dish(dishName, price, cuizine, isVegan, menuId, instructions) values( dishName, price, cuisine, isVegan, menuId, instructions);
end $$
delimiter ;


-- PROCEDURE FOR Get all DISH of menuId

DROP PROCEDURE IF EXISTS getDishOfMenu;
delimiter $$
create procedure getDishOfMenu( in menuId int)
begin
select * from Dish d where d.menuId = menuId;
end $$
delimiter ;

call getDishOfMenu(1);

call insertDish('Vegetable Fried Rice','15.90',true ,1,'Add oil and swirl the pan to coat the bottom.Add the veggies of choice and salt.
Add the ginger, garlic and red pepper flakes, and cook until fragrant while stirring constantly, about 30 seconds. 
Add the rice and mix it all together.Add the greens (if using) and green onions and serve with sauce of choice');

call insertDish('Tofu and Mushroom Stir Fry','17.56',true ,1,'Sauté garlic. In a large wok or skillet, heat oil over 
medium-high heat for 2 minutes until the hot oil sizzles.
--  Add garlic and sauté until fragrant, about 1 minute.
-- Stir fry vegetables. Add mushrooms and tofu and stir to cook until nicely browned, about 3-4 minutes. Add bok choy and stir fry for 2 minutes, allowing it to soften.
-- Add in sauce. Stir in soy sauce, vinegar and pepper. Mix well until evenly distributed. Drizzle with sesame oil and sprinkle sesame seeds on top.
-- Serve. Serve immediately with steamed rice or over a plate of fried noodles.');

 call insertDish('Chicken Manchurian','14.16',false ,1,'Add all the marination ingredients to the chicken. See the recipe card at the end. Leave for 30 mins.
 Fry the chicken in oil on medium heat till they are cooked and crispy. You can pan-fry the chicken if you dont like deep-frying.
 Combine all the sauce ingredients in the recipe card. You can add the broth (water + stock cube) to the prepped sauce or add it to the pan later. 
 Toast the garlic. Then fry the bell pepper for 2 mins. The bell pepper will continue to cook in the sauce. Pour the sauce and the broth (if you didnt add to the sauce earlier).
Add the spring onion and chicken and toss.');

 call insertDish('Hot Cheesy Corn Dip with Topping','10.50',false ,2,'Preheat oven 180°C. Meanwhile, in a large bowl, combine cream cheese, sour cream, cheese, garlic dressing, paprika and bacon, reserving some bacon for garnish. Stir until fully combined
 Gently stir through corn and pour into an 8 cup capacity baking dish. Top with extra cheese mix. Bake for 25 minutes or until bubbly
 To serve, top with reserved bacon bits, shallots and tortillas');

 call insertDish('Mexican Chicken Tacos','11',false ,2,'Preheat oven to 220°C / 200°C fan-forced. Place taco shells in a greased baking dish, upside-down
 Bake for 2 to 3 minutes, or until warm. Remove. Cool slightly. Turn, open-side up
 Heat oil in a large frying pan over medium heat. Add onion. Cook, stirring for 3 to 4 minutes, or until soft. Add taco seasoning and cook, stirring for 30 seconds, or until fragrant. Add chicken, beans, salsa and water. Cook, stirring for 2 to 3 minutes, or until combined and heated through. Remove from heat
 Divide chicken mixture amongst taco shells. Sprinkle evenly with Mexican Style cheese
 Bake for 12 minutes, or until cheese is melted and shells are golden and crisp. Remove from oven
 Scatter baked tacos with tomatoes. Dollop with mashed avocado. Garnish with coriander leaves. Serve with lime wedges');

 call insertDish('Family Nachos Tray Bake','25',false ,2,'Preheat oven to 220°C / 200°C fan-forced. Grease and line a large oven tray with baking paper
 Heat oil in a large frying pan over medium heat. Add onion. Cook, stirring occasionally, until soft. Add mince. Cook, stirring to break up lumps for about 5 minutes, or until browned.
  Add taco seasoning and cook, stirring for 30 seconds, or until fragrant
 Stir in salsa, beans, corn and water. Bring to the boil. Simmer, stirring occasionally, for about 12 minutes or until thickened. Remove from heat
 Arrange corn chips over prepared tray. Sprinkle with half the Mexican Style cheese. Top with beef mixture. Sprinkle with remaining cheese
 Bake for 10 - 12 minutes, or until cheese is melted and golden brown. Remove from oven
 Scatter tomatoes over nachos. Top with avocado and sour cream if using. Serve with lime wedges');


call insertDish('Vegan Red Lentil Curry','13.5',true ,3,'Dice up your ginger, garlic, chili peppers, and turmeric (if using fresh).
Sauté the ginger, garlic, chili peppers, and turmeric (if using fresh) in hot oil for about 2 minutes, until fragrant.
 Then, add the ground spices and cook for 30-60 seconds, stirring frequently to prevent burning.
 Deglaze with the vegetable broth, then add in the red lentils and crushed tomatoes.
 Simmer, covered, for 20 to 25 minutes, or until the lentils are cooked through.
 Stir in the coconut milk and almond butter.
 Continue cooking, uncovered, for 5 to 8 minutes, until the curry has thickened.
Finally, stir in the lemon juice and cilantro, and season to taste.');

call insertDish('Chicken Biriyani','20',true ,3,'Combine the chicken in a bowl with the yogurt, curry powder, 
and cinnamon and let marinate for at least 1 hour but preferably for 4 hours. 
Heat the butter in a skillet over medium-high heat and cook the onions until golden, 7-8 minutes.
Add the garlic and ginger and cook for another 2 minutes. 
Add the chicken and all of the marinade along with the salt. 
Stir to combine, reduce the heat to medium-low, cover, and cook until the chicken is cooked through, 6-7 minutes, stirring occasionally.
Add the cooked rice, cilantro and raisins.  Pour the chicken stock over the mixture.  
Bring to simmer.  Cover and simmer 3-4 minutes until the mixture is heated through.Add salt to taste. Serve hot.');


call insertDish('Lentil Sambar with Steamed Rice','21.50',true ,3,'Soak tamarind in water
earlier. So soak 1 tablespoon tamarind in ⅓ cup hot water for 20 to 30 minutes.
Once the tamarind gets soft, then squeeze the tamarind in the water itself. Discard the strained tamarind and 
keep the tamarind pulp aside.Rinse ½ cup tuvar dal (100 grams) a couple of times in fresh and clean water. 
You can use a strainer to rinse the lentils. Drain all the water and add the dal in a 2 litre stovetop pressure cooker.
Also add ¼ teaspoon turmeric powder. Cover and pressure cook dal for 7 to 8 whistles or 9 to 10 minutes on medium heat.
Take a pan heat oil, add  add vegetables of choice. Add sambar powder, salt and the tamarind water. 
Boil the the mixture and add cooked dal and serve hot with steamed rice');



-- PROCEDURE FOR INSERT INGREDIENT



DROP PROCEDURE IF EXISTS insertIngredient;
delimiter $$
create procedure insertIngredient(in ingredientName varchar(64), in quantity varchar(64))
begin
GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
SELECT @full_error;

IF EXISTS (SELECT i.ingredientName FROM Ingredient i where i.ingredientName=ingredientName) THEN
SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'Ingredient already present. Enter a new one';
END IF;
insert into Ingredient(ingredientName, quantity) values(ingredientName, quantity);
end $$
delimiter ;

call insertIngredient('oil', '20ml');
call insertIngredient('onion','150gms');
call insertIngredient('carrot','150gms');
call insertIngredient('beans','150gms');
call insertIngredient('bell peppers','150gms');
call insertIngredient('salt','5gms');
call insertIngredient('ginger','10gms');
call insertIngredient('garlic','10gms');
call insertIngredient('rice','250gms');
call insertIngredient('green onions','5gms');
call insertIngredient('tofu','250gms');
call insertIngredient('mushroom','150gms');
call insertIngredient('soy sauce','1tsp');
call insertIngredient('noodles','300gms');
call insertIngredient('sesame seeds','5gms');
call insertIngredient('chicken','250gms');
call insertIngredient('white pepper','1/2tsp');
call insertIngredient('cornflour','2tsp');
call insertIngredient('tomato ketchup','1tsp');
call insertIngredient('brown sugar','1tsp');
call insertIngredient('water','150ml');
call insertIngredient('cream cheese','15gms');
call insertIngredient('sour cream','20gms');
call insertIngredient('cheese mix','1tsp');
call insertIngredient('corn','100gms');
call insertIngredient('lentils','50gms');
call insertIngredient('sambar powder','2tsp');
call insertIngredient('tamrind','30ml');
call insertIngredient('biriyani masala','2tbsp');
call insertIngredient('cilantro','15gms');
call insertIngredient('avacado','250gms');
call insertIngredient('curry powder','3tsp');



-- PROCEDURE FOR INSERT DishMadeFromIngredient

DROP PROCEDURE IF EXISTS insertDishMadeFromIngredient;
delimiter $$
create procedure insertDishMadeFromIngredient(in dishId int, in ingredientId int)
begin
GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
SELECT @full_error;

IF NOT EXISTS (SELECT d.dishId FROM Dish d where d.dishId=dishId) THEN
SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'Invalid dish id';
END IF;

IF NOT EXISTS (SELECT i.ingredientId FROM Ingredient i where i.ingredientId=ingredientId) THEN
SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'Invalid ingredient id';
END IF;
	insert into DishMadeFromIngredient(dishId, ingredientId) values(dishId, ingredientId);
end $$
delimiter ;

call insertDishMadeFromIngredient(1,1);
call insertDishMadeFromIngredient(1,2);
call insertDishMadeFromIngredient(1,3);
call insertDishMadeFromIngredient(1,4);
call insertDishMadeFromIngredient(1,5);
call insertDishMadeFromIngredient(1,6);
call insertDishMadeFromIngredient(1,7);
call insertDishMadeFromIngredient(1,8);
call insertDishMadeFromIngredient(1,9);
call insertDishMadeFromIngredient(1,10);
call insertDishMadeFromIngredient(2,1);
call insertDishMadeFromIngredient(2,11);
call insertDishMadeFromIngredient(2,12);
call insertDishMadeFromIngredient(2,13);
call insertDishMadeFromIngredient(2,14);
call insertDishMadeFromIngredient(2,15);
call insertDishMadeFromIngredient(2,6);
call insertDishMadeFromIngredient(3,6);
call insertDishMadeFromIngredient(4,6);
call insertDishMadeFromIngredient(5,6);
call insertDishMadeFromIngredient(6,6);
call insertDishMadeFromIngredient(7,6);
call insertDishMadeFromIngredient(8,6);
call insertDishMadeFromIngredient(9,6);


select * from DishMadeFromIngredient;

-- PROCEDURE FOR INSERT CUSTOMER ORDER TABLE

DROP PROCEDURE IF EXISTS insertCustomerOrder;
delimiter $$
create procedure insertCustomerOrder(in orderStatus enum(
"Ongoing", "Completed"), in subTotal float, in promo varchar(10), 
in discount float)
begin

declare gTotal float;
GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
SELECT @full_error;  

IF LENGTH(promo)>5
THEN
SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'Promo code length invalid';
END IF;

set gTotal = subTotal - discount;
if (gTotal<discount) then 
SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'Discount cannot be greater than grand total';
END IF;
insert into CustomerOrder(orderStatus, subTotal,  promo,  discount, grandTotal) values(orderStatus, subTotal,  promo,  discount, gTotal);
end $$
delimiter ;

call insertCustomerOrder('Ongoing',40.20, 'AQ008', 5.5);
call insertCustomerOrder('Completed',22.20, 'AQ006', 2.5);
call insertCustomerOrder('Ongoing',30, 'CK001', 3.5);
call insertCustomerOrder('Completed',25.20, 'AH006', 2.7);
call insertCustomerOrder('Completed',29.20, 'AH008', 3);
call insertCustomerOrder('Ongoing',31.20, 'AH010', 3.2);
call insertCustomerOrder('Ongoing',41.80, 'BH010', 2.2);
call insertCustomerOrder('Ongoing',21.50, 'BO010', 2);
call insertCustomerOrder('Completed',19, 'CA019', 1.5);




-- PROCEDURE FOR CUSTOMER ORDER CONTAINS DISH TABLE

DROP PROCEDURE IF EXISTS insertCustomerOrderContainsDish;
delimiter $$
create procedure insertCustomerOrderContainsDish(in orderId int, in dishId int, in quantity int)
begin
GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
SELECT @full_error;

IF NOT EXISTS (SELECT c.orderId FROM CustomerOrder c where c.orderId=orderId) THEN
SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'Invalid order id';
END IF;

IF NOT EXISTS (SELECT c.dishId FROM Dish c where c.dishId=dishId) THEN
SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'Invalid dish id';
END IF;

If (quantity>50) or (quantity<1) THEN
SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'Invalid quantity';
END IF;

insert into CustomerOrderContainsDish(orderId, dishId, quantity) values(orderId, dishId, quantity);
end $$
delimiter ;



-- PROCEDURE FOR CUSTOMER ORDER DELETE CONTAINS DISH TABLE

DROP PROCEDURE IF EXISTS deleteCustomerOrderContainsDish;
delimiter $$
create procedure deleteCustomerOrderContainsDish(in orderId int, in dishId int)
begin
GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
SELECT @full_error;

IF NOT EXISTS (SELECT c.orderId FROM CustomerOrder c where c.orderId=orderId) THEN
SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'Invalid order id';
END IF;

IF NOT EXISTS (SELECT c.dishId FROM Dish c where c.dishId=dishId) THEN
SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'Invalid dish id';
END IF;

delete from CustomerOrderContainsDish c where c.orderId=orderId and c.dishId = dishId;
end $$
delimiter ;


-- PROCEDURE FOR RESTAURANT TABLE


DROP PROCEDURE IF EXISTS insertRestaurantTable;
delimiter $$
create procedure insertRestaurantTable(in tableStatus enum("Reserved", "Ongoing", "Free"),tableCapacity int)
begin
GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
SELECT @full_error;
if tableStatus not in ("Reserved", "Ongoing", "Free")
then
SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'Table status does not exist';
END IF;
if (tableCapacity>20)
then
SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'Capacity limit exceeded';
END IF;
 
insert into RestaurantTable( tableStatus, tableCapacity) values( tableStatus, tableCapacity);
end $$
delimiter ;

call insertRestaurantTable('Free',1);
call insertRestaurantTable('Free',1);
call insertRestaurantTable('Free',1);
call insertRestaurantTable('Free',2);
call insertRestaurantTable('Free',3);
call insertRestaurantTable('Free',3);
call insertRestaurantTable('Free',2);
call insertRestaurantTable('Free',2);
call insertRestaurantTable('Free',4);
call insertRestaurantTable('Free',4);
call insertRestaurantTable('Free',4);
call insertRestaurantTable('Free',5);
call insertRestaurantTable('Free',5);
call insertRestaurantTable('Free',5);
call insertRestaurantTable('Free',5);
call insertRestaurantTable('Free',4);
call insertRestaurantTable('Free',4);
call insertRestaurantTable('Free',6);
call insertRestaurantTable('Free',6);
call insertRestaurantTable('Free',7);
call insertRestaurantTable('Free',7);
call insertRestaurantTable('Free',7);
call insertRestaurantTable('Free',6);
call insertRestaurantTable('Free',6);
call insertRestaurantTable('Free',8);
call insertRestaurantTable('Free',10);
call insertRestaurantTable('Free',10);
call insertRestaurantTable('Free',12);
call insertRestaurantTable('Free',12);
call insertRestaurantTable('Free',12);
call insertRestaurantTable('Free',12);





-- PROCEDURE FOR GETTING ALL TABLES

DROP PROCEDURE IF EXISTS getAllTables;
delimiter $$
create procedure getAllTables( )
begin
select * from RestaurantTable;
end $$
delimiter ;





-- PROCEDURE FOR GET CUSTOMER DETAILS FROM CUSTOMER_ID

DROP PROCEDURE IF EXISTS getCustomerDetails;
delimiter $$
create procedure getCustomerDetails(in customerId int)
begin
select * from Customer c where c.customerId=customerId;
end $$
delimiter ;



-- PROCEDURE FOR GET ORDER DETAILS FROM ORDER_ID

DROP PROCEDURE IF EXISTS getOrderDetails;
delimiter $$
create procedure getOrderDetails(in orderId int)
begin
select * from CustomerOrderContainsDish c where c.orderId=orderId;
end $$
delimiter ;

call getOrderDetails("3");



-- FUNCTION FOR CHECKING ITS A NEW CUSTOMER

DROP function IF EXISTS ifNewCustomer;
delimiter $$
create function ifNewCustomer( mobile varchar(14) ) returns boolean
deterministic
begin
declare newCustomer boolean;
set newCustomer=0;
if exists(select * from Customer c where c .mobile=mobile) then set newCustomer=1;
end if;
return newCustomer;
end $$
delimiter ;

select ifNewCustomer('8573132285');



-- PROCEDURE FOR PAYMENT TABLE 


DROP PROCEDURE IF EXISTS insertPayment;
delimiter $$
create procedure insertPayment(in paymentMode enum("Credit card", "Cash") , in paymentStatus enum("Ongoing", "Successful", "Failed"),
orderId int, customerId int)
begin
GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
SELECT @full_error;

IF paymentStatus not in ("Ongoing", "Successful", "Failed")
then
SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'Payment status does not exist';
END IF;

IF paymentMode not in ("Credit card", "Cash")
then
SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'Payment mode not accepted';
END IF;

insert into Payment(paymentMode, paymentStatus, orderId, customerId) values(paymentMode, paymentStatus, orderId, customerId);
end $$
delimiter ;







DROP procedure IF EXISTS getRestaurantTableStatus;
delimiter $$
create procedure getRestaurantTableStatus(in tableNumber int)
begin
declare result varchar(64);
GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
  SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
  SELECT @full_error;

IF NOT EXISTS (SELECT * FROM RestaurantTable rt where rt.tableNumber=tableNumber) THEN
	SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'Table number entered not found';
END IF;

SELECT rt.tableStatus FROM RestaurantTable rt where rt.tableNumber=tableNumber;
end $$
delimiter ;



DROP function IF EXISTS getFreeRestaurantTable;
delimiter $$
create function getFreeRestaurantTable(capacity int) returns int
not deterministic
reads sql data
begin
declare tableNo int;
SELECT rt.tableNumber into tableNo FROM RestaurantTable rt where rt.tableStatus="Free" and rt.tableCapacity=capacity limit 1;
return tableNo;
end $$
delimiter ;


DROP function IF EXISTS getCustomerId;
delimiter $$
create function getCustomerId(mobile varchar(64)) returns int
not deterministic
reads sql data
begin
declare custId int;
SELECT c.customerId into custId FROM Customer c where c.mobile=mobile limit 1;
return custId;
end $$
delimiter ;



DROP function IF EXISTS getLatestOrderId;
delimiter $$
create function getLatestOrderId() returns int
not deterministic
reads sql data
begin
declare orderId int;
SELECT c.orderId into orderId FROM CustomerOrder c order by c.orderId desc limit 1;
return orderId;
end $$
delimiter ;


DROP procedure IF EXISTS updateRestaurantTableStatus;
delimiter $$
create procedure updateRestaurantTableStatus(in tableNumber int, in tableStatus enum("Free","Reserved","Ongoing"))
begin
declare result varchar(64);
GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
  SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
  SELECT @full_error;

IF NOT EXISTS (SELECT * FROM RestaurantTable rt where rt.tableNumber=tableNumber) THEN
	SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'Table number entered not found';
END IF;

UPDATE RestaurantTable rt set rt.tableStatus = tableStatus where rt.tableNumber=tableNumber;

end $$
delimiter ;



-- 1. TRIGGER
drop trigger if exists update_table_status;
DELIMITER $$
CREATE TRIGGER update_table_status
AFTER UPDATE
ON RestaurantTable FOR EACH ROW
BEGIN
declare oid int;
    IF  (NEW.tableStatus="Free") THEN
		select c.orderId into oid from CustomerWithOrderAtTable c where c.tableNumber=NEW.tableNumber;
        update CustomerOrder SET orderStatus = "Completed" where orderId = oid;
    END IF;
END$$
DELIMITER ;

-- 2.TRIGGER
drop trigger if exists update_orderTotal;
DELIMITER $$
CREATE TRIGGER update_orderTotal
BEFORE UPDATE
ON RestaurantTable FOR EACH ROW
BEGIN
declare oid int;
declare total float;
    IF  (NEW.tableStatus="Free") THEN
		select c.orderId into oid from CustomerWithOrderAtTable c where c.tableNumber=NEW.tableNumber;
        select round(sum(price*quantity),2) into total from Dish d right join CustomerOrderContainsDish c on d.dishId=c.dishId where orderId = oid;
        update CustomerOrder SET subTotal = total where orderId = oid;
        update CustomerOrder SET grandTotal = total where orderId = oid;
    END IF;
END$$
DELIMITER ;

select * from customerorder;
select round(sum(price*quantity),2) from Dish d right join CustomerOrderContainsDish c on d.dishId=c.dishId where orderId = 11;



-- 3.TRIGGER
drop trigger if exists remove_orderFromCurrentTable;
DELIMITER $$
CREATE TRIGGER remove_orderFromCurrentTable
AFTER UPDATE
ON RestaurantTable FOR EACH ROW
BEGIN
declare oid int;
declare total float;
    IF  (NEW.tableStatus="Free") THEN
        delete from CustomerWithOrderAtTable where tableNumber = NEW.tableNumber;
    END IF;
END$$
DELIMITER ;





-- 4.TRIGGER
drop trigger if exists addTopPaymentTable;
DELIMITER $$
CREATE TRIGGER addTopPaymentTable
AFTER UPDATE
ON CustomerOrder FOR EACH ROW
BEGIN
declare oid int;
declare cid int;
declare total float;
    IF  (NEW.orderStatus="Completed") THEN
		select c.orderId into oid from CustomerOrder c where c.orderId=NEW.orderId;
		select c.customerId into cid from CustomerWithOrderAtTable c where c.orderId=oid;
		insert into Payment values("Credit Card", "Successful",oid,cid);
    END IF;
END$$
DELIMITER ;



-- 1. EVENTS
DELIMITER $$
CREATE EVENT update_price
ON SCHEDULE EVERY '6' month
STARTS '2022-6-01 00:00:00'
DO 
BEGIN
 UPDATE Dish SET price = price + 1;
END$$
DELIMITER ;

select * from Dish;

-- 2. EVENT
drop event if exists update_salary;
DELIMITER $$
CREATE EVENT update_salary
ON SCHEDULE EVERY '1' year
STARTS '2022-6-01 00:00:00'
DO 
BEGIN
 UPDATE Staff SET salary = salary + (salary*0.03);
END$$
DELIMITER ;


-- COMPLEX QUERIES AND VISUALIZATIONS

-- sort dishs based on number of orders
drop procedure if exists sortDishesBasedOnNumberOfOrders;
delimiter $$
create procedure sortDishesBasedOnNumberOfOrders()
begin
select d.dishName as DishName, COALESCE(sum(c.quantity),0) as numberOfOrders 
from CustomerOrdercontainsdish c 
left join dish d on d.dishId = c.dishId 
group by c.dishId order by numberOfOrders desc;
end $$
delimiter ;

-- sort customers based on number of orders
drop procedure if exists sortCustomersBasedOnNumberOfOrders;
delimiter $$
create procedure sortCustomersBasedOnNumberOfOrders()
begin
select concat(c.firstname," ",c.lastname) as CustomerName, COALESCE(count(p.orderId),0) as numberOfOrders 
from customer c 
left join payment p on p.customerId = c.customerId 
group by c.customerId 
order by numberOfOrders desc;
end $$
delimiter ;

-- sort customers based on amount paid 
drop procedure if exists sortCustomersBasedOnAmount;
delimiter $$
create procedure sortCustomersBasedOnAmount()
begin
select concat(c.firstname," ",c.lastname) as CustomerName, COALESCE(round(sum(o.grandTotal),2),0) as Amount  
from customer c 
left join payment p on p.customerId = c.customerId 
left join CustomerOrder o on o.orderId = p.orderId  
group by c.customerId 
order by Amount desc;
end $$
delimiter ;

call sortCustomersBasedOnAmount;

-- most ordered dish by top customers
drop procedure if exists getMostOrderedDishByCustomers;
delimiter $$
create procedure getMostOrderedDishByCustomers()
begin
select concat(c.firstname," ",c.lastname) as CustomerName, d.dishName as DishName, COALESCE(sum(cd.quantity),0) as MostOrderedDish  
from customer c 
left join payment p on p.customerId = c.customerId 
left join CustomerOrder o on o.orderId = p.orderId  
left join CustomerOrderContainsDish cd on cd.orderId = o.orderId
right join Dish d on d.dishId=cd.dishId
group by c.customerId, d.dishId
order by MostOrderedDish desc ;
end $$
delimiter ;

call getMostOrderedDishByCustomers;

-- SELECT STATEMENTS


select * from Staff;
select * from CustomerOrder;
select * from CustomerOrderContainsDish;
select * from customer;
select * from restauranttable;
select * from customerwithorderattable;
select * from Payment;
select * from Dish;


