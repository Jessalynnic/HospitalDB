
-- Insert Patients
INSERT INTO Patients (First_name, Last_name, DOB, Gender, Phone_number, Email_address, Guardian_ID)
VALUES ('John', 'Doe', '1990-05-10', 'M', '555-123-4567', 'johndoe@gmail.com', NULL),
	   ('Jane', 'Smith', '1992-04-12', 'F', '555-123-9876', NULL, NULL),
	   ('AJ', 'Reed', '2019-02-10', 'M', '555-123-9876', NULL, 2);
;
GO

-- Insert Doctors
INSERT INTO Doctors (First_name, Last_name, DOB, Gender, Specialty, Phone_number, Email_address)
VALUES ('Emily', 'Tran', '1985-03-15', 'F', 'Cardiology', '212-555-1010', 'etran@hospital.org'),
	   ('Marcus', 'King', '1978-11-02', 'M', 'Pediatrics', '212-555-1030', 'mking@hospital.org'),
	   ('Aisha', 'Malik', '1990-07-21', 'F', 'Neurology', '212-555-1030', 'amalik@hospital.org'),
	   ('Jordan', 'Lee', '1982-01-08', 'O', 'Emergency Medicine', '212-555-1040', 'jlee@hospital.org'),
	   ('Steven', 'Patel', '1975-06-30', 'M', 'Orthopedics', '212-555-1050', 'spatel@hospital.org');
GO

-- Insert Appointments
INSERT INTO Appointments (Patient_ID, Doctor_ID, Appointment_date, Visit_reason)
VALUES (1, 1, '2025-05-10 09:00:00', 'Routine heart checkup'),
	   (1, 3, '2025-05-12 11:30:00', 'Migraine consultation'),
	   (2, 4, '2025-05-15 14:00:00', 'Emergency room visit — dizziness'),
	   (3, 2, '2025-05-20 10:45:00', 'Pediatric follow-up');
GO

-- Insert Patient Allergies
INSERT INTO Allergies (Patient_ID, Allergen, Reaction, Severity)
VALUES
(1, 'Latex', 'Rash', 'Mild'),
(2, 'Peanuts', 'Swelling', 'Moderate'),
(3, 'Penicillin', 'Hives and shortness of breath', 'Severe');
GO

-- Insert Medication Classes
INSERT INTO Medication_Classes (Class_name, Description)
VALUES ('Antibiotic', 'Used to treat bacterial infections'),
		('Analgesic', 'Pain reliever'),
		('Antihypertensive', 'Used to manage high blood pressure'),
		('Antidepressant', 'Used for depression and mood disorders'),
		('Antipyretic', 'Used to reduce fever');
GO

-- Insert Medications
INSERT INTO Medications (Name, Dosage, Instructions, Class_ID)
VALUES ('Amoxicillin', '500mg', 'Take every 8 hours for 7 days', 1), 
		('Ibuprofen', '200mg', 'Take every 6 hours as needed for pain', 2), 
		('Lisinopril', '10mg', 'Take once daily for blood pressure', 3), 
		('Sertraline', '50mg', 'Take once daily in the morning', 4), 
		('Acetaminophen', '500mg', 'Take every 6 hours to reduce fever', 5); 
GO

-- Insert Prescriptions
INSERT INTO Prescriptions (Patient_ID, Doctor_ID, Medication_ID, Date_prescribed)
VALUES (1, 1, 1, '2025-05-10'), 
		(1, 3, 2, '2025-05-12'),
		(2, 2, 3, '2025-05-15'), 
		(2, 4, 5, '2025-05-16');
GO

-- Insert Insurance
INSERT INTO Insurance (Patient_ID, Provider, Policy_number, Effective_date, Expiration_date)
VALUES (1, 'Aetna', 'AET-123456789', '2024-01-01', '2024-12-31'),
		(2, 'UnitedHealthcare', 'UHC-555112233', '2024-06-01', '2025-05-31');
GO

-- Insert Users
INSERT INTO Users (Username, Password_hash, First_name, Last_name, Email_address)
VALUES ('admin01', 'HASHED_PASSWORD_ADMIN', 'Alice', 'Torres', 'admin@hospital.org'), --Admin
		('reception01', 'HASHED_PASSWORD_RECEPTION', 'Bob', 'Builder', 'bob.reception@hospital.org'), --Receptionist
		('etran', 'HASHED_PASSWORD_TRAN', 'Emily', 'Tran', 'etran@hospital.org'), --Doctor
		('mking', 'HASHED_PASSWORD_KING', 'Marcus', 'King', 'mking@hospital.org'), --Doctor
		('amalik', 'HASHED_PASSWORD_MALIK', 'Aisha', 'Malik', 'amalik@hospital.org'), --Doctor
		('jlee', 'HASHED_PASSWORD_LEE', 'Jordan', 'Lee', 'jlee@hospital.org'), --Doctor
		('spatel', 'HASHED_PASSWORD_PATEL', 'Steven', 'Patel', 'spatel@hospital.org'), --Doctor
		('nurse01', 'HASHED_PASSWORD_NURSE', 'Nina', 'Chambers', 'nurse.nina@hospital.org'); --Nurse
GO

-- Insert Roles
INSERT INTO Roles (Role_name)
VALUES ('Admin'),
		('Doctor'),
		('Receptionist'),
		('Nurse');
GO

-- Assign Roles to Users
INSERT INTO User_Roles (User_ID, Role_ID)
VALUES (1, 1), -- Admin
		(2, 3), -- Receptionist
		(3, 2), -- Doctor: Dr. Tran
		(4, 2), -- Doctor: Dr. King
		(5, 2), -- Doctor: Dr. Malik
		(6, 2), -- Doctor: Dr. Lee
		(7, 2), -- Doctor: Dr. Patel
		(8, 4); -- Nurse
GO

-- ===============
-- Test Section 
-- ===============

SELECT * FROM Patients;
SELECT * FROM Doctors;
SELECT * FROM Appointments;
SELECT * FROM Allergies;
SELECT * FROM Medication_Classes;
SELECT * FROM Medications;
SELECT * FROM Prescriptions;
SELECT * FROM Insurance;
SELECT * FROM Users;
SELECT * FROM Roles;
SELECT * FROM User_Roles;