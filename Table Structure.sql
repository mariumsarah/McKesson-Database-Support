


-- STEP 1 --------------------------------------------------------
DROP DATABASE IF EXISTS McKesson;
-- Database: `healthcare_mckesson`
--
CREATE DATABASE IF NOT EXISTS `McKesson`;
USE `McKesson`;


-- STEP 2 --------------------------------------------------------

--
-- Table structure for table `appointment`
--

DROP TABLE IF EXISTS appointment;
CREATE TABLE appointment(
 appointmentID int(11) NOT NULL AUTO_INCREMENT,
 doctorID int(11) NOT NULL,
 customerID int(11) NOT NULL,
 appointmentDate datetime NOT NULL,
 appointmentType varchar(50),
 reqDocType varchar(50) ,
 reasonDesc varchar(50) NOT NULL,
 appointReview varchar(300) ,
 resultStatus varchar(50) NOT NULL ,
 appointmentReturnDate date,
 CONSTRAINT appointment_pk PRIMARY KEY (appointmentID)
 ) 
ENGINE = INNODB;

-- --------------------------------------------------------

--
-- Table structure for table `doctor_specialization`
--

DROP TABLE IF EXISTS doctor_specialization;
CREATE TABLE doctor_specialization(
 doctorID int(11) NOT NULL,
 doctorSpecialization varchar(100) NOT NULL,
 CONSTRAINT doctor_specialization_pk PRIMARY KEY (doctorId,doctorSpecialization)
 )
ENGINE = INNODB;

-- --------------------------------------------------------

--
-- Table structure for table `healthcare_provider`
--

DROP TABLE IF EXISTS healthcare_provider;
CREATE TABLE healthcare_provider(
 doctorID int(11) NOT NULL AUTO_INCREMENT,
 docFullName varchar(100) NOT NULL,
 phoneNo varchar(10) NOT NULL,
 isHealthCareDoctor Boolean NOT NULL,
 isIndependent Boolean NOT NULL,
 CONSTRAINT healthcare_provider_pk PRIMARY KEY (doctorID))
ENGINE = INNODB;

-- --------------------------------------------------------

--
-- Table structure for table `schedule_t`
--

DROP TABLE IF EXISTS schedule_t;
CREATE TABLE schedule_t(
 scheduleID int(11) NOT NULL,
 timeOfDay timestamp NOT NULL,
 dayOfWeek int(11) NOT NULL,
CONSTRAINT schedule_t_pk PRIMARY KEY (scheduleID,timeOfDay,dayOfWeek))
ENGINE = INNODB;


-- --------------------------------------------------------

--
-- Table structure for table `usage_schedule`
--

DROP TABLE IF EXISTS usage_schedule;
CREATE TABLE usage_schedule(
 scheduleID int(11) NOT NULL AUTO_INCREMENT,
 offeringID int(11) NOT NULL,
 appointmentID int(11) NOT NULL,
 untilDate date NOT NULL,
CONSTRAINT usage_schedule_schedule_pk PRIMARY KEY (scheduleID))
ENGINE = INNODB;

-- --------------------------------------------------------

--
-- Table structure for table `independent_doctor`
--

DROP TABLE IF EXISTS independent_doctor;
CREATE TABLE independent_doctor(
 iDoctorID int(11) NOT NULL,
 hourlyFee int(11) NOT NULL,
 docAddress varchar(100) ,
CONSTRAINT independent_doctor_pk PRIMARY KEY (iDoctorID))
ENGINE = INNODB;

-- --------------------------------------------------------

--
-- Table structure for table `healthcare_doctor`
--

DROP TABLE IF EXISTS healthcare_doctor;
CREATE TABLE healthcare_doctor(
 healthcareEmployeeID int(11) NOT NULL,
 managerEmpID int(11) NOT NULL,
 centerID int(11) NOT NULL,
 CONSTRAINT healthcare_doctor_pk PRIMARY KEY (healthcareEmployeeID))
ENGINE = INNODB;

-- --------------------------------------------------------

--
-- Table structure for table `test_assigned`
--

DROP TABLE IF EXISTS test_assigned;
CREATE TABLE test_assigned(
 assignedTestID int(11) NOT NULL AUTO_INCREMENT,
 nurseID int(11) NOT NULL,
 testID int(11) NOT NULL,
 appointmentID int(11),
 doctorID int(11) NOT NULL,
 customerID int(11) NOT NULL,
 expectedDate date ,
 takenDate date NOT NULL,
 testResultDes varchar(100),
 testRating varchar(100),
CONSTRAINT test_assigned_pk PRIMARY KEY (assignedTestID))
ENGINE = INNODB;

-- --------------------------------------------------------

--
-- Table structure for table `healthcare_center`
--

DROP TABLE IF EXISTS healthcare_center;
CREATE TABLE healthcare_center(
 centerID int(11) NOT NULL AUTO_INCREMENT,
 healthCareCenterName varchar(50) NOT NULL,
 partnershipStartDate date,
CONSTRAINT healthcare_center_pk PRIMARY KEY (centerID))
ENGINE = INNODB;

-- --------------------------------------------------------

--
-- Table structure for table `diagnostic_test`
--

DROP TABLE IF EXISTS diagnostic_test;
CREATE TABLE diagnostic_test(
 testID int(11) NOT NULL AUTO_INCREMENT,
 testName varchar(100) NOT NULL,
 testDesc varchar(100) NOT NULL,
 approximateTime timestamp ,
 testPrice int(11) NOT NULL,
 testType varchar(100) NOT NULL,
CONSTRAINT diagnostic_test_pk PRIMARY KEY (testID))
ENGINE = INNODB;

-- --------------------------------------------------------

--
-- Table structure for table `nurse`
--

DROP TABLE IF EXISTS nurse;
CREATE TABLE nurse(
 nurseID int(11) NOT NULL AUTO_INCREMENT,
 nurseName varchar(100) NOT NULL,
 nurseSpecialization varchar(100),
 workStatus varchar(100) NOT NULL,
 salary int(11) NOT NULL,
 centerID int(11) NOT NULL,
CONSTRAINT nurse_pk PRIMARY KEY (nurseID))
ENGINE = INNODB;

-- --------------------------------------------------------

--
-- Table structure for table `emergency_contact`
--
DROP TABLE IF EXISTS emergency_contact;
CREATE TABLE emergency_contact(
customerID int(11) NOT NULL,
eFirstName varchar(100) NOT NULL,
eLastName varchar(100) NOT NULL,
eDateofBirth date,
ephoneNo varchar(10) NOT NULL,
eAddress varchar(100),
CONSTRAINT emergency_contact_pk PRIMARY KEY (customerID,eFirstName,eLastName)
)ENGINE = INNODB;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS customer;
CREATE TABLE customer(
customerID INT(11) NOT NULL AUTO_INCREMENT,
customerFirstName VARCHAR(100) NOT NULL,
customerLastName VARCHAR(100) NOT NULL ,
healthInsuranceID Varchar(100),
gender VARCHAR(11),
birthday DATE,
bmiWeight FLOAT NOT NULL,
bmiHeight FLOAT NOT NULL,
CONSTRAINT customer_pk PRIMARY KEY (customerID)
)ENGINE = INNODB;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--
DROP TABLE IF EXISTS orders_t;
CREATE TABLE orders_t( 
orderID	INT(11) NOT NULL AUTO_INCREMENT,
customerID INT(11) NOT NULL ,
deliveryCity VARCHAR (100) NOT NULL ,
deliveryArea VARCHAR (100) NOT NULL ,
deliveryState VARCHAR (11) NOT NULL ,
deliveryZIP	INT(5) ,
deliveryStreet VARCHAR (100),
orderDate DATETIME NOT NULL ,	
deliveryPhoneNo	varchar(10) NOT NULL ,
deliveryPrice	FLOAT NOT NULL,
CONSTRAINT orders_pk PRIMARY KEY (orderID) 
)ENGINE = INNODB;



-- --------------------------------------------------------

--
-- Table structure for table `order_item_details`
--
DROP TABLE IF EXISTS order_item_details;
CREATE TABLE order_item_details(
orderID	INT(11) NOT NULL,
offeringID INT(11) NOT NULL ,
supplierBranchID INT(11) NOT NULL,
quantity INT(11) NOT NULL ,
scheduledDeliveryDate DATE,
actualDeliveryDate	DATE NOT NULL,
CONSTRAINT order_item_details_pk PRIMARY KEY (orderID,offeringID,supplierBranchID)
)ENGINE = INNODB;

-- --------------------------------------------------------

--
-- Table structure for table `supplier_brand`
--

DROP TABLE IF EXISTS supplier_brand;
CREATE TABLE supplier_brand(
supplierID INT(11) not null auto_increment,
brandName VARCHAR (100) not null,
brandDes VARCHAR (100) not null ,
supplierType VARCHAR (100) not null,
CONSTRAINT supplier_brand_pk PRIMARY KEY(supplierID)
)ENGINE = INNODB;


-- --------------------------------------------------------

--
-- Table structure for table `offering`
--

DROP TABLE IF EXISTS offering;
CREATE TABLE offering(
offeringID INT(11) AUTO_INCREMENT NOT NULL,
offeringName VARCHAR(100) NOT NULL ,
createdDate	DATE,	
price DECIMAL(11) NOT NULL,
descriptions VARCHAR(100) NOT NULL,
offeringType VARCHAR(100) NOT NULL,
CONSTRAINT offering_pk PRIMARY KEY (offeringID)
) ENGINE = INNODB;

-- --------------------------------------------------------

--
-- Table structure for table `supplier_branch`
--

DROP TABLE IF EXISTS supplier_branch;
CREATE TABLE supplier_branch(
supplierBranchID INT(11) NOT NULL AUTO_INCREMENT,
supplierID	INT(11) NOT NULL,
branchName	VARCHAR(100) NOT NULL ,
branchLocation	VARCHAR(100) NOT NULL,
branchActivationDate DATE NOT NULL,
branchClosingDate DATE,
isOnline BOOLEAN NOT NULL,
CONSTRAINT supplier_branch_pk PRIMARY KEY (supplierBranchID)
) ENGINE = INNODB;

-- --------------------------------------------------------

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS item;
CREATE TABLE item(
tOfferingID INT(11) NOT NULL,
quantity	INT(11) NOT NULL,
itemType	VARCHAR(100) NOT NULL ,
unitOfMeasure	VARCHAR(100) NOT NULL,
CONSTRAINT item_pk PRIMARY KEY (tOfferingID)
) ENGINE = INNODB;

-- --------------------------------------------------------

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS service;
CREATE TABLE service(
sOfferingID INT(11) NOT NULL ,
timeTaken	timestamp ,
givenTime	timestamp ,
serviceRating	VARCHAR(100),
scheduleType VARCHAR(100) ,
duration DECIMAL(11) NOT NULL,
CONSTRAINT service_pk PRIMARY KEY (sOfferingID)
) ENGINE = INNODB;


-- Step 4 ----------------------------------------------------------------------------
-- TABLE MODIFICATIONS 
-- 
DESC orders_t;
ALTER TABLE orders_t MODIFY deliveryState VARCHAR (2) NOT NULL;
ALTER TABLE orders_t MODIFY deliveryZIP INT (5) NOT NULL;
ALTER TABLE orders_t RENAME orders;
ALTER TABLE orders RENAME COLUMN deliveryPrice TO orderPrice;
DESC orders;


-- Step 3 ----------------------------------------------------------------------------
-- Foreign Keys for tables
--

ALTER TABLE appointment
  ADD CONSTRAINT appointment_fk FOREIGN KEY (doctorID) REFERENCES healthcare_provider (doctorID) ON UPDATE CASCADE ON DELETE CASCADE,
  ADD CONSTRAINT appointment_fk1 FOREIGN KEY (customerID) REFERENCES customer (customerID) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE doctor_specialization
  ADD CONSTRAINT doctor_specialization_fk FOREIGN KEY (doctorID) REFERENCES healthcare_provider (doctorID) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE schedule_t
  ADD CONSTRAINT schedule_fk FOREIGN KEY (scheduleID) REFERENCES usage_schedule (scheduleID) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE usage_schedule
  ADD CONSTRAINT usage_schedule_fk1 FOREIGN KEY (offeringID) REFERENCES offering(offeringID) ON UPDATE CASCADE ON DELETE CASCADE,
  ADD CONSTRAINT usage_schedule_fk2 FOREIGN KEY (appointmentID) REFERENCES appointment(appointmentID) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE independent_doctor
  ADD CONSTRAINT independent_doctor_fk FOREIGN KEY (iDoctorID) REFERENCES healthcare_provider (doctorID) ON UPDATE CASCADE ON DELETE CASCADE;
  
ALTER TABLE healthcare_doctor
  ADD CONSTRAINT healthcare_doctor_fk FOREIGN KEY (healthcareEmployeeID) REFERENCES healthcare_provider (doctorID) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE test_assigned
  ADD CONSTRAINT test_assigned_fk1 FOREIGN KEY (nurseID) REFERENCES nurse (nurseID) ON UPDATE CASCADE ON DELETE CASCADE,
  ADD CONSTRAINT test_assigned_fk2 FOREIGN KEY (testID) REFERENCES diagnostic_test (testID) ON UPDATE CASCADE ON DELETE CASCADE,
  ADD CONSTRAINT test_assigned_fk3 FOREIGN KEY (appointmentID) REFERENCES appointment (appointmentID) ON UPDATE CASCADE ON DELETE CASCADE,
  ADD CONSTRAINT test_assigned_fk4 FOREIGN KEY (doctorID) REFERENCES healthcare_provider (doctorID) ON UPDATE CASCADE ON DELETE CASCADE,
  ADD CONSTRAINT test_assigned_fk5 FOREIGN KEY (customerID) REFERENCES customer (customerID) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE nurse
  ADD CONSTRAINT nurse_fk FOREIGN KEY (centerID) REFERENCES healthcare_center (centerID) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE emergency_contact
  ADD CONSTRAINT emergency_contact_fk FOREIGN KEY (customerID) REFERENCES customer (customerID) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE orders
  ADD CONSTRAINT orders_fk FOREIGN KEY (customerID) REFERENCES customer (customerID) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE order_item_details
  ADD CONSTRAINT order_item_details_fk1 FOREIGN KEY (orderID) REFERENCES orders(orderID) ON UPDATE CASCADE ON DELETE CASCADE,
  ADD CONSTRAINT order_item_details_fk2 FOREIGN KEY (offeringID) REFERENCES offering(offeringID) ON UPDATE CASCADE ON DELETE CASCADE,
  ADD CONSTRAINT order_item_details_fk3 FOREIGN KEY (supplierbranchID) REFERENCES supplier_branch(supplierBranchID) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE item
  ADD CONSTRAINT item_fk FOREIGN KEY (tOfferingID) REFERENCES offering(offeringID) ON UPDATE CASCADE ON DELETE CASCADE;
  
ALTER TABLE service
  ADD CONSTRAINT service_fk FOREIGN KEY (sOfferingID) REFERENCES offering(offeringID) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE supplier_branch
  ADD CONSTRAINT supplier_branch_fk FOREIGN KEY (supplierID) REFERENCES supplier_brand(supplierID) ON UPDATE CASCADE ON DELETE CASCADE;


