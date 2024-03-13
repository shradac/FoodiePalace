CREATE DATABASE  IF NOT EXISTS `foodiepalace` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `foodiepalace`;
-- MySQL dump 10.13  Distrib 8.0.30, for macos12 (x86_64)
--
-- Host: localhost    Database: foodiepalace
-- ------------------------------------------------------
-- Server version	8.0.30

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Customer`
--

DROP TABLE IF EXISTS `Customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Customer` (
  `customerId` int NOT NULL AUTO_INCREMENT,
  `firstName` varchar(64) NOT NULL,
  `lastName` varchar(64) NOT NULL,
  `mobile` varchar(14) NOT NULL,
  `email` varchar(64) NOT NULL,
  `streetAddress` varchar(64) DEFAULT NULL,
  `aptNumber` int DEFAULT NULL,
  `city` varchar(64) DEFAULT NULL,
  `state` varchar(64) DEFAULT NULL,
  `zipcode` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`customerId`),
  UNIQUE KEY `mobile` (`mobile`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customer`
--

LOCK TABLES `Customer` WRITE;
/*!40000 ALTER TABLE `Customer` DISABLE KEYS */;
INSERT INTO `Customer` VALUES (1,'Paul','Christian','7651236541','christianpaul@gmail.com','Washington Street',1278,'Boston','Massachusetts','02213'),(2,'Emma','Olivia','7632236541','emmaolivia@gmail.com','Washington Street',1978,'Boston','Massachusetts','02213'),(3,'Noah','Charlotte','6632236549','charlottenoah@gmail.com','kenmore Street',78,'Boston','Massachusetts','01213'),(4,'Logan','Carl','6718906549','logancarl@gmail.com','Columbia Street',78,'Boston','Massachusetts','01213'),(5,'Anna','Hudson','7812043566','annahudson@gmail.com','Harvest Street',189,'Boston','Massachusetts','02219');
/*!40000 ALTER TABLE `Customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CustomerOrder`
--

DROP TABLE IF EXISTS `CustomerOrder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CustomerOrder` (
  `orderId` int NOT NULL AUTO_INCREMENT,
  `orderStatus` enum('Ongoing','Completed') NOT NULL,
  `subTotal` float NOT NULL DEFAULT '0',
  `promo` varchar(10) DEFAULT NULL,
  `discount` float DEFAULT '0',
  `grandTotal` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`orderId`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CustomerOrder`
--

LOCK TABLES `CustomerOrder` WRITE;
/*!40000 ALTER TABLE `CustomerOrder` DISABLE KEYS */;
INSERT INTO `CustomerOrder` VALUES (1,'Ongoing',40.2,'AQ008',5.5,34.7),(2,'Completed',22.2,'AQ006',2.5,19.7),(3,'Ongoing',30,'CK001',3.5,26.5),(4,'Completed',25.2,'AH006',2.7,22.5),(5,'Completed',29.2,'AH008',3,26.2),(6,'Ongoing',31.2,'AH010',3.2,28),(7,'Ongoing',41.8,'BH010',2.2,39.6),(8,'Ongoing',21.5,'BO010',2,19.5),(9,'Completed',19,'CA019',1.5,17.5),(10,'Completed',41.4,'',0,41.4),(11,'Completed',29.16,'',0,29.16),(12,'Completed',156.92,'',0,156.92),(13,'Completed',87.56,'',0,87.56),(14,'Completed',103.46,'',0,103.46),(15,'Completed',254.8,'',0,254.8),(16,'Completed',296.78,'',0,296.78),(17,'Completed',70.62,'',0,70.62),(18,'Completed',110.52,'',0,110.52),(19,'Completed',153.7,'',0,153.7),(20,'Completed',231.56,'',0,231.56),(21,'Completed',60.12,'',0,60.12);
/*!40000 ALTER TABLE `CustomerOrder` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `addTopPaymentTable` AFTER UPDATE ON `customerorder` FOR EACH ROW BEGIN
declare oid int;
declare cid int;
declare total float;
    IF  (NEW.orderStatus="Completed") THEN
		select c.orderId into oid from CustomerOrder c where c.orderId=NEW.orderId;
		select c.customerId into cid from CustomerWithOrderAtTable c where c.orderId=oid;
		insert into Payment values("Credit Card", "Successful",oid,cid);
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `CustomerOrderContainsDish`
--

DROP TABLE IF EXISTS `CustomerOrderContainsDish`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CustomerOrderContainsDish` (
  `orderId` int NOT NULL,
  `dishId` int NOT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`orderId`,`dishId`),
  KEY `fk_CustomerOrderContainsDish_Dish` (`dishId`),
  CONSTRAINT `fk_CustomerOrderContainsDish_CustomerOrder` FOREIGN KEY (`orderId`) REFERENCES `CustomerOrder` (`orderId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_CustomerOrderContainsDish_Dish` FOREIGN KEY (`dishId`) REFERENCES `Dish` (`dishId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CustomerOrderContainsDish`
--

LOCK TABLES `CustomerOrderContainsDish` WRITE;
/*!40000 ALTER TABLE `CustomerOrderContainsDish` DISABLE KEYS */;
INSERT INTO `CustomerOrderContainsDish` VALUES (10,1,1),(10,4,1),(10,10,1),(11,3,1),(11,10,1),(12,1,2),(12,2,2),(12,6,3),(12,10,1),(13,2,1),(13,7,2),(13,9,2),(14,1,2),(14,3,1),(14,4,1),(14,5,2),(14,6,1),(15,1,2),(15,6,2),(15,7,2),(15,8,3),(15,9,4),(16,1,7),(16,3,3),(16,4,2),(16,6,2),(16,7,2),(16,10,3),(17,1,2),(17,3,2),(17,4,1),(18,1,3),(18,3,2),(18,4,2),(18,7,1),(19,1,3),(19,4,2),(19,6,1),(19,8,3),(20,1,6),(20,2,3),(20,3,3),(20,5,1),(20,10,2),(21,1,2),(21,3,2);
/*!40000 ALTER TABLE `CustomerOrderContainsDish` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CustomerWithOrderAtTable`
--

DROP TABLE IF EXISTS `CustomerWithOrderAtTable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CustomerWithOrderAtTable` (
  `tableNumber` int NOT NULL,
  `customerId` int NOT NULL,
  `orderId` int NOT NULL,
  PRIMARY KEY (`tableNumber`,`customerId`,`orderId`),
  KEY `fk_CustomerWithOrderAtTable_customer` (`customerId`),
  KEY `fk_CustomerWithOrderAtTable_order` (`orderId`),
  CONSTRAINT `fk_CustomerWithOrderAtTable_customer` FOREIGN KEY (`customerId`) REFERENCES `Customer` (`customerId`),
  CONSTRAINT `fk_CustomerWithOrderAtTable_order` FOREIGN KEY (`orderId`) REFERENCES `CustomerOrder` (`orderId`),
  CONSTRAINT `fk_CustomerWithOrderAtTable_table` FOREIGN KEY (`tableNumber`) REFERENCES `RestaurantTable` (`tableNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CustomerWithOrderAtTable`
--

LOCK TABLES `CustomerWithOrderAtTable` WRITE;
/*!40000 ALTER TABLE `CustomerWithOrderAtTable` DISABLE KEYS */;
/*!40000 ALTER TABLE `CustomerWithOrderAtTable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Dish`
--

DROP TABLE IF EXISTS `Dish`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Dish` (
  `dishId` int NOT NULL AUTO_INCREMENT,
  `dishName` varchar(64) NOT NULL,
  `price` float NOT NULL,
  `cuizine` varchar(64) NOT NULL,
  `isVegan` tinyint(1) NOT NULL,
  `menuId` int DEFAULT NULL,
  `instructions` text NOT NULL,
  PRIMARY KEY (`dishId`),
  KEY `fk_menu_dish` (`menuId`),
  CONSTRAINT `fk_menu_dish` FOREIGN KEY (`menuId`) REFERENCES `Menu` (`menuId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Dish`
--

LOCK TABLES `Dish` WRITE;
/*!40000 ALTER TABLE `Dish` DISABLE KEYS */;
INSERT INTO `Dish` VALUES (1,'Vegetable Fried Rice',15.9,'Chinese',1,1,'Add oil and swirl the pan to coat the bottom.Add the veggies of choice and salt.\nAdd the ginger, garlic and red pepper flakes, and cook until fragrant while stirring constantly, about 30 seconds. \nAdd the rice and mix it all together.Add the greens (if using) and green onions and serve with sauce of choice'),(2,'Tofu and Mushroom Stir Fry',17.56,'Chinese',1,1,'Sauté garlic. In a large wok or skillet, heat oil over \nmedium-high heat for 2 minutes until the hot oil sizzles.\n--  Add garlic and sauté until fragrant, about 1 minute.\n-- Stir fry vegetables. Add mushrooms and tofu and stir to cook until nicely browned, about 3-4 minutes. Add bok choy and stir fry for 2 minutes, allowing it to soften.\n-- Add in sauce. Stir in soy sauce, vinegar and pepper. Mix well until evenly distributed. Drizzle with sesame oil and sprinkle sesame seeds on top.\n-- Serve. Serve immediately with steamed rice or over a plate of fried noodles.'),(3,'Chicken Manchurian',14.16,'Chinese',0,1,'Add all the marination ingredients to the chicken. See the recipe card at the end. Leave for 30 mins.\n Fry the chicken in oil on medium heat till they are cooked and crispy. You can pan-fry the chicken if you dont like deep-frying.\n Combine all the sauce ingredients in the recipe card. You can add the broth (water + stock cube) to the prepped sauce or add it to the pan later. \n Toast the garlic. Then fry the bell pepper for 2 mins. The bell pepper will continue to cook in the sauce. Pour the sauce and the broth (if you didnt add to the sauce earlier).\nAdd the spring onion and chicken and toss.'),(4,'Hot Cheesy Corn Dip with Topping',10.5,'Mexican',0,2,'Preheat oven 180°C. Meanwhile, in a large bowl, combine cream cheese, sour cream, cheese, garlic dressing, paprika and bacon, reserving some bacon for garnish. Stir until fully combined\n Gently stir through corn and pour into an 8 cup capacity baking dish. Top with extra cheese mix. Bake for 25 minutes or until bubbly\n To serve, top with reserved bacon bits, shallots and tortillas'),(5,'Mexican Chicken Tacos',11,'Mexican',0,2,'Preheat oven to 220°C / 200°C fan-forced. Place taco shells in a greased baking dish, upside-down\n Bake for 2 to 3 minutes, or until warm. Remove. Cool slightly. Turn, open-side up\n Heat oil in a large frying pan over medium heat. Add onion. Cook, stirring for 3 to 4 minutes, or until soft. Add taco seasoning and cook, stirring for 30 seconds, or until fragrant. Add chicken, beans, salsa and water. Cook, stirring for 2 to 3 minutes, or until combined and heated through. Remove from heat\n Divide chicken mixture amongst taco shells. Sprinkle evenly with Mexican Style cheese\n Bake for 12 minutes, or until cheese is melted and shells are golden and crisp. Remove from oven\n Scatter baked tacos with tomatoes. Dollop with mashed avocado. Garnish with coriander leaves. Serve with lime wedges'),(6,'Family Nachos Tray Bake',25,'Mexican',0,2,'Preheat oven to 220°C / 200°C fan-forced. Grease and line a large oven tray with baking paper\n Heat oil in a large frying pan over medium heat. Add onion. Cook, stirring occasionally, until soft. Add mince. Cook, stirring to break up lumps for about 5 minutes, or until browned.\n  Add taco seasoning and cook, stirring for 30 seconds, or until fragrant\n Stir in salsa, beans, corn and water. Bring to the boil. Simmer, stirring occasionally, for about 12 minutes or until thickened. Remove from heat\n Arrange corn chips over prepared tray. Sprinkle with half the Mexican Style cheese. Top with beef mixture. Sprinkle with remaining cheese\n Bake for 10 - 12 minutes, or until cheese is melted and golden brown. Remove from oven\n Scatter tomatoes over nachos. Top with avocado and sour cream if using. Serve with lime wedges'),(7,'Vegan Red Lentil Curry',13.5,'Indian',1,3,'Dice up your ginger, garlic, chili peppers, and turmeric (if using fresh).\nSauté the ginger, garlic, chili peppers, and turmeric (if using fresh) in hot oil for about 2 minutes, until fragrant.\n Then, add the ground spices and cook for 30-60 seconds, stirring frequently to prevent burning.\n Deglaze with the vegetable broth, then add in the red lentils and crushed tomatoes.\n Simmer, covered, for 20 to 25 minutes, or until the lentils are cooked through.\n Stir in the coconut milk and almond butter.\n Continue cooking, uncovered, for 5 to 8 minutes, until the curry has thickened.\nFinally, stir in the lemon juice and cilantro, and season to taste.'),(8,'Chicken Biriyani',20,'Indian',1,3,'Combine the chicken in a bowl with the yogurt, curry powder, \nand cinnamon and let marinate for at least 1 hour but preferably for 4 hours. \nHeat the butter in a skillet over medium-high heat and cook the onions until golden, 7-8 minutes.\nAdd the garlic and ginger and cook for another 2 minutes. \nAdd the chicken and all of the marinade along with the salt. \nStir to combine, reduce the heat to medium-low, cover, and cook until the chicken is cooked through, 6-7 minutes, stirring occasionally.\nAdd the cooked rice, cilantro and raisins.  Pour the chicken stock over the mixture.  \nBring to simmer.  Cover and simmer 3-4 minutes until the mixture is heated through.Add salt to taste. Serve hot.'),(9,'Lentil Sambar with Steamed Rice',21.5,'Indian',1,3,'Soak tamarind in water\nearlier. So soak 1 tablespoon tamarind in ⅓ cup hot water for 20 to 30 minutes.\nOnce the tamarind gets soft, then squeeze the tamarind in the water itself. Discard the strained tamarind and \nkeep the tamarind pulp aside.Rinse ½ cup tuvar dal (100 grams) a couple of times in fresh and clean water. \nYou can use a strainer to rinse the lentils. Drain all the water and add the dal in a 2 litre stovetop pressure cooker.\nAlso add ¼ teaspoon turmeric powder. Cover and pressure cook dal for 7 to 8 whistles or 9 to 10 minutes on medium heat.\nTake a pan heat oil, add  add vegetables of choice. Add sambar powder, salt and the tamarind water. \nBoil the the mixture and add cooked dal and serve hot with steamed rice'),(10,'Egg Noodles',15,'Chinese',0,1,'Add oil to a pan. Add garlic, vegetables of choice and toss until the vegetables are juicy. Prepare scrambled egg with required number of egg. Add the scrambled eggs to the vegetables. Add salt, pepper and boiled noodles. Serve in a bowl.');
/*!40000 ALTER TABLE `Dish` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DishMadeFromIngredient`
--

DROP TABLE IF EXISTS `DishMadeFromIngredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DishMadeFromIngredient` (
  `dishId` int NOT NULL,
  `ingredientId` int NOT NULL,
  PRIMARY KEY (`dishId`,`ingredientId`),
  KEY `fk_DishMadeFromIngredient_ingredient` (`ingredientId`),
  CONSTRAINT `fk_DishMadeFromIngredient_dish` FOREIGN KEY (`dishId`) REFERENCES `Dish` (`dishId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_DishMadeFromIngredient_ingredient` FOREIGN KEY (`ingredientId`) REFERENCES `Ingredient` (`ingredientId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DishMadeFromIngredient`
--

LOCK TABLES `DishMadeFromIngredient` WRITE;
/*!40000 ALTER TABLE `DishMadeFromIngredient` DISABLE KEYS */;
INSERT INTO `DishMadeFromIngredient` VALUES (1,1),(2,1),(1,2),(1,3),(1,4),(1,5),(1,6),(2,6),(3,6),(4,6),(5,6),(6,6),(7,6),(8,6),(9,6),(1,7),(1,8),(1,9),(1,10),(2,11),(2,12),(2,13),(2,14),(2,15);
/*!40000 ALTER TABLE `DishMadeFromIngredient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Ingredient`
--

DROP TABLE IF EXISTS `Ingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Ingredient` (
  `ingredientId` int NOT NULL AUTO_INCREMENT,
  `ingredientName` varchar(64) NOT NULL,
  `quantity` varchar(64) NOT NULL,
  PRIMARY KEY (`ingredientId`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ingredient`
--

LOCK TABLES `Ingredient` WRITE;
/*!40000 ALTER TABLE `Ingredient` DISABLE KEYS */;
INSERT INTO `Ingredient` VALUES (1,'oil','20ml'),(2,'onion','150gms'),(3,'carrot','150gms'),(4,'beans','150gms'),(5,'bell peppers','150gms'),(6,'salt','5gms'),(7,'ginger','10gms'),(8,'garlic','10gms'),(9,'rice','250gms'),(10,'green onions','5gms'),(11,'tofu','250gms'),(12,'mushroom','150gms'),(13,'soy sauce','1tsp'),(14,'noodles','300gms'),(15,'sesame seeds','5gms'),(16,'chicken','250gms'),(17,'white pepper','1/2tsp'),(18,'cornflour','2tsp'),(19,'tomato ketchup','1tsp'),(20,'brown sugar','1tsp'),(21,'water','150ml'),(22,'cream cheese','15gms'),(23,'sour cream','20gms'),(24,'cheese mix','1tsp'),(25,'corn','100gms'),(26,'lentils','50gms'),(27,'sambar powder','2tsp'),(28,'tamrind','30ml'),(29,'biriyani masala','2tbsp'),(30,'cilantro','15gms'),(31,'avacado','250gms'),(32,'curry powder','3tsp');
/*!40000 ALTER TABLE `Ingredient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Menu`
--

DROP TABLE IF EXISTS `Menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Menu` (
  `menuId` int NOT NULL AUTO_INCREMENT,
  `title` varchar(64) NOT NULL,
  PRIMARY KEY (`menuId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Menu`
--

LOCK TABLES `Menu` WRITE;
/*!40000 ALTER TABLE `Menu` DISABLE KEYS */;
INSERT INTO `Menu` VALUES (1,'Chinese'),(2,'Mexican'),(3,'Indian');
/*!40000 ALTER TABLE `Menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Payment`
--

DROP TABLE IF EXISTS `Payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Payment` (
  `paymentMode` enum('Credit Card','Cash') NOT NULL,
  `paymentStatus` enum('Ongoing','Successful','Failed') NOT NULL,
  `orderId` int NOT NULL,
  `customerId` int NOT NULL,
  PRIMARY KEY (`orderId`,`customerId`),
  KEY `fk_Payment_Customer` (`customerId`),
  CONSTRAINT `fk_Payment_Customer` FOREIGN KEY (`customerId`) REFERENCES `Customer` (`customerId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Payment_CustomerOrder` FOREIGN KEY (`orderId`) REFERENCES `CustomerOrder` (`orderId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Payment`
--

LOCK TABLES `Payment` WRITE;
/*!40000 ALTER TABLE `Payment` DISABLE KEYS */;
INSERT INTO `Payment` VALUES ('Credit Card','Successful',10,1),('Credit Card','Successful',11,1),('Credit Card','Successful',12,1),('Credit Card','Successful',13,1),('Credit Card','Successful',14,2),('Credit Card','Successful',15,2),('Credit Card','Successful',16,2),('Credit Card','Successful',17,3),('Credit Card','Successful',18,3),('Credit Card','Successful',19,4),('Credit Card','Successful',20,4),('Credit Card','Successful',21,5);
/*!40000 ALTER TABLE `Payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RestaurantTable`
--

DROP TABLE IF EXISTS `RestaurantTable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RestaurantTable` (
  `tableNumber` int NOT NULL AUTO_INCREMENT,
  `tableStatus` enum('Reserved','Ongoing','Free') NOT NULL,
  `tableCapacity` int DEFAULT '1',
  PRIMARY KEY (`tableNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RestaurantTable`
--

LOCK TABLES `RestaurantTable` WRITE;
/*!40000 ALTER TABLE `RestaurantTable` DISABLE KEYS */;
INSERT INTO `RestaurantTable` VALUES (1,'Free',1),(2,'Free',1),(3,'Free',1),(4,'Free',2),(5,'Free',3),(6,'Free',3),(7,'Free',2),(8,'Free',2),(9,'Free',4),(10,'Free',4),(11,'Free',4),(12,'Free',5),(13,'Free',5),(14,'Free',5),(15,'Free',5),(16,'Free',4),(17,'Free',4),(18,'Free',6),(19,'Free',6),(20,'Free',7),(21,'Free',7),(22,'Free',7),(23,'Free',6),(24,'Free',6),(25,'Free',8),(26,'Free',10),(27,'Free',10),(28,'Free',12),(29,'Free',12),(30,'Free',12),(31,'Free',12);
/*!40000 ALTER TABLE `RestaurantTable` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_orderTotal` BEFORE UPDATE ON `restauranttable` FOR EACH ROW BEGIN
declare oid int;
declare total float;
    IF  (NEW.tableStatus="Free") THEN
		select c.orderId into oid from CustomerWithOrderAtTable c where c.tableNumber=NEW.tableNumber;
        select round(sum(price*quantity),2) into total from Dish d right join CustomerOrderContainsDish c on d.dishId=c.dishId where orderId = oid;
        update CustomerOrder SET subTotal = total where orderId = oid;
        update CustomerOrder SET grandTotal = total where orderId = oid;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_table_status` AFTER UPDATE ON `restauranttable` FOR EACH ROW BEGIN
declare oid int;
    IF  (NEW.tableStatus="Free") THEN
		select c.orderId into oid from CustomerWithOrderAtTable c where c.tableNumber=NEW.tableNumber;
        update CustomerOrder SET orderStatus = "Completed" where orderId = oid;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `remove_orderFromCurrentTable` AFTER UPDATE ON `restauranttable` FOR EACH ROW BEGIN
declare oid int;
declare total float;
    IF  (NEW.tableStatus="Free") THEN
        delete from CustomerWithOrderAtTable where tableNumber = NEW.tableNumber;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Staff`
--

DROP TABLE IF EXISTS `Staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Staff` (
  `staffId` int NOT NULL AUTO_INCREMENT,
  `firstName` varchar(64) NOT NULL,
  `lastName` varchar(64) NOT NULL,
  `mobile` varchar(14) NOT NULL,
  `email` varchar(64) NOT NULL,
  `salary` int NOT NULL,
  `streetAddress` varchar(64) DEFAULT NULL,
  `aptNumber` int DEFAULT NULL,
  `city` varchar(64) DEFAULT NULL,
  `state` varchar(64) DEFAULT NULL,
  `zipcode` varchar(5) DEFAULT NULL,
  `chef` tinyint(1) NOT NULL DEFAULT '0',
  `administrator` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`staffId`),
  UNIQUE KEY `mobile` (`mobile`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Staff`
--

LOCK TABLES `Staff` WRITE;
/*!40000 ALTER TABLE `Staff` DISABLE KEYS */;
INSERT INTO `Staff` VALUES (2,'Racheal','Green','7812064500','greenracheal@gmail.com',98000,'Beacon Street',2341,'Boston','Massachusetts','2213',0,1),(4,'Liu','Huan','8912064508','lihuan@gmail.com',90000,'Washington Street',1341,'Boston','Massachusetts','2212',1,0),(5,'Venkatesh','Bhatt','4562064508','venkatbhatt@gmail.com',100000,'Brooklyn Street',41,'Boston','Massachusetts','4512',1,0),(6,' Enrique','Olvera','7562064570',' enriqueolvera@gmail.com',103000,'Park Drive',1241,'Boston','Massachusetts','6512',1,0),(7,'Daniel','Ray','7812064522','daniel@gmail.com',80000,'Boylston Street',1200,'Boston','Massachusetts','02215',0,1),(8,'Monica','Geller','8573131111','monica@gmail.com',90000,'Boylston Street',1209,'Boston','Massachusetts','02215',1,0);
/*!40000 ALTER TABLE `Staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'foodiepalace'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `update_price` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `update_price` ON SCHEDULE EVERY 6 MONTH STARTS '2022-06-01 00:00:00' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
 UPDATE Dish SET price = price + 1;
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `update_salary` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `update_salary` ON SCHEDULE EVERY 1 YEAR STARTS '2022-06-01 00:00:00' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
 UPDATE Staff SET salary = salary + (salary*0.03);
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'foodiepalace'
--
/*!50003 DROP FUNCTION IF EXISTS `getCustomerId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getCustomerId`(mobile varchar(64)) RETURNS int
    READS SQL DATA
begin
declare custId int;
SELECT c.customerId into custId FROM Customer c where c.mobile=mobile limit 1;
return custId;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getFreeRestaurantTable` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getFreeRestaurantTable`(capacity int) RETURNS int
    READS SQL DATA
begin
declare tableNo int;
SELECT rt.tableNumber into tableNo FROM RestaurantTable rt where rt.tableStatus="Free" and rt.tableCapacity=capacity limit 1;
return tableNo;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getLatestOrderId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getLatestOrderId`() RETURNS int
    READS SQL DATA
begin
declare orderId int;
SELECT c.orderId into orderId FROM CustomerOrder c order by c.orderId desc limit 1;
return orderId;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `ifNewCustomer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `ifNewCustomer`( mobile varchar(14) ) RETURNS tinyint(1)
    DETERMINISTIC
begin
declare newCustomer boolean;
set newCustomer=0;
if exists(select * from Customer c where c .mobile=mobile) then set newCustomer=1;
end if;
return newCustomer;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteCustomerOrderContainsDish` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteCustomerOrderContainsDish`(in orderId int, in dishId int)
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
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteStaff` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteStaff`(in staffId int)
begin
GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
SELECT @full_error;

IF not EXISTS (SELECT s.staffId FROM Staff s where s.staffId=staffId) THEN
SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'Staff does not exist';
END IF;

delete from Staff s where s.staffId=staffId;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getAdmin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAdmin`(in staffId int )
begin
select * from Staff s where administrator=true and s.staffId=staffId;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getAllAdmin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllAdmin`()
begin
select * from Staff where administrator=true;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getAllChef` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllChef`()
begin
select * from Staff where chef=true;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getAllCustomers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllCustomers`()
begin
select * from Customer;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getAllTables` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllTables`( )
begin
select * from RestaurantTable;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getChef` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getChef`(in staffId int )
begin
select * from Staff s where chef=true and s.staffId=staffId;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getCustomerDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getCustomerDetails`(in customerId int)
begin
select * from Customer c where c.customerId=customerId;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getDishOfMenu` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getDishOfMenu`( in menuId int)
begin
select * from Dish d where d.menuId = menuId;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getMostOrderedDishByCustomers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getMostOrderedDishByCustomers`()
begin
select concat(c.firstname," ",c.lastname) as CustomerName, d.dishName as DishName, COALESCE(sum(cd.quantity),0) as MostOrderedDish  
from customer c 
left join payment p on p.customerId = c.customerId 
left join CustomerOrder o on o.orderId = p.orderId  
left join CustomerOrderContainsDish cd on cd.orderId = o.orderId
right join Dish d on d.dishId=cd.dishId
group by c.customerId, d.dishId
order by MostOrderedDish desc ;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getOrderDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getOrderDetails`(in orderId int)
begin
select * from CustomerOrderContainsDish c where c.orderId=orderId;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getRestaurantTableStatus` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getRestaurantTableStatus`(in tableNumber int)
begin
declare result varchar(64);
GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
  SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
  SELECT @full_error;

IF NOT EXISTS (SELECT * FROM RestaurantTable rt where rt.tableNumber=tableNumber) THEN
	SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'Table number entered not found';
END IF;

SELECT rt.tableStatus FROM RestaurantTable rt where rt.tableNumber=tableNumber;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getTableDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getTableDetails`(in tableNumber int)
begin
select * from CustomerWithOrderAtTable c where c.tableNumber = tableNumber limit 1;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertCustomer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertCustomer`(in firstName varchar(64), in lastName  varchar(64), in mobile varchar(14), in email varchar(64),
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
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertCustomerOrder` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertCustomerOrder`(in orderStatus enum(
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
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertCustomerOrderContainsDish` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertCustomerOrderContainsDish`(in orderId int, in dishId int, in quantity int)
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
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertCustomerWithOrderAtTable` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertCustomerWithOrderAtTable`(in tableNumber int, in customerId int, in orderId int)
begin
insert into CustomerWithOrderAtTable values(tableNumber, customerId, orderId);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertDish` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertDish`( in dishName varchar(64), in price float,in isVegan boolean, in menuId int, in instructions text)
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
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertDishMadeFromIngredient` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertDishMadeFromIngredient`(in dishId int, in ingredientId int)
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
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertIngredient` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertIngredient`(in ingredientName varchar(64), in quantity varchar(64))
begin
GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
SELECT @full_error;

IF EXISTS (SELECT i.ingredientName FROM Ingredient i where i.ingredientName=ingredientName) THEN
SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'Ingredient already present. Enter a new one';
END IF;
insert into Ingredient(ingredientName, quantity) values(ingredientName, quantity);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertPayment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertPayment`(in paymentMode enum("Credit card", "Cash") , in paymentStatus enum("Ongoing", "Successful", "Failed"),
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
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertRestaurantTable` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertRestaurantTable`(in tableStatus enum("Reserved", "Ongoing", "Free"),tableCapacity int)
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
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertStaffAdmin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertStaffAdmin`(in firstName varchar(64) , in lastName  varchar(64) ,in mobile varchar(14),in email varchar(64) ,in salary int,
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
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertStaffChef` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertStaffChef`(in firstName varchar(64) , in lastName  varchar(64) ,in mobile varchar(14),in email varchar(64) ,in salary int,
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
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sortCustomersBasedOnAmount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sortCustomersBasedOnAmount`()
begin
select concat(c.firstname," ",c.lastname) as CustomerName, COALESCE(round(sum(o.grandTotal),2),0) as Amount  
from customer c 
left join payment p on p.customerId = c.customerId 
left join CustomerOrder o on o.orderId = p.orderId  
group by c.customerId 
order by Amount desc;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sortCustomersBasedOnNumberOfOrders` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sortCustomersBasedOnNumberOfOrders`()
begin
select concat(c.firstname," ",c.lastname) as CustomerName, COALESCE(count(p.orderId),0) as numberOfOrders 
from customer c 
left join payment p on p.customerId = c.customerId 
group by c.customerId 
order by numberOfOrders desc;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sortDishesBasedOnNumberOfOrders` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sortDishesBasedOnNumberOfOrders`()
begin
select d.dishName as DishName, COALESCE(sum(c.quantity),0) as numberOfOrders 
from CustomerOrdercontainsdish c 
left join dish d on d.dishId = c.dishId 
group by c.dishId order by numberOfOrders desc;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateRestaurantTableStatus` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateRestaurantTableStatus`(in tableNumber int, in tableStatus enum("Free","Reserved","Ongoing"))
begin
declare result varchar(64);
GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
  SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
  SELECT @full_error;

IF NOT EXISTS (SELECT * FROM RestaurantTable rt where rt.tableNumber=tableNumber) THEN
	SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'Table number entered not found';
END IF;

UPDATE RestaurantTable rt set rt.tableStatus = tableStatus where rt.tableNumber=tableNumber;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateStaff` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateStaff`(in staffId int,in firstName varchar(64) , in lastName  varchar(64) ,in mobile varchar(14),in email varchar(64) ,in salary int,
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

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-09 20:07:38
