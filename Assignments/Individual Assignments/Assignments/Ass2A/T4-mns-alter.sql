--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T4-mns-alter.sql

--Student ID: 30032067
--Student Name: Kabir Kashif
--Unit Code: FIT3171
--Applied Class No: 03

/* Comments for your marker:




*/

--4(a)

-- add column for counting total appointments
ALTER TABLE patient
ADD
    total_appointments NUMBER(4);

COMMIT;

-- Update the data
UPDATE patient p
SET total_appointments = (
    SELECT COUNT(appt_no)
    FROM appointment
    WHERE patient_no = p.patient_no
);

COMMIT;

-- Display Changes
SELECT 
    patient_no, total_appointments
FROM 
    patient;

DESC patient;

--4(b)

-- Create a new table to support a many to many relationship
DROP TABLE patient_emergency_contact CASCADE CONSTRAINTS;

CREATE TABLE patient_emergency_contact (
    patient_no          NUMBER(4) NOT NULL,
    ec_id               NUMBER(4) NOT NULL
);

COMMENT ON COLUMN patient_emergency_contact.patient_no IS
    'Patient number (unique for each patient)';

COMMENT ON COLUMN patient_emergency_contact.ec_id IS
    'Emergency contact identifier';

ALTER TABLE patient_emergency_contact 
    ADD CONSTRAINT patient_ec_pk PRIMARY KEY ( patient_no, ec_id );

ALTER TABLE patient_emergency_contact
    ADD CONSTRAINT patient_patient_emergency_contact FOREIGN KEY ( patient_no )
        REFERENCES patient ( patient_no );

ALTER TABLE patient_emergency_contact
    ADD CONSTRAINT ec_patient_emergency_contact FOREIGN KEY ( ec_id )
        REFERENCES emergency_contact ( ec_id );

COMMIT;

-- Copy over the previous data
INSERT INTO 
    patient_emergency_contact (patient_no, ec_id)
SELECT 
    patient_no, ec_id
FROM 
    patient;
    
COMMIT;

-- Drop previous column
ALTER TABLE 
    patient
DROP COLUMN 
    ec_id;

COMMIT;

-- Display Changes
SELECT 
    patient_no, ec_id
FROM
    patient_emergency_contact;

DESC patient;
DESC patient_emergency_contact;

--4(c)

-- Normalisation gives 2 new tables
-- Create Tables
DROP TABLE training CASCADE CONSTRAINTS;
CREATE TABLE training (
    nurse_trainer_no            NUMBER(3) NOT NULL,
    tr_start_datetime           DATE NOT NULL,
    tr_end_datetime             DATE NOT NULL,
    tr_description              VARCHAR(70) NOT NULL
);

COMMENT ON COLUMN training.nurse_trainer_no IS
    'training nurse identifier';

COMMENT ON COLUMN training.tr_start_datetime IS
    'start datetime of training';

COMMENT ON COLUMN training.tr_end_datetime IS
    'end datetime of training';
    
COMMENT ON COLUMN training.tr_description IS
    'description of training';
    
ALTER TABLE 
    training 
ADD CONSTRAINT 
    training_pk PRIMARY KEY ( nurse_trainer_no, tr_start_datetime );

ALTER TABLE
    training 
ADD CONSTRAINT 
    uq_tr_nk UNIQUE ( nurse_trainer_no, tr_start_datetime, tr_end_datetime );
    
DROP TABLE nurse_training_log CASCADE CONSTRAINTS;
CREATE TABLE nurse_training_log (
    nurse_no                    NUMBER(3) NOT NULL,
    nurse_trainer_no            NUMBER(3) NOT NULL,
    tr_start_datetime           DATE NOT NULL
);

COMMENT ON COLUMN nurse_training_log.nurse_no IS
    'identifier for the nurse undergoing training';

COMMENT ON COLUMN nurse_training_log.nurse_trainer_no IS
    'training nurse identifier';

COMMENT ON COLUMN nurse_training_log.nurse_trainer_no IS
    'start datetime of training';
    
ALTER TABLE 
    nurse_training_log 
ADD CONSTRAINT 
    nurse_training_log_pk PRIMARY KEY ( nurse_no, nurse_trainer_no, tr_start_datetime );
    
-- Add foreign Keys Here
-- training
ALTER TABLE training
    ADD CONSTRAINT nurse_training_fk FOREIGN KEY ( nurse_trainer_no )
        REFERENCES nurse ( nurse_no );

-- nurse_training_log
ALTER TABLE nurse_training_log
    ADD CONSTRAINT nurse_nurse_training_log_fk FOREIGN KEY ( nurse_no )
        REFERENCES nurse ( nurse_no );

ALTER TABLE nurse_training_log
    ADD CONSTRAINT nurse_nurse_training_log_fk_1 FOREIGN KEY ( nurse_trainer_no, tr_start_datetime )
        REFERENCES training ( nurse_trainer_no, tr_start_datetime );
        
COMMIT;

-- display changes
DESC training;
DESC nurse_training_log;