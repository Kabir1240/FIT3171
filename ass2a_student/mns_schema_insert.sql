/*
  Databases 2023 S2 Assignment 2A
  --Monash New Smile File and Initial Data--
  --mns_schema_insert.sql
  
  Description: 
  This file creates the Monash New Smile Australia tables 
  and populates several of the tables (those shown in purple on the supplied model). 
  You should read this schema file carefully 
  and be sure you understand the various data requirements.

Author: FIT Database Teaching Team
License: Copyright Monash University, unless otherwise stated. All Rights Reserved.
COPYRIGHT WARNING
Warning
This material is protected by copyright. For use within Monash University only. NOT FOR RESALE.
Do not remove this notice. 
  
*/

DROP TABLE appointment CASCADE CONSTRAINTS;

DROP TABLE emergency_contact CASCADE CONSTRAINTS;

DROP TABLE nurse CASCADE CONSTRAINTS;

DROP TABLE patient CASCADE CONSTRAINTS;

DROP TABLE provider CASCADE CONSTRAINTS;

DROP TABLE specialisation CASCADE CONSTRAINTS;

CREATE TABLE nurse (
    nurse_no           NUMBER(3) NOT NULL,
    nurse_fname        VARCHAR2(30),
    nurse_lname        VARCHAR2(30),
    nurse_contactno    CHAR(10) NOT NULL,
    nurse_employstatus CHAR(1) NOT NULL
);

COMMENT ON COLUMN nurse.nurse_no IS
    'Nurse identifier (unique)';

COMMENT ON COLUMN nurse.nurse_fname IS
    'Nurse first name';

COMMENT ON COLUMN nurse.nurse_lname IS
    'Nurse last name';

COMMENT ON COLUMN nurse.nurse_contactno IS
    'Nurse contact number';

COMMENT ON COLUMN nurse.nurse_employstatus IS
    'Nurse employment status: Casual (C), Contract (T), Fulltime (F)';

ALTER TABLE nurse ADD CONSTRAINT nurse_pk PRIMARY KEY ( nurse_no );

ALTER TABLE nurse
    ADD CONSTRAINT nrsemploystatus_chk CHECK ( nurse_employstatus IN ( 'C', 'F', 'T' )
    );

CREATE TABLE provider (
    provider_code   CHAR(6) NOT NULL,
    provider_title  VARCHAR2(10),
    provider_fname  VARCHAR2(30),
    provider_lname  VARCHAR2(30),
    provider_roomno NUMBER(2) NOT NULL,
    spec_id         NUMBER(3)
);

COMMENT ON COLUMN provider.provider_code IS
    'Provider identifier';

COMMENT ON COLUMN provider.provider_title IS
    'Provider title';

COMMENT ON COLUMN provider.provider_fname IS
    'Provider first name';

COMMENT ON COLUMN provider.provider_lname IS
    'Provider last name';

COMMENT ON COLUMN provider.provider_roomno IS
    'Providers default room number';

COMMENT ON COLUMN provider.spec_id IS
    'Specialisation identifier';

ALTER TABLE provider ADD CONSTRAINT provider_pk PRIMARY KEY ( provider_code );

CREATE TABLE specialisation (
    spec_id   NUMBER(3) NOT NULL,
    spec_name VARCHAR2(50) NOT NULL
);

COMMENT ON COLUMN specialisation.spec_id IS
    'Specialisation identifier';

COMMENT ON COLUMN specialisation.spec_name IS
    'Specialisation name';

ALTER TABLE specialisation ADD CONSTRAINT specialisation_pk PRIMARY KEY ( spec_id );

ALTER TABLE provider
    ADD CONSTRAINT specialisation_provider_fk FOREIGN KEY ( spec_id )
        REFERENCES specialisation ( spec_id );
        
--Data Specialist

INSERT INTO specialisation VALUES (
    101,
    'Endodontics'
);

INSERT INTO specialisation VALUES (
    102,
    'Oral surgery'
);

INSERT INTO specialisation VALUES (
    103,
    'Orthodontics'
);

INSERT INTO specialisation VALUES (
    104,
    'Paediatric dentistry'
);

INSERT INTO specialisation VALUES (
    105,
    'Periodontics'
);

INSERT INTO specialisation VALUES (
    106,
    'Prosthodontics'
);

--Data Provider
INSERT INTO provider VALUES (
    'END001',
    'Dr',
    'Mark',
    'Stanton',
    1,
    101
);

INSERT INTO provider VALUES (
    'GEN001',
    'Dr',
    'Bruce',
    'Striplin',
    2,
    NULL
);

INSERT INTO provider VALUES (
    'GEN002',
    'Dr',
    'Amalia',
    'Morris',
    3,
    NULL
);

INSERT INTO provider VALUES (
    'GEN003',
    'Dr',
    NULL,
    'Corner',
    4,
    NULL
);

INSERT INTO provider VALUES (
    'ORS001',
    'Dr',
    'Jessica',
    'Jones',
    5,
    102
);

INSERT INTO provider VALUES (
    'PED001',
    'Dr',
    'Kevin',
    'Barr',
    6,
    104
);

INSERT INTO provider VALUES (
    'PED002',
    'Dr',
    NULL,
    'Lee',
    7,
    104
);

INSERT INTO provider VALUES (
    'ORT001',
    'Dr',
    'Gerry',
    'Elliott',
    8,
    103
);

INSERT INTO provider VALUES (
    'AST001',
    NULL,
    'Katie',
    NULL,
    9,
    NULL
);

INSERT INTO provider VALUES (
    'AST002',
    NULL,
    'James',
    'Remaley',
    10,
    NULL
);

INSERT INTO provider VALUES (
    'PER001',
    'Dr',
    'April',
    'Manahan',
    11,
    105
);

INSERT INTO provider VALUES (
    'PER002',
    'Dr',
    'Joseph',
    'Hazelton',
    12,
    105
);

INSERT INTO provider VALUES (
    'PRO001',
    'Dr',
    'Jane',
    'Fransen',
    13,
    106
);

--Data Nurse
INSERT INTO nurse VALUES (
    1,
    'Seth',
    'Raws',
    '0487660799',
    'F'
);

INSERT INTO nurse VALUES (
    2,
    'Spencer',
    'Cazaly',
    '0453790650',
    'C'
);

INSERT INTO nurse VALUES (
    3,
    'Anna',
    'Treloar',
    '0482003895',
    'C'
);

INSERT INTO nurse VALUES (
    4,
    'Ellie',
    'Pattison',
    '0453911718',
    'C'
);

INSERT INTO nurse VALUES (
    5,
    'Ben',
    'Leggatt',
    '0453420898',
    'F'
);

INSERT INTO nurse VALUES (
    6,
    'Chelsea',
    'Ford',
    '0445703528',
    'F'
);

INSERT INTO nurse VALUES (
    7,
    'James',
    NULL,
    '0453967998',
    'T'
);

INSERT INTO nurse VALUES (
    8,
    'Kaitlyn',
    'Rivers',
    '0440359423',
    'T'
);

INSERT INTO nurse VALUES (
    9,
    'Kerry',
    'Corner',
    '0447477384',
    'T'
);

INSERT INTO nurse VALUES (
    10,
    'Tayla',
    'Holloway',
    '0494966133',
    'C'
);

INSERT INTO nurse VALUES (
    11,
    'Harry',
    'Lee',
    '0431251610',
    'C'
);

INSERT INTO nurse VALUES (
    12,
    'Mia',
    'Blackall',
    '0490668828',
    'F'
);

INSERT INTO nurse VALUES (
    13,
    'Phoebe',
    'Irving',
    '0437180467',
    'T'
);

INSERT INTO nurse VALUES (
    14,
    'Katie',
    NULL,
    '0435657357',
    'C'
);

INSERT INTO nurse VALUES (
    15,
    'Mariam',
    'Trebelo',
    '0440000593',
    'T'
);

COMMIT;