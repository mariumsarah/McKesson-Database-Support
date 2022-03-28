USE McKesson;


-- Query 1 
SELECT offeringName, 
SUM(quantity) as total_quantity
,AVG(cast(order_item_details.quantity as real)) as avg_quantity
,MIN(order_item_details.quantity) as lowest_quantity
,CASE
    WHEN SUM(quantity) > 1000  THEN 'The order is a BULK ORDER'
    ELSE 'The order is a REGULAR ORDER'
END AS BulkStatus
FROM offering 
INNER JOIN order_item_details ON offering.offeringID = order_item_details.offeringID
INNER JOIN orders ON order_item_details.orderid = orders.orderID 
WHERE offeringType = 'Item'
GROUP BY 1 ORDER BY 2 DESC LIMIT 5;


-- Query 2 
SELECT CustomerID, CustomerFirstName, CustomerLastName
,CASE
    WHEN healthInsuranceID IS NOT NULL THEN 'The customer is insured!'
    ELSE 'The customer is not insured!'
END AS InsuranceStatus
FROM customer;


-- Query 3
SELECT offering.offeringName as ItemName,
	COUNT(order_item_details.offeringID) as total_items 
 FROM 
orders,order_item_details,supplier_branch,offering
WHERE orders.orderID = order_item_details.orderID
AND order_item_details.supplierBranchID = supplier_branch.supplierBranchID 
AND order_item_details.offeringID = offering.offeringID
AND offering.offeringType = 'Item' 
AND supplier_branch.branchName IN ('Ethicon Inc, Chicago','Dentsply Sirona Inc, New York')
AND CAST(date_format(orders.orderdate, '%H') AS SIGNED) BETWEEN 0 AND 4
GROUP BY 1 ORDER BY 2 DESC LIMIT 5;



-- Query 4 
SELECT CAST(date_format(appointmentdate, '%H') AS SIGNED) AS hour_of_day,
COUNT(DISTINCT appointmentID) AS total_appointments
FROM appointment NATURAL JOIN healthcare_provider
WHERE isHealthCareDoctor = 1 AND doctorID IN (SELECT doctorID FROM healthcare_doctor NATURAL JOIN healthcare_center WHERE healthcarecentername LIKE '%NY')
GROUP BY 1 ORDER BY 2 DESC LIMIT 5;




-- Query 5 
SELECT diagnostic_test.testName
,COUNT(DISTINCT appointment.appointmentID) as total_appointments 
FROM test_assigned
INNER JOIN diagnostic_test 
ON test_assigned.testID = diagnostic_test.testID
INNER JOIN appointment 
ON test_assigned.appointmentID = appointment.appointmentID
GROUP BY 1 HAVING COUNT(DISTINCT appointment.customerID) > 1 
ORDER BY 2 DESC;



-- Query 6 View 1 
DROP VIEW IF EXISTS customers_info;
CREATE VIEW customers_info AS 
SELECT customer.* FROM customer NATURAL JOIN orders NATURAL JOIN order_item_details WHERE offeringID IN
(SELECT tOfferingID FROM item 
WHERE itemtype = 'Respiratory' 
UNION 
SELECT sOfferingID FROM service 
WHERE serviceRating is not null);
SELECT * FROM customers_info;


-- Query 6 View 2
-- Dynamic view of all items having at least 2 orders in the area consisting of the word ‘East Bay’
DROP VIEW IF EXISTS items_info;
CREATE VIEW items_info AS 
SELECT item.tOfferingID,itemType,offeringName,price,descriptions FROM item INNER JOIN offering ON item.tOfferingID = offering.offeringID
WHERE 
EXISTS
(SELECT order_item_details.offeringID 
FROM order_item_details
INNER JOIN orders 
ON orders.orderID = order_item_details.orderID
WHERE deliveryArea LIKE '%EastBay%' 
AND item.tOfferingID = order_item_details.offeringID
GROUP BY 1 HAVING SUM(quantity) >= 100);
SELECT * FROM items_info ORDER BY price DESC;





-- Query 7 Procedure
DROP PROCEDURE IF EXISTS unpurchased_item_price;
DELIMITER //
CREATE PROCEDURE unpurchased_item_price (IN number_X INT(11))
BEGIN
SELECT item.tOfferingID,itemType,offering.offeringName,offering.price
FROM item INNER JOIN offering ON item.tOfferingID = offering.offeringID
WHERE tOfferingID 
NOT IN (SELECT DISTINCT offeringID FROM order_item_details)
AND offering.price > number_X;
END //
DELIMITER ;
CALL unpurchased_item_price(40);









-- Query 8 Procedure 2 
DROP PROCEDURE IF EXISTS health_care_centers;
DELIMITER //
CREATE PROCEDURE health_care_centers (IN number_X INT(11))
BEGIN
SELECT healthcare_center.centerID,healthcarecentername,
CASE WHEN COUNT(DISTINCT nurseID) > 2 THEN 'More than 2 nurses' ELSE 'Less than 2 nurses' END AS nurses_category
FROM healthcare_center NATURAL JOIN nurse
GROUP BY 1,2 HAVING COUNT(DISTINCT nurseID) > number_X ;
END //
DELIMITER ;
CALL health_care_centers(2);