
USE HospitalDB;
GO

-- Drop existing views and procedures for safe re-creation
IF OBJECT_ID('Reception_View', 'V') IS NOT NULL DROP VIEW Reception_View;
IF OBJECT_ID('Doctor_View', 'V') IS NOT NULL DROP VIEW Doctor_View;
IF OBJECT_ID('Doctor_Prescription_View', 'V') IS NOT NULL DROP VIEW Doctor_Prescription_View;
IF OBJECT_ID('Nurse_View', 'V') IS NOT NULL DROP VIEW Nurse_View;
IF OBJECT_ID('Book_Appointment', 'P') IS NOT NULL DROP PROCEDURE Book_Appointment;
IF OBJECT_ID('Get_Active_Insurance', 'P') IS NOT NULL DROP PROCEDURE Get_Active_Insurance;
IF OBJECT_ID('Get_Patient_Prescriptions', 'P') IS NOT NULL DROP PROCEDURE Get_Patient_Prescriptions;
IF OBJECT_ID('Get_User_View_Access', 'P') IS NOT NULL DROP PROCEDURE Get_User_View_Access;
IF OBJECT_ID('Prevent_Uninsured_Appointment', 'TR') IS NOT NULL DROP TRIGGER Prevent_Uninsured_Appointment;
GO

-- Receptions View
CREATE VIEW Reception_View AS
SELECT 
	p.Patient_ID,
	p.First_name,
	p.Last_name ,
	p.Phone_number,
	p.Email_Address,
	a.Appointment_date,
	a.Visit_reason,
	a.Using_insurance,
	COALESCE(i.Provider, gi.Provider) AS Provider,
	COALESCE(i.Policy_number, gi.Policy_number) AS Policy_number,
	COALESCE(i.Effective_date, gi.Effective_date) AS Effective_date,
	COALESCE(i.Expiration_date, gi.Expiration_date) AS Expiration_date,
	CASE
		WHEN GETDATE() BETWEEN 
			COALESCE(i.Effective_date, gi.Effective_date) AND COALESCE(i.Expiration_date, gi.Expiration_date) THEN 'Active'
		ELSE 'Expired'
	END AS Insurance_Status
FROM Patients p
Join Appointments a ON p.Patient_ID = a.Patient_ID
LEFT JOIN Insurance i ON p.Patient_ID = i.Patient_ID
LEFT JOIN Patients g ON p.Guardian_ID = g.Patient_ID
LEFT JOIN Insurance gi ON g.Patient_ID = gi.Patient_ID;
GO


--Procedure for booking appointments
CREATE PROCEDURE Book_Appointment
	@Patient_ID INT,
	@Doctor_ID INT,
	@Appointment_Date DATETIME,
	@Visit_Reason VARCHAR(255),
	@Using_Insurance BIT = 1
AS
BEGIN
	INSERT INTO Appointments (Patient_ID, Doctor_ID, Appointment_date, Visit_reason, Using_insurance)
	VALUES (@Patient_ID, @Doctor_ID, @Appointment_Date, @Visit_Reason, @Using_Insurance)	
END;
GO


-- Trigger that prevents patients with expired insurance from booking appointments if they plan on using insurance as a payment method.
-- Allows self-pay patients (Using_insurance = 0) to book freely.
CREATE TRIGGER Prevent_Uninsured_Appointment
ON Appointments
INSTEAD OF INSERT
AS
BEGIN
	IF EXISTS (
		SELECT 1
		FROM inserted i 
		LEFT JOIN Patients p ON i.Patient_ID = p.Patient_ID
		LEFT JOIN Insurance pi ON p.Patient_ID = pi.Patient_ID
			AND GETDATE() BETWEEN pi.Effective_date AND pi.Expiration_date
		LEFT JOIN Insurance gi ON p.Guardian_ID = gi.Patient_ID
			AND GETDATE() BETWEEN gi.Effective_date AND gi.Expiration_date
		WHERE i.Using_insurance = 1
			AND pi.Insurance_ID IS NULL
			AND gi.Insurance_ID IS NULL
	)
	BEGIN
		RAISERROR('Cannot book an appointment with insurance: no active insurance for patient or guardian.', 16, 1);
		ROLLBACK;
	END
	ELSE
	BEGIN
		INSERT INTO Appointments (Patient_ID, Doctor_ID, Appointment_date, Visit_reason, Using_insurance)
        SELECT Patient_ID, Doctor_ID, Appointment_date, Visit_reason, Using_insurance
        FROM inserted;
	END
END;
GO


-- Procedure for getting a patients most active insurance
CREATE PROCEDURE Get_Active_Insurance
    @Patient_ID INT
AS
BEGIN
    SELECT TOP 1
        COALESCE(i.Patient_ID, gi.Patient_ID) AS Insured_Under,
        COALESCE(i.Provider, gi.Provider) AS Provider,
        COALESCE(i.Policy_number, gi.Policy_number) AS Policy_number,
        COALESCE(i.Effective_date, gi.Effective_date) AS Effective_date,
        COALESCE(i.Expiration_date, gi.Expiration_date) AS Expiration_date,
        CASE 
            WHEN i.Insurance_ID IS NOT NULL THEN 'Patient'
            WHEN gi.Insurance_ID IS NOT NULL THEN 'Guardian'
            ELSE 'None'
        END AS Whose_Insurance
    FROM Patients p
    LEFT JOIN Insurance i ON p.Patient_ID = i.Patient_ID 
        AND GETDATE() BETWEEN i.Effective_date AND i.Expiration_date
    LEFT JOIN Patients g ON p.Guardian_ID = g.Patient_ID
    LEFT JOIN Insurance gi ON g.Patient_ID = gi.Patient_ID 
        AND GETDATE() BETWEEN gi.Effective_date AND gi.Expiration_date
    WHERE p.Patient_ID = @Patient_ID;
END;
GO


-- Doctors View
CREATE VIEW Doctor_View AS
SELECT
	a.Appointment_ID,
	p.First_name AS Patient_First,
	p.Last_name AS Patient_Last,
	a.Appointment_date,
	a.Visit_reason,
	d.First_name AS Doctor_First,
	d.Last_name AS Doctor_Last
FROM Appointments a
JOIN Patients p ON a.Patient_ID = p.Patient_ID
JOIN Doctors d ON a.Doctor_ID = d.Doctor_ID;
GO


-- Procedure for getting patient prescriptions
CREATE PROCEDURE Get_Patient_Prescriptions
	@Patient_ID INT
AS
BEGIN
	SELECT
		p.Patient_ID,
		p.First_name,
		p.Last_name,
		m.Name AS Medication,
		m.Dosage,
		m.Instructions,
		pr.Date_prescribed,
		d.First_name AS Prescribing_Doctor_First,
		d.Last_name AS Prescribing_Doctor_Last
	FROM Prescriptions pr
	JOIN Patients p ON pr.Patient_ID = p.Patient_ID
	JOIN Doctors d ON pr.Doctor_ID = d.Doctor_ID
	JOIN Medications m ON pr.Medication_ID = m.Medication_ID
	WHERE p.Patient_ID = @Patient_ID;
END;
GO


-- Prescription view that shows the prescriptions doctors have written
CREATE VIEW Doctor_Prescription_View AS
SELECT
	d.Doctor_ID,
	d.First_name AS Doctor_First,
	d.Last_name AS Doctor_Last,
	p.Patient_ID,
	p.First_name AS Patient_First,
	p.Last_name AS Patient_Last,
	pr.Date_prescribed,
	m.Name AS Medication,
	m.Dosage,
	m.Instructions,
	a.Allergen,
    a.Reaction,
    a.Severity
FROM Prescriptions pr
JOIN Patients p ON pr.Patient_ID = p.Patient_ID
JOIN Doctors d ON pr.Doctor_ID = d.Doctor_ID
JOIN Medications m ON pr.Medication_ID = m.Medication_ID
LEFT JOIN Allergies a ON a.Patient_ID = p.Patient_ID;
GO

-- Nurses View
CREATE VIEW Nurse_View AS 
SELECT
	p.Patient_ID,
	p.First_name,
	p.Last_name,
	p.DOB,
	p.Gender,
	a.Appointment_Date,
	d.First_name AS Doctor_First,
	d.Last_name AS Doctor_Last,
	m.Name AS Medication,
	m.Dosage,
	pr.Date_prescribed,
	al.Allergen,
	al.Reaction,
	al.Severity
FROM Patients p
LEFT JOIN Appointments a ON p.Patient_ID = a.Patient_ID
LEFT JOIN Doctors d ON a.Doctor_ID = d.Doctor_ID
LEFT JOIN Prescriptions pr ON p.Patient_ID = pr.Patient_ID
LEFT JOIN Medications m ON pr.Medication_ID = m.Medication_ID
LEFT JOIN Allergies al ON p.Patient_ID = al.Patient_ID;
GO


-- Procedure for seeing what views certain users have access to
CREATE PROCEDURE Get_User_View_Access
	@Username VARCHAR(50)
AS
BEGIN
	SELECT DISTINCT	
		v.Role_name,
		CASE
			WHEN v.Role_name = 'Doctor' THEN 'Doctor_View, Doctor_Prescription_View'
			WHEN v.Role_name = 'Nurse' THEN 'Nurse_View'
			WHEN v.Role_name = 'Receptionist' THEN 'Reception_View'
			WHEN v.Role_name = 'Admin' THEN 'All Views'
			ELSE 'No View Access'
		END AS Accessible_Views
	FROM Users u
	JOIN User_Roles ur ON u.User_ID = ur.User_ID
	JOIN Roles v ON ur.Role_ID = v.Role_ID
	WHERE u.Username = @Username;
END;
GO

-- ===========================================================
-- Test Section – Book_Appointment Procedure With Trigger
-- ===========================================================

EXEC Book_Appointment 2, 4, '2025-06-02 11:00', 'Follow-up', 1; -- Will pass since patient has active insurance and wants to use it
GO

EXEC Book_Appointment 1, 1, '2025-06-11 10:00', 'Routine checkup', 1; -- Will be blocked since patient wants to use insurance but has no active insurance
GO

-- ================================
-- Test Section – View Outputs
-- ================================

-- View: Doctor_View
SELECT * FROM Doctor_View;
GO

-- View: Doctor_Prescription_View
SELECT * FROM Doctor_Prescription_View;
GO

SELECT * FROM Doctor_Prescription_View
ORDER BY Date_prescribed DESC;
GO

-- View: Nurse_View
SELECT * FROM Nurse_View;
GO

-- View: Reception_View
SELECT * FROM Reception_View;
GO

-- ================================
-- Test Section – Stored Procedures
-- ================================

-- Test: Get_Active_Insurance for child (guardian ID set)
EXEC Get_Active_Insurance 3;
GO

-- Test: Get_Patient_Prescriptions
EXEC Get_Patient_Prescriptions 2;
GO

-- Test: Get_User_View_Access
EXEC Get_User_View_Access 'etran';
GO