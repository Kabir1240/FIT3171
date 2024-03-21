--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T3-mns-dm.sql

--Student ID: 30032067
--Student Name: Kabir Kashif
--Unit Code: FIT3171
--Applied Class No: 03

/* Comments for your marker:




*/


--3(a)

DROP SEQUENCE ec_seq;
CREATE SEQUENCE ec_seq START WITH 0100 INCREMENT BY 5;

DROP SEQUENCE patient_seq;
CREATE SEQUENCE patient_seq START WITH 0100 INCREMENT BY 5;

DROP SEQUENCE appointment_seq;
CREATE SEQUENCE appointment_seq START WITH 0100 INCREMENT BY 5;

--3(b)

-- Insert Jonathon as EC
INSERT INTO emergency_contact VALUES (
    ec_seq.NEXTVAL,
    'Jonathon',
    'Robey',
    '0412523122'
);

COMMIT;

-- Insert Laura AND Lachlan as patients
INSERT INTO patient (patient_no, patient_fname, patient_street, patient_city, 
patient_state, patient_dob, patient_contactmobile, patient_contactemail, ec_id) 
VALUES (
    patient_seq.NEXTVAL,
    'Laura',
    'Fake Street',
    'Melbourne',
    'VIC',
    to_date('03-Feb-2008','dd-Mon-yyyy'),
    '0123123123',
    'laura@gmail.com',
    (SELECT ec_id from emergency_contact where ec_phone = '0412523122')
);

INSERT INTO patient (patient_no, patient_fname, patient_street, patient_city, 
patient_state, patient_dob, patient_contactmobile, patient_contactemail, ec_id) 
VALUES (
    patient_seq.NEXTVAL,
    'Lachlan',
    'Fake Street',
    'Melbourne',
    'VIC',
    to_date('03-Feb-2008','dd-Mon-yyyy'),
    '0125125125',
    'lachlan@gmail.com',
    (SELECT ec_id FROM emergency_contact WHERE ec_phone = '0412523122')
);

COMMIT;

-- Create Appointments
INSERT INTO appointment (appt_no, appt_datetime, appt_roomno, appt_length, 
patient_no, provider_code, nurse_no) VALUES (
    appointment_seq.NEXTVAL,
    
    to_date('04-SEP-2023 15:30','dd-Mon-yyyy hh24:mi'),
    (SELECT provider_roomno FROM provider WHERE 
    upper(provider_title) = upper('Dr') 
    AND upper(provider_fname) = upper('Bruce') 
    AND upper(provider_lname) = upper('Striplin')),
    
    'S',
    
    (SELECT patient_no FROM 
    patient p JOIN emergency_contact e ON p.ec_id = e.ec_id WHERE
    upper(patient_fname) = upper('Laura') AND
    ec_phone = '0412523122'),
    
    (SELECT provider_code FROM provider WHERE 
    upper(provider_title) = upper('Dr') 
    AND upper(provider_fname) = upper('Bruce') 
    AND upper(provider_lname) = upper('Striplin')),
    
    6
);

INSERT INTO appointment (appt_no, appt_datetime, appt_roomno, appt_length, 
patient_no, provider_code, nurse_no) VALUES (
    appointment_seq.NEXTVAL,
    
    to_date('04-SEP-2023 16:00','dd-Mon-yyyy hh24:mi'),
    (SELECT provider_roomno FROM provider WHERE 
    upper(provider_title) = upper('Dr') 
    AND upper(provider_fname) = upper('Bruce') 
    AND upper(provider_lname) = upper('Striplin')),
    
    'S',
    
    (SELECT patient_no FROM 
    patient p JOIN emergency_contact e ON p.ec_id = e.ec_id WHERE
    upper(patient_fname) = upper('Lachlan') AND
    ec_phone = '0412523122'),
    
    (SELECT provider_code FROM provider WHERE 
    upper(provider_title) = upper('Dr') 
    AND upper(provider_fname) = upper('Bruce') 
    AND upper(provider_lname) = upper('Striplin')),
    
    6
);

COMMIT;

--3(c)
INSERT INTO appointment  VALUES (
    appointment_seq.NEXTVAL,
    
    (SELECT appt_datetime FROM appointment a JOIN patient p ON 
    a.patient_no = p.patient_no WHERE upper(patient_fname) = upper('Lachlan') AND 
    ec_id = (SELECT ec_id FROM emergency_contact WHERE ec_phone = '0412523122')) + 10,
    
    (SELECT provider_roomno FROM provider WHERE
    upper(provider_title) = upper('Dr') 
    AND upper(provider_fname) = upper('Bruce') 
    AND upper(provider_lname) = upper('Striplin')),
    
    'L',
    
    (SELECT patient_no FROM 
    patient p JOIN emergency_contact e ON p.ec_id = e.ec_id WHERE
    upper(patient_fname) = upper('Lachlan') AND
    ec_phone = '0412523122'),
    
    (SELECT provider_code FROM provider WHERE 
    upper(provider_title) = upper('Dr') 
    AND upper(provider_fname) = upper('Bruce') 
    AND upper(provider_lname) = upper('Striplin')),
    
    14,
    
    (SELECT appt_no FROM appointment a JOIN patient p ON 
    a.patient_no = p.patient_no WHERE upper(patient_fname) = upper('Lachlan') AND 
    ec_id = (SELECT ec_id FROM emergency_contact WHERE ec_phone = '0412523122'))
);

COMMIT;

--3(d)

UPDATE appointment
SET
    appt_datetime = (SELECT a.appt_datetime FROM appointment a JOIN patient p ON 
    a.patient_no = p.patient_no WHERE upper(patient_fname) = upper('Lachlan') AND 
    ec_id = (SELECT ec_id FROM emergency_contact WHERE ec_phone = '0412523122')
    AND appt_datetime = to_date('14-SEP-2023 16:00','dd-Mon-yyyy hh24:mi')) + 4
WHERE
    appt_no = (SELECT a.appt_no FROM appointment a JOIN patient p ON 
    a.patient_no = p.patient_no WHERE upper(patient_fname) = upper('Lachlan') AND 
    ec_id = (SELECT ec_id FROM emergency_contact WHERE ec_phone = '0412523122')
    AND appt_datetime = to_date('14-SEP-2023 16:00','dd-Mon-yyyy hh24:mi'));

COMMIT;

--3(e)
    
DELETE FROM appointment
WHERE
    provider_code = (SELECT provider_code FROM provider 
    WHERE upper(provider_title) = upper('Dr')
    AND upper(provider_fname) = upper('Bruce') 
    AND upper(provider_lname) = upper('Striplin'))
    
    AND appt_datetime > to_date('15-Sep-2023', 'dd-Mon-yyyy')
    AND appt_datetime < to_date('23-Sep-2023', 'dd-Mon-yyyy');

COMMIT;
