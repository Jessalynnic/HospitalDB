CREATE DATABASE HospitalDB;
GO
USE HospitalDB;
GO

DROP TABLE IF EXISTS User_Roles;
DROP TABLE IF EXISTS Roles;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Insurance;
DROP TABLE IF EXISTS Prescriptions;
DROP TABLE IF EXISTS Medications;
DROP TABLE IF EXISTS Medication_Classes;
DROP TABLE IF EXISTS Appointments;
DROP TABLE IF EXISTS Doctors;
DROP TABLE IF EXISTS Patients;
GO

-- Patients Table
CREATE TABLE Patients (
	Patient_ID INT PRIMARY KEY IDENTITY(1,1),
	First_name VARCHAR(50) NOT NULL, 
	Last_name VARCHAR(100) NOT NULL,
	DOB DATE NOT NULL,
	Gender Char(1) CHECK (Gender IN ('M', 'F', 'O')),
	Phone_number VARCHAR(20),
	Email_address VARCHAR(100),
	Guardian_ID INT NULL,
	CHECK (
		Phone_number IS NOT NULL OR Email_address IS NOT NULL
	)
);
GO

-- Doctors Table
CREATE TABLE Doctors (
	Doctor_ID INT PRIMARY KEY IDENTITY(1,1),
	First_name VARCHAR(50) NOT NULL, 
	Last_name VARCHAR(100) NOT NULL,
	DOB DATE NOT NULL,
	Gender Char(1) CHECK (Gender IN ('M', 'F', 'O')),
	Specialty VARCHAR(100),
	Phone_number VARCHAR(20) NOT NULL,
	Email_address VARCHAR(100) NOT NULL
);
GO

-- Appointments Table
CREATE TABLE Appointments (
	Appointment_ID INT PRIMARY KEY IDENTITY(1,1),
	Patient_ID INT NOT NULL,
	Doctor_ID INT NOT NULL,
	Appointment_date DATETIME NOT NULL,
	Visit_reason VARCHAR(255),
	Using_insurance BIT DEFAULT 1, -- 1 = Yes, 0 = No
	CONSTRAINT appointment_patient_fk FOREIGN KEY (Patient_ID) REFERENCES Patients(Patient_ID),
	CONSTRAINT appointment_doctor_fk FOREIGN KEY (Doctor_ID) REFERENCES Doctors(Doctor_ID),
);
GO

-- Allergies Table
CREATE TABLE Allergies (
	Allergy_ID INT PRIMARY KEY IDENTITY(1,1),
	Patient_ID INT NOT NULL,
	Allergen VARCHAR(100) NOT NULL,
	Reaction VARCHAR(255),
	Severity VARCHAR(50),
	CONSTRAINT Patient_Allergies_FK FOREIGN KEY (Patient_ID) REFERENCES Patients(Patient_ID)
);

-- Medication Classes Table
CREATE TABLE Medication_Classes (
	Class_ID INT PRIMARY KEY IDENTITY(1,1),
	Class_name VARCHAR(100) UNIQUE NOT NULL,
	Description VARCHAR(255)
);
GO

-- Medications Table
CREATE TABLE Medications (
	Medication_ID INT PRIMARY KEY IDENTITY(1,1),
	Name VARCHAR(100),
	Dosage VARCHAR(50),
	Instructions VARCHAR(255),
	Class_ID INT,
	CONSTRAINT Medication_Class_FK FOREIGN KEY (Class_ID) REFERENCES Medication_Classes(Class_ID)
);
GO

-- Prescriptions Table
CREATE TABLE Prescriptions (
	Prescription_ID INT PRIMARY KEY IDENTITY(1,1),
	Patient_ID INT NOT NULL,
	Doctor_ID INT NOT NULL,
	Medication_ID INT NOT NULL,
	Date_prescribed DATE NOT NULL,
	CONSTRAINT Patient_Pres_FK FOREIGN KEY (Patient_ID) REFERENCES Patients(Patient_ID),
	CONSTRAINT Doctor_Pres_FK FOREIGN KEY (Doctor_ID) REFERENCES Doctors(Doctor_ID),
	CONSTRAINT Pres_Med_FK FOREIGN KEY (Medication_ID) REFERENCES Medications(Medication_ID)
);
GO

-- Insurance Table
CREATE TABLE Insurance (
	Insurance_ID INT PRIMARY KEY IDENTITY(1,1),
	Patient_ID INT,
	Provider VARCHAR(100) NOT NULL,
	Policy_number VARCHAR(50),
	Effective_date DATE,
	Expiration_date DATE,
	CONSTRAINT Patients_Insurance_FK FOREIGN KEY (Patient_ID) REFERENCES Patients(Patient_ID)
);
GO

-- Users Table
CREATE TABLE Users (
	User_ID INT PRIMARY KEY IDENTITY(1,1),
	Username VARCHAR(50) UNIQUE NOT NULL,
	Password_hash VARCHAR(255),
	First_name VARCHAR(50) NOT NULL,
	Last_name VARCHAR(100) NOT NULL,
	Email_address VARCHAR(100) NOT NULL
);
GO

-- Roles Table
CREATE TABLE Roles (
	Role_ID INT PRIMARY KEY IDENTITY(1,1),
	Role_name VARCHAR(50) UNIQUE NOT NULL
);
GO

-- User_Roles Table
CREATE TABLE User_Roles (
	User_ID INT NOT NULL,
	Role_ID INT NOT NULL,
	CONSTRAINT User_Roles_PK PRIMARY KEY (User_ID, Role_ID),
	CONSTRAINT User_Roles_Users_FK FOREIGN KEY (User_ID) REFERENCES Users(User_ID),
	CONSTRAINT User_Roles_Roles_FK FOREIGN KEY (Role_ID) REFERENCES Roles(Role_ID)
);
GO