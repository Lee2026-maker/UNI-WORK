-- Create database roles

CREATE ROLE 'Administrator';
CREATE ROLE 'DOCTOR';
Create ROLE 'Receptionist'; 
Create ROLE 'Patient';

-- ADMINISTRATOR FULL ACCESS
GRANT ALL PRIVILEGES
ON Crownfield_Eye_Hospital.*
TO 'Administrator';

-- Doctor- Access to clinical information

GRANT SELECT, INSERT, UPDATE
ON Crownfield_Eye_Hospital.Patient
TO 'Doctor';

GRANT SELECT, INSERT, UPDATE
ON Crownfield_Eye_Hospital.Appointment
TO 'Doctor';

GRANT SELECT, INSERT, UPDATE
ON Crownfield_Eye_Hospital.Diagnosis
TO 'Doctor'; 

-- Receptionist manage patients and appointments

GRANT SELECT, INSERT, UPDATE
ON Crownfield_Eye_Hospital.Patient
TO 'Receptionist';

GRANT SELECT, INSERT, UPDATE
ON Crownfield_Eye_Hospital.Appointment
TO 'Receptionist';

-- Patient Access Limited

CREATE VIEW PatientInformation AS
SELECT Patient_ID, First_Name, Last_Name
FROM Patient;

GRANT SELECT
ON Crownfield_Eye_Hospital.PatientInformation
TO 'Patient';


-- Encrypt information

CREATE TABLE SecureMedicalRecords (
    Record_ID INT PRIMARY KEY,
    Patient_ID INT,
    Medical_Information VARBINARY(500)
);

INSERT INTO SecureMedicalRecords
VALUES (
    2,
    1,
    AES_ENCRYPT(
        'Patient diagnosis: Eye condition',
        'HospitalKey6739'
    )
);

SELECT* FROM SecureMedicalRecords; 

-- Decrypt the information

SELECT
    Record_ID,
    Patient_ID,
    CAST(
        AES_DECRYPT(
            Medical_Information,
            'HospitalKey6739'
        ) AS CHAR
    ) AS Medical_Information
FROM SecureMedicalRecords;


