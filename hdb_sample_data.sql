
-- Insert Patients
INSERT INTO Patients (First_name, Last_name, DOB, Gender, Phone_number, Email_address, Guardian_ID)
VALUES ('John', 'Doe', '1990-05-10', 'M', '555-123-4567', 'johndoe@gmail.com', NULL),
	   	('Jane', 'Smith', '1992-04-12', 'F', '555-123-9876', NULL, NULL),
	   	('AJ', 'Reed', '2019-02-10', 'M', '555-123-9876', NULL, 2)
		('Emily', 'Johnson', '1985-08-23', 'F', '555-321-4567', 'emilyj@example.com', NULL),
	    ('Michael', 'Brown', '1978-12-01', 'M', '555-654-7890', 'mbrown@example.com', NULL),
	    ('Olivia', 'Davis', '2005-07-14', 'F', '555-987-1234', NULL, 4),
	    ('Liam', 'Miller', '2010-03-22', 'M', '555-876-5432', NULL, 4),
	    ('Sophia', 'Wilson', '1995-09-30', 'F', '555-345-6789', 'sophiaw@gmail.com', NULL),
	    ('Ethan', 'Moore', '1988-11-18', 'M', '555-456-7890', 'ethanm@example.com', NULL),
	    ('Ava', 'Taylor', '2008-05-05', 'F', NULL, 'avataylor@example.com', 5),
	    ('Noah', 'Anderson', '2012-02-28', 'M', NULL, 'noaha@example.com', 6),
	    ('Isabella', 'Thomas', '2003-10-17', 'F', '555-234-5678', NULL, NULL),
	    ('James', 'Jackson', '1999-01-25', 'M', '555-678-1234', 'jjackson@example.com', NULL),
	    ('Mia', 'White', '2001-06-12', 'F', '555-567-8901', 'miaw@example.com', NULL),
	    ('Alexander', 'Harris', '1982-09-02', 'M', '555-432-1098', 'aharris@example.com', NULL),
	    ('Charlotte', 'Martin', '1998-03-15', 'F', '555-321-7654', 'cmartin@example.com', NULL),
	    ('Benjamin', 'Garcia', '2004-11-20', 'M', NULL, 'bgarcia@example.com', 14),
	    ('Amelia', 'Martinez', '2007-12-01', 'F', NULL, 'amartinez@example.com', 14),
	    ('William', 'Robinson', '1991-04-05', 'M', '555-876-4321', 'wrobinson@example.com', NULL),
	    ('Harper', 'Clark', '2009-08-08', 'F', NULL, 'hclark@example.com', 19),
	    ('Daniel', 'Rodriguez', '1987-05-17', 'M', '555-654-3210', 'drodriguez@example.com', NULL),
	    ('Evelyn', 'Lewis', '2006-10-10', 'F', NULL, 'elewis@example.com', 21),
	    ('Matthew', 'Lee', '1993-02-02', 'M', '555-987-6543', 'mlee@example.com', NULL),
	    ('Abigail', 'Walker', '2002-07-07', 'F', '555-765-4321', NULL, NULL),
	    ('Joseph', 'Hall', '1985-11-11', 'M', '555-876-0987', 'jhall@example.com', NULL),
	    ('Emily', 'Allen', '2000-01-22', 'F', '555-432-5678', NULL, NULL),
	    ('David', 'Young', '1996-09-09', 'M', '555-234-6789', 'dyoung@example.com', NULL),
	    ('Scarlett', 'Hernandez', '2005-05-05', 'F', NULL, 'shernandez@example.com', 28),
	    ('Samuel', 'King', '2011-12-12', 'M', NULL, 'sking@example.com', 28);
GO

-- Insert Doctors
INSERT INTO Doctors (First_name, Last_name, DOB, Gender, Specialty, Phone_number, Email_address)
VALUES ('Emily', 'Tran', '1985-03-15', 'F', 'Cardiology', '212-555-1010', 'etran@hospital.org'),
	   	('Marcus', 'King', '1978-11-02', 'M', 'Pediatrics', '212-555-1030', 'mking@hospital.org'),
	   	('Aisha', 'Malik', '1990-07-21', 'F', 'Neurology', '212-555-1030', 'amalik@hospital.org'),
	   	('Jordan', 'Lee', '1982-01-08', 'O', 'Emergency Medicine', '212-555-1040', 'jlee@hospital.org'),
	   	('Steven', 'Patel', '1975-06-30', 'M', 'Orthopedics', '212-555-1050', 'spatel@hospital.org')
		('Rachel', 'Kim', '1987-09-12', 'F', 'Dermatology', '212-555-1060', 'rkim@hospital.org'),
	    ('David', 'Nguyen', '1980-12-05', 'M', 'General Surgery', '212-555-1070', 'dnguyen@hospital.org'),
	    ('Laura', 'Cruz', '1992-04-18', 'F', 'Endocrinology', '212-555-1080', 'lcruz@hospital.org'),
	    ('Kevin', 'Lopez', '1976-08-22', 'M', 'Gastroenterology', '212-555-1090', 'klopez@hospital.org'),
	    ('Sofia', 'Ramirez', '1989-11-11', 'F', 'Ophthalmology', '212-555-1100', 'sramirez@hospital.org'),
	    ('Anthony', 'Harris', '1983-02-14', 'M', 'Psychiatry', '212-555-1110', 'aharris@hospital.org'),
	    ('Natalie', 'Singh', '1991-06-30', 'F', 'Rheumatology', '212-555-1120', 'nsingh@hospital.org'),
	    ('Brian', 'Scott', '1979-03-09', 'M', 'Urology', '212-555-1130', 'bscott@hospital.org'),
	    ('Isabella', 'Morgan', '1985-10-25', 'F', 'Obstetrics & Gynecology', '212-555-1140', 'imorgan@hospital.org');
GO

-- Insert Appointments
INSERT INTO Appointments (Patient_ID, Doctor_ID, Appointment_date, Visit_reason, Using_insurance)
VALUES (1, 1, '2025-09-20 09:00', 'Routine heart checkup', 1),
	   (1, 3, '2025-09-21 11:30', 'Migraine consultation', 1),
	   (2, 4, '2025-09-22 14:00', 'Follow-up visit', 0),
	   (4, 1, '2025-09-24 09:00', 'Cardiology checkup', 1),
	   (6, 5, '2025-09-25 13:30', 'Dermatology visit', 0),
	   (7, 2, '2025-09-28 10:00', 'Routine checkup', 0),
	   (8, 1, '2025-09-29 09:30', 'Cardiology consultation', 1),
	   (10, 3, '2025-10-01 11:15', 'Neurology visit', 0),
	   (6, 2, '2025-10-02 10:45', 'Pediatrics consultation', 1),
	   (16, 1, '2025-10-04 13:00', 'Cardiology follow-up', 0);
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
VALUES (1, 1, 3, '2025-09-20'),
		(1, 3, 2, '2025-09-21'),
		(2, 4, 5, '2025-09-22'),
		(4, 1, 3, '2025-09-24'),
		(6, 5, 1, '2025-09-25'),
		(7, 2, 2, '2025-09-28'),
		(8, 1, 3, '2025-09-29'),
		(10, 3, 2, '2025-10-01'),
		(6, 2, 1, '2025-10-02'),
		(16, 1, 3, '2025-10-04');
GO

-- Insert Insurance
INSERT INTO Insurance (Patient_ID, Provider, Policy_number, Effective_date, Expiration_date)
VALUES (1, 'Aetna', 'AET-123456789', '2024-01-01', '2024-12-31'),
		(2, 'UnitedHealthcare', 'UHC-555112233', '2024-06-01', '2025-05-31'),
		(4, 'BlueCross', 'BC-987654321', '2025-03-01', '2026-02-28'),
	    (5, 'Cigna', 'CIG-112233445', '2024-03-01', '2025-02-28'),
	    (8, 'Aetna', 'AET-998877665', '2025-05-01', '2026-04-30'),
	    (10, 'UnitedHealthcare', 'UHC-667788990', '2025-07-01', '2026-06-30'),
	    (12, 'BlueCross', 'BC-554433221', '2024-01-01', '2024-12-31'),
	    (14, 'Cigna', 'CIG-334455667', '2025-02-01', '2026-01-31'),
	    (16, 'Aetna', 'AET-223344556', '2025-03-01', '2026-02-28'),
	    (19, 'UnitedHealthcare', 'UHC-778899001', '2025-04-01', '2026-03-31'),
	    (21, 'BlueCross', 'BC-445566778', '2025-05-01', '2026-04-30'),
	    (28, 'Cigna', 'CIG-889900112', '2024-06-01', '2025-05-31');
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

