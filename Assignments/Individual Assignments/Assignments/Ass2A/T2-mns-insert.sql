--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T2-mns-insert.sql

--Student ID: 30032067
--Student Name: Kabir Kashif
--Unit Code: FIT3171
--Applied Class No: 03

/* Comments for your marker:




*/

--------------------------------------
--INSERT INTO emergency_contact
--------------------------------------
--DROP SEQUENCE ec_seq;
--CREATE SEQUENCE ec_seq START WITH 0001 INCREMENT BY 1;

INSERT INTO emergency_contact VALUES (
    1,
    'Mickey',
    'Mouse',
    '0123456789'
);

INSERT INTO emergency_contact (ec_id, ec_fname, ec_phone) VALUES (
    2,
    'Batman',
    '0010011111'
);

INSERT INTO emergency_contact (ec_id, ec_lname, ec_phone) VALUES (
    3,
    'Butler',
    '0987654231'
);

INSERT INTO emergency_contact (ec_id, ec_phone) VALUES (
    4,
    '0122334455'
);

INSERT INTO emergency_contact VALUES (
    5,
    'Cookie',
    'Monster',
    '0999911111'
);

-- 2 Extra
INSERT INTO emergency_contact VALUES (
    6,
    'Super',
    'Man',
    '0000012121'
);

INSERT INTO emergency_contact VALUES (
    7,
    'New',
    'Guy',
    '0231231231'
);

COMMIT;

--------------------------------------
--INSERT INTO patient
--------------------------------------
--DROP SEQUENCE patient_seq;
--CREATE SEQUENCE patient_seq START WITH 0001 INCREMENT BY 1;

-- 5 under 18
-- Share ec 1
INSERT INTO patient VALUES (
    1,
    'Tina',
    'Dale',
    'Dunara Street',
    'Sydney',
    'VIC',
    to_date('03-Feb-2007','dd-Mon-yyyy'),
    '0111122222',
    'hello@gmail.com',
    1
);

INSERT INTO patient VALUES (
    2,
    'Mathew',
    'Dale',
    'Dunara Street',
    'Sydney',
    'VIC',
    to_date('05-Mar-2008','dd-Mon-yyyy'),
    '0111122222',
    'mat@gmail.com',
    1
);

-- Share ec 2
INSERT INTO patient VALUES (
    3,
    'Shanta',
    'Burke',
    'Reeves Street',
    'Melbourne',
    'NT',
    to_date('05-Sep-2008','dd-Mon-yyyy'),
    '0111133333',
    'nope@gmail.com',
    2
);

INSERT INTO patient (patient_no, patient_lname, patient_street, patient_city, 
patient_state, patient_dob, patient_contactmobile, patient_contactemail, ec_id) 
VALUES (
    4,
    'Burke',
    'Real Street',
    'Canberra',
    'QLD',
    to_date('08-Jun-2007','dd-Mon-yyyy'),
    '0222233333',
    'kbye@gmail.com',
    2
);

INSERT INTO patient (patient_no, patient_fname, patient_street, patient_city, 
patient_state, patient_dob, patient_contactmobile,patient_contactemail, ec_id) 
VALUES (
    5,
    'Salma',
    'Fake Street',
    'Sydney',
    'NSW',
    to_date('12-Jun-2009','dd-Mon-yyyy'),
    '0222255555',
    'salma@gmail.com',
    3
);

-- 5 above 18
INSERT INTO patient (patient_no, patient_street, patient_city, patient_state, 
patient_dob, patient_contactmobile, patient_contactemail, ec_id) VALUES (
    6,
    'Palmerston Street',
    'Sydney',
    'ACT',
    to_date('5-Jul-2000','dd-Mon-yyyy'),
    '0333333333',
    'contactme@gmail.com',
    3
);

INSERT INTO patient VALUES (
    7,
    'Rebecca',
    'Kingston',
    'Drayton Street',
    'Melbourne',
    'TAS',
    to_date('10-Sep-2001','dd-Mon-yyyy'),
    '0234123412',
    'rebking@gmail.com',
    4
);

INSERT INTO patient VALUES (
    8,
    'Jaslyn',
    'Chambers',
    'Buckley Street',
    'Clayton',
    'SA',
    to_date('22-Apr-2001','dd-Mon-yyyy'),
    '0212121212',
    'jaslyn@gmail.com',
    5
);

INSERT INTO patient VALUES (
    9,
    'Andrey',
    'Horn',
    'Wise Street',
    'Perth',
    'WA',
    to_date('02-May-1999','dd-Mon-yyyy'),
    '0090909090',
    'andreyhorn@gmail.com',
    6
);

INSERT INTO patient VALUES (
    10,
    'Milo',
    'Drink',
    'Marley Street',
    'Hobart',
    'NSW',
    to_date('15-Dec-2003','dd-Mon-yyyy'),
    '0897897890',
    'Milo@gmail.com',
    7
);

COMMIT;
--------------------------------------
--INSERT INTO appointment
--------------------------------------

-- Pick three dates. 5 May 2023, 22 June 2023, 15 August 2023
-- 5 appointments on 5 May 2023
INSERT INTO appointment (appt_no, appt_datetime, appt_roomno, appt_length, 
patient_no, provider_code, nurse_no) VALUES (
    1,
    to_date('05-MAY-2023 08:00','dd-Mon-yyyy hh24:mi'),
    1,
    'S',
    1,
    'END001',
    3
);

INSERT INTO appointment (appt_no, appt_datetime, appt_roomno, appt_length, 
patient_no, provider_code, nurse_no) VALUES (
    2,
    to_date('05-MAY-2023 08:30','dd-Mon-yyyy hh24:mi'),
    12,
    'L',
    2,
    'PER002',
    5
);

INSERT INTO appointment (appt_no, appt_datetime, appt_roomno, appt_length, 
patient_no, provider_code, nurse_no) VALUES (
    3,
    to_date('05-MAY-2023 08:30','dd-Mon-yyyy hh24:mi'),
    5,
    'T',
    3,
    'ORS001',
    9
);

INSERT INTO appointment (appt_no, appt_datetime, appt_roomno, appt_length, 
patient_no, provider_code, nurse_no) VALUES (
    4,
    to_date('05-MAY-2023 10:00','dd-Mon-yyyy hh24:mi'),
    7,
    'T',
    4,
    'END001',
    9
);

INSERT INTO appointment (appt_no, appt_datetime, appt_roomno, appt_length, 
patient_no, provider_code, nurse_no) VALUES (
    5,
    to_date('05-MAY-2023 15:00','dd-Mon-yyyy hh24:mi'),
    10,
    'L',
    5,
    'AST002',
    1
);

-- 5 appointments on 22 June 2023
INSERT INTO appointment VALUES (
    6,
    to_date('22-JUN-2023 09:00','dd-Mon-yyyy hh24:mi'),
    9,
    'L',
    5,
    'AST002',
    1,
    5
);

INSERT INTO appointment (appt_no, appt_datetime, appt_roomno, appt_length, 
patient_no, provider_code, nurse_no) VALUES (
    7,
    to_date('22-JUN-2023 11:00','dd-Mon-yyyy hh24:mi'),
    9,
    'L',
    6,
    'AST001',
    12
);

INSERT INTO appointment VALUES (
    8,
    to_date('22-JUN-2023 11:00','dd-Mon-yyyy hh24:mi'),
    10,
    'T',
    3,
    'AST002',
    1,
    3
);

INSERT INTO appointment (appt_no, appt_datetime, appt_roomno, appt_length, 
patient_no, provider_code, nurse_no) VALUES (
    9,
    to_date('22-JUN-2023 13:00','dd-Mon-yyyy hh24:mi'),
    13,
    'S',
    7,
    'PRO001',
    15
);

INSERT INTO appointment (appt_no, appt_datetime, appt_roomno, appt_length, 
patient_no, provider_code, nurse_no) VALUES (
    10,
    to_date('22-JUN-2023 14:00','dd-Mon-yyyy hh24:mi'),
    6,
    'T',
    8,
    'PED001',
    5
);

-- 5 appointments on 15 August 2023

INSERT INTO appointment (appt_no, appt_datetime, appt_roomno, appt_length, 
patient_no, provider_code, nurse_no) VALUES (
    11,
    to_date('15-AUG-2023 08:00','dd-Mon-yyyy hh24:mi'),
    6,
    'S',
    9,
    'PER001',
    1
);

INSERT INTO appointment (appt_no, appt_datetime, appt_roomno, appt_length, 
patient_no, provider_code, nurse_no) VALUES (
    12,
    to_date('15-AUG-2023 08:00','dd-Mon-yyyy hh24:mi'),
    10,
    'T',
    10,
    'AST002',
    2
);

INSERT INTO appointment VALUES (
    13,
    to_date('15-AUG-2023 10:00','dd-Mon-yyyy hh24:mi'),
    10,
    'L',
    5,
    'AST002',
    2,
    6
);

INSERT INTO appointment VALUES (
    14,
    to_date('15-AUG-2023 11:00','dd-Mon-yyyy hh24:mi'),
    1,
    'S',
    1,
    'END001',
    3,
    1
);

INSERT INTO appointment VALUES (
    15,
    to_date('15-AUG-2023 13:00','dd-Mon-yyyy hh24:mi'),
    13,
    'L',
    7,
    'PRO001',
    8,
    9
);

COMMIT;