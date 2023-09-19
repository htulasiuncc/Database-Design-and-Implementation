/*Create and use Database*/

CREATE DATABASE PharmaDB;

use PharmaDB;



/*Drop Tables*/

DROP TABLE IF EXISTS Details;
DROP TABLE IF EXISTS Patient;
DROP TABLE IF EXISTS Treatments;
DROP TABLE IF EXISTS Doctor;
DROP TABLE IF EXISTS Supplier;
DROP TABLE IF EXISTS Hospital;



/*Create Tables*/

DROP TABLE IF EXISTS Hospital;
CREATE TABLE Hospital (
	hospitalId int PRIMARY KEY UNIQUE NOT NULL AUTO_INCREMENT,
    hospitalName VARCHAR(50),
    address VARCHAR(200),
    phoneNumber varchar(12)
);

DROP TABLE IF EXISTS Supplier;
CREATE TABLE Supplier (
	supplierId int PRIMARY KEY UNIQUE NOT NULL AUTO_INCREMENT,
    supplierName VARCHAR(50),
    address VARCHAR(200),
    phoneNumber varchar(12)
);

DROP TABLE IF EXISTS Doctor;
CREATE TABLE Doctor (
	doctorId int PRIMARY KEY UNIQUE NOT NULL AUTO_INCREMENT,
    hospitalId int,
    FOREIGN KEY(hospitalId) REFERENCES Hospital(hospitalId),
    firstName VARCHAR(20),
    lastName VARCHAR(20)
);

DROP TABLE IF EXISTS Treatments;
CREATE TABLE Treatments (
	treatmentId int PRIMARY KEY UNIQUE NOT NULL AUTO_INCREMENT,
    treatmentName VARCHAR(50),
    purpose VARCHAR(500),
    sideEffects VARCHAR(500),
    supplierId int,
    FOREIGN KEY (supplierId) REFERENCES Supplier(supplierId)
);

DROP TABLE IF EXISTS Patient;
CREATE TABLE Patient (
	patientId int PRIMARY KEY UNIQUE NOT NULL AUTO_INCREMENT,
    doctorId int,
    treatmentId int,
	FOREIGN KEY(doctorId) REFERENCES Doctor(doctorId),
    FOREIGN KEY(treatmentId) REFERENCES Treatments(treatmentId),
    firstName varchar(20),
    lastName varchar(20),
    illness varchar(30)
);

DROP TABLE IF EXISTS Details;
CREATE TABLE Details (
	detailsNumber int PRIMARY KEY UNIQUE NOT NULL AUTO_INCREMENT,
    details VARCHAR(500),
    doctorId int,
    FOREIGN KEY (doctorId) REFERENCES Doctor(doctorId),
    patientId int,
    FOREIGN KEY (patientId) REFERENCES Patient(patientId),
    treatmentId int,
    FOREIGN KEY (treatmentId) REFERENCES Treatments(treatmentId)
);




/*Insert Values*/


INSERT INTO Hospital(hospitalID,hospitalName,address,phoneNumber) VALUES
(1,3,"the Sanctum Sanctorum","555-123-4567" ),
(2,2,"Princeton–Plainsboro Teaching Hospital","555-420-6900"),
(3,1,"Chatham Family Medicine","555-710-8901");
INSERT INTO Supplier(supplierId, supplierName, address, phoneNumber) VALUES
(1, "PharmaCo", "5381 SOmething Something dr. Kansas", "980-245-3842"),
(2, "Treats", "2345 SOmething Something dr. NotKansas", "9802453843"),
(3, "WholeFoods", "0284 Over Here dr. Wonderland", "9999999999");

INSERT INTO Doctor(doctorID,hospitalID,firstName,lastName) VALUES
(1,3,"Mike","Varshavski"),
(2,2,"Gregory","House"),
(3,1,"Stephen","Strange");

INSERT INTO Treatments(treatmentId, treatmentName, purpose, sideEffects, supplierId) VALUES
(1, "Tylenol", "Pain relief and fever reduction", "nausea, stomach pain, itching, headache", 1),
(2, "Extremis", "Elevates physical abilities and extremifies prominent parts of one's structure or personality depending on dosage", "Loss of self-control and damage to internal organs as well as physical alterations in some cases", 2),
(3, "Extinguish", "Extreme enhancement of both physical and cognitive abilities", "Pain and destruction of both the internal organs and the musculoskeletal structure", 3);

INSERT INTO Patient(patientID,doctorID,treatmentID,firstName,lastName,illness) VALUES
(1,3,2,"Kiritsugu","Emiya","SARS"),
(2,2,3,"George","Flanders","Cancer"),
(3,1,1,"Charlie","Smith","COVID19");

INSERT INTO Details(detailsNumber, details, doctorId, patientId, treatmentId) VALUES
(1, "5 grams per day", 1,1,1),
(2, "1 gram during strenuous activity", 2,2,2),
(3, "4 grams when it's time", 3,3,3);



/*Select Statements*/

select * from Patient;

SELECT treatmentName
FROM Treatments
INNER JOIN Patient ON Patient.treatmentId = Treatments.treatmentId
WHERE patient.patientId = 2;

select Patient.firstName as "Patient First Name", Patient.lastName as "Patient Last Name", doctor.firstName as "Doctor First Name", doctor.lastName as "Doctor Last Name"
from Patient
INNER JOIN Doctor
on Patient.doctorId = Doctor.doctorId
where patient.doctorId = 3;

select Treatments.treatmentName, Supplier.supplierName, Supplier.phoneNumber
from Supplier
INNER JOIN Treatments
on Treatments.supplierId = Supplier.supplierId
where Treatments.supplierId = 1;

select count(patient.patientId) as "Number of patients for Dr. House"
from patient
INNER JOIN Doctor
on Patient.doctorId = Doctor.doctorId
where patient.doctorId = 2;

/*Views of Select Statements*/

create view All_Patient_Info as
select *
from Patient;

create view George_Flanders_Medicines as
SELECT treatmentName
FROM Treatments
INNER JOIN Patient ON Patient.treatmentId = Treatments.treatmentId
WHERE patient.patientId = 2;

create view Dr_Strange_Patients as
select Patient.firstName as "Patient First Name", Patient.lastName as "Patient Last Name", doctor.firstName as "Doctor First Name", doctor.lastName as "Doctor Last Name"
from Patient
INNER JOIN Doctor
on Patient.doctorId = Doctor.doctorId
where patient.doctorID = 3;

create view Tylenol_supplier_info as
select Treatments.treatmentName, Supplier.supplierName, Supplier.phoneNumber
from Supplier
INNER JOIN Treatments
on Treatments.supplierId = Supplier.supplierId
where Treatments.supplierId = 1;

create view DrHouse_Patient_Count as
select count(patient.patientId) as "Number of patients for Dr. House"
from patient
INNER JOIN Doctor
on Patient.doctorId = Doctor.doctorId
where patient.doctorId = 2;

select *
from All_Patient_Info;

select *
from George_Flanders_Medicines;

select *
from Dr_Strange_Patients;

select *
from Tylenol_supplier_info;

select *
from DrHouse_Patient_Count;

/* Create Index statements */

CREATE INDEX index_patientTable_patientId ON Patient(patientId);
CREATE INDEX index_doctorTable_doctorId ON Doctor(doctorId);
CREATE INDEX index_hospitalTable_hospitalId ON Hospital(hospitalId);
CREATE INDEX index_supplierTable_supplierId ON Supplier(supplierId);
CREATE INDEX index_treatmentsTable_treatmentId ON Treatments(treatmentId);
CREATE INDEX index_detailsTable_detailsId ON Details(detailsNumber);