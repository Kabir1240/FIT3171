DROP TABLE appointment CASCADE CONSTRAINTS;

DROP TABLE appt_serv CASCADE CONSTRAINTS;

DROP TABLE apptservice_item CASCADE CONSTRAINTS;

DROP TABLE item CASCADE CONSTRAINTS;

DROP TABLE provider CASCADE CONSTRAINTS;

DROP TABLE provider_service CASCADE CONSTRAINTS;

DROP TABLE service CASCADE CONSTRAINTS;

CREATE TABLE appointment (
    appt_no       NUMBER(7) NOT NULL,
    appt_datetime DATE NOT NULL,
    appt_length   CHAR(1) NOT NULL,
    provider_code CHAR(6) NOT NULL
);

ALTER TABLE appointment
    ADD CONSTRAINT appt_length_chk CHECK ( appt_length IN ( 'L', 'S', 'T' ) );

COMMENT ON COLUMN appointment.appt_no IS
    'Appointment identifier (surrogate PK)';

COMMENT ON COLUMN appointment.appt_datetime IS
    'Date and time of appointment';

COMMENT ON COLUMN appointment.appt_length IS
    'Length of appointment - Short, Standard or Long (S, T or L)';

COMMENT ON COLUMN appointment.provider_code IS
    'Provider identifier';

ALTER TABLE appointment ADD CONSTRAINT appointment_pk PRIMARY KEY ( appt_no );

ALTER TABLE appointment ADD CONSTRAINT patient_nk UNIQUE ( provider_code,
                                                           appt_datetime );

CREATE TABLE appt_serv (
    appt_no           NUMBER(7) NOT NULL,
    service_code      CHAR(4) NOT NULL,
    apptserv_fee      NUMBER(6, 2),
    apptserv_itemcost NUMBER(6, 2)
);

COMMENT ON COLUMN appt_serv.appt_no IS
    'Appointment identifier (surrogate PK)';

COMMENT ON COLUMN appt_serv.service_code IS
    'Identifier for services';

COMMENT ON COLUMN appt_serv.apptserv_fee IS
    'Actual fee charged for service';

COMMENT ON COLUMN appt_serv.apptserv_itemcost IS
    'Total cost of items needed for the service';

ALTER TABLE appt_serv ADD CONSTRAINT appoint_serv_pk PRIMARY KEY ( service_code,
                                                                   appt_no );

CREATE TABLE apptservice_item (
    as_id            NUMBER(7) NOT NULL,
    appt_no          NUMBER(7) NOT NULL,
    service_code     CHAR(4) NOT NULL,
    item_id          NUMBER(4) NOT NULL,
    as_item_quantity NUMBER(3) NOT NULL
);

COMMENT ON COLUMN apptservice_item.as_id IS
    'Appointment service item identifier (surrogate PK)';

COMMENT ON COLUMN apptservice_item.appt_no IS
    'Appointment identifier (surrogate PK)';

COMMENT ON COLUMN apptservice_item.service_code IS
    'Identifier for services';

COMMENT ON COLUMN apptservice_item.item_id IS
    'Item identifier';

COMMENT ON COLUMN apptservice_item.as_item_quantity IS
    'Number of item used for the appointment service';

ALTER TABLE apptservice_item ADD CONSTRAINT apptservice_item_pk PRIMARY KEY ( as_id )
;

ALTER TABLE apptservice_item
    ADD CONSTRAINT appserviceitem_nk UNIQUE ( appt_no,
                                              service_code,
                                              item_id );

CREATE TABLE item (
    item_id      NUMBER(4) NOT NULL,
    item_desc    VARCHAR2(50) NOT NULL,
    item_stdcost NUMBER(5, 2) NOT NULL,
    item_stock   NUMBER(4) NOT NULL
);

COMMENT ON COLUMN item.item_id IS
    'Item identifier';

COMMENT ON COLUMN item.item_desc IS
    'Item description';

COMMENT ON COLUMN item.item_stdcost IS
    'Item standard cost';

COMMENT ON COLUMN item.item_stock IS
    'Item quantity on hand (in stock)';

ALTER TABLE item ADD CONSTRAINT item_pk PRIMARY KEY ( item_id );

CREATE TABLE provider (
    provider_code  CHAR(6) NOT NULL,
    provider_title VARCHAR2(10),
    provider_fname VARCHAR2(30),
    provider_lname VARCHAR2(30)
);

COMMENT ON COLUMN provider.provider_code IS
    'Provider identifier';

COMMENT ON COLUMN provider.provider_title IS
    'Provider title';

COMMENT ON COLUMN provider.provider_fname IS
    'Provider first name';

COMMENT ON COLUMN provider.provider_lname IS
    'Provider last name';

ALTER TABLE provider ADD CONSTRAINT provider_pk PRIMARY KEY ( provider_code );

CREATE TABLE provider_service (
    provider_code CHAR(6) NOT NULL,
    service_code  CHAR(4) NOT NULL
);

COMMENT ON COLUMN provider_service.provider_code IS
    'Provider identifier';

COMMENT ON COLUMN provider_service.service_code IS
    'Identifier for services';

ALTER TABLE provider_service ADD CONSTRAINT provider_service_pk PRIMARY KEY ( provider_code
,
                                                                              service_code
                                                                              );

CREATE TABLE service (
    service_code   CHAR(4) NOT NULL,
    service_desc   VARCHAR2(50) NOT NULL,
    service_stdfee NUMBER(6, 2) NOT NULL
);

COMMENT ON COLUMN service.service_code IS
    'Identifier for services';

COMMENT ON COLUMN service.service_desc IS
    'Service description';

COMMENT ON COLUMN service.service_stdfee IS
    'Standard charge for service';

ALTER TABLE service ADD CONSTRAINT service_pk PRIMARY KEY ( service_code );

ALTER TABLE appt_serv
    ADD CONSTRAINT appoint_apptserv FOREIGN KEY ( appt_no )
        REFERENCES appointment ( appt_no );

ALTER TABLE apptservice_item
    ADD CONSTRAINT apptserv_asitem FOREIGN KEY ( service_code,
                                                 appt_no )
        REFERENCES appt_serv ( service_code,
                               appt_no );

ALTER TABLE apptservice_item
    ADD CONSTRAINT item_asitem FOREIGN KEY ( item_id )
        REFERENCES item ( item_id );

ALTER TABLE appointment
    ADD CONSTRAINT provider_appointment FOREIGN KEY ( provider_code )
        REFERENCES provider ( provider_code );

ALTER TABLE provider_service
    ADD CONSTRAINT provider_provsrv FOREIGN KEY ( provider_code )
        REFERENCES provider ( provider_code );

ALTER TABLE appt_serv
    ADD CONSTRAINT service_apptserv FOREIGN KEY ( service_code )
        REFERENCES service ( service_code );

ALTER TABLE provider_service
    ADD CONSTRAINT service_provsrv FOREIGN KEY ( service_code )
        REFERENCES service ( service_code );

-------======SampleData======---------
--===SERVICE===--
INSERT INTO service VALUES (
    'D001',
    'Oral examination',
    '65'
);

INSERT INTO service VALUES (
    'D002',
    'Extended Consultation - 30 mins or more',
    '75'
);

INSERT INTO service VALUES (
    'D003',
    'Diagnostic model',
    '60'
);

INSERT INTO service VALUES (
    'X001',
    'Intraoral radiograph - per x-ray',
    '45'
);

INSERT INTO service VALUES (
    'X002',
    'Panoramic radiograph - per x-ray',
    '85'
);

INSERT INTO service VALUES (
    'P001',
    'Removal of plaque and / or stain',
    '90'
);

INSERT INTO service VALUES (
    'P002',
    'Removal of calculus',
    '165'
);

INSERT INTO service VALUES (
    'P003',
    'Fissure sealing',
    '58'
);

INSERT INTO service VALUES (
    'PG01',
    'Treatment of acute periodontal infection',
    '170'
);

INSERT INTO service VALUES (
    'PG02',
    'Root planing and subgingival curettage:per tooth',
    '120'
);

INSERT INTO service VALUES (
    'EX01',
    'Removal of a tooth or part thereof',
    '175'
);

INSERT INTO service VALUES (
    'EX02',
    'Surgical removal of a tooth',
    '425'
);

INSERT INTO service VALUES (
    'EX03',
    'Dental bone grafts',
    '500'
);

INSERT INTO service VALUES (
    'RC01',
    'Preparation of root canal - one canal',
    '225'
);

INSERT INTO service VALUES (
    'RC02',
    'Preparation of root canal - each additional canal',
    '120'
);

INSERT INTO service VALUES (
    'RC03',
    'Root canal obturation - one canal',
    '265'
);

INSERT INTO service VALUES (
    'RC04',
    'Root canal obturation - each additional canal',
    '120'
);

INSERT INTO service VALUES (
    'DF01',
    'Anterior Filling (front teeth)',
    '175'
);

INSERT INTO service VALUES (
    'DF02',
    'Posterior Filling (back teeth)',
    '185'
);

INSERT INTO service VALUES (
    'DV01',
    'Veneer Cusp capping',
    '175'
);

INSERT INTO service VALUES (
    'DV02',
    'Veneer - composite',
    '185'
);

INSERT INTO service VALUES (
    'DV03',
    'Veneer - porcelain',
    '185'
);

INSERT INTO service VALUES (
    'DV04',
    'Post Veneer',
    '165'
);

INSERT INTO service VALUES (
    'DC01',
    'Preparation for crown',
    '175'
);

INSERT INTO service VALUES (
    'DC02',
    'Full crown - CEREC same day crown',
    '1500'
);

INSERT INTO service VALUES (
    'DC03',
    'Full crown',
    '1200'
);

INSERT INTO service VALUES (
    'DC04',
    'Post and core for crown',
    '250'
);

INSERT INTO service VALUES (
    'DC05',
    'Recementing crown or veneer',
    '150'
);

INSERT INTO service VALUES (
    'DT01',
    'Impressions of jaw',
    '300'
);

INSERT INTO service VALUES (
    'DT02',
    'Denture Occlusive registration',
    '200'
);

INSERT INTO service VALUES (
    'DT03',
    'Denture Wax trial',
    '250'
);

INSERT INTO service VALUES (
    'DT04',
    'Denture fitting',
    '800'
);

INSERT INTO service VALUES (
    'DT05',
    'Cleaning and polishing of existing denture',
    '80'
);

INSERT INTO service VALUES (
    'OT01',
    'Design treatment',
    '500'
);

INSERT INTO service VALUES (
    'OT02',
    'Brace placement',
    '3000'
);

INSERT INTO service VALUES (
    'OT03',
    'Wire insertion',
    '1000'
);

INSERT INTO service VALUES (
    'OT04',
    'Brace Adjustments',
    '100'
);

--===ITEM===--
INSERT INTO item VALUES (
    1,
    'Paper tips',
    1,
    1000
);

INSERT INTO item VALUES (
    2,
    'Sodium hypochlorite 5.25%',
    6,
    100
);

INSERT INTO item VALUES (
    3,
    'EDTA Cleansing Gel 17%',
    8,
    200
);

INSERT INTO item VALUES (
    4,
    'Irrigation Solution 2% Chlorhexidine',
    9,
    100
);

INSERT INTO item VALUES (
    5,
    'Sterile K NiTi files',
    7,
    150
);

INSERT INTO item VALUES (
    6,
    'Universal Clamp',
    15,
    150
);

INSERT INTO item VALUES (
    7,
    'Portalimas sponges 1 cm',
    0.5,
    500
);

INSERT INTO item VALUES (
    8,
    'Irrigation Needle and Syringe',
    2,
    150
);

INSERT INTO item VALUES (
    9,
    'Metal Bracket',
    1.5,
    1000
);

INSERT INTO item VALUES (
    10,
    'Molar mouth tube',
    2,
    1000
);

INSERT INTO item VALUES (
    11,
    'Archwire',
    2,
    1000
);

INSERT INTO item VALUES (
    12,
    'Curved lingual button',
    1,
    1000
);

INSERT INTO item VALUES (
    13,
    'Direct cementation tubes',
    1,
    1000
);

INSERT INTO item VALUES (
    14,
    'Silk surture',
    2,
    500
);

INSERT INTO item VALUES (
    15,
    'Absorbable surture',
    3,
    500
);

INSERT INTO item VALUES (
    16,
    'Universal composite',
    48,
    100
);

INSERT INTO item VALUES (
    17,
    'Universal restorative composite',
    46,
    50
);

INSERT INTO item VALUES (
    18,
    'Fluid composite',
    78,
    50
);

INSERT INTO item VALUES (
    19,
    'Herculite XRV: For Dental Fillings',
    42,
    100
);

INSERT INTO item VALUES (
    20,
    'Phospor imaging plate',
    75,
    100
);

INSERT INTO item VALUES (
    21,
    'Clinasept Film',
    5,
    100
);

INSERT INTO item VALUES (
    22,
    'Porcelain Etch',
    35,
    50
);

INSERT INTO item VALUES (
    23,
    'Silane',
    25,
    50
);

--===PROVIDER==--
INSERT INTO provider VALUES (
    'END001',
    'Dr',
    'Mark',
    'Stanton'
);

INSERT INTO provider VALUES (
    'GEN001',
    'Dr',
    'Bruce',
    'Striplin'
);

INSERT INTO provider VALUES (
    'GEN002',
    'Dr',
    'Amalia',
    'Morris'
);

INSERT INTO provider VALUES (
    'GEN003',
    'Dr',
    NULL,
    'Corner'
);

INSERT INTO provider VALUES (
    'ORS001',
    'Dr',
    'Jessica',
    'Jones'
);

INSERT INTO provider VALUES (
    'PED001',
    'Dr',
    'Kevin',
    'Barr'
);

INSERT INTO provider VALUES (
    'PED002',
    'Dr',
    NULL,
    'Lee'
);

INSERT INTO provider VALUES (
    'ORT001',
    'Dr',
    'Gerry',
    'Elliott'
);

INSERT INTO provider VALUES (
    'AST001',
    NULL,
    'Katie',
    NULL
);

INSERT INTO provider VALUES (
    'AST002',
    NULL,
    'James',
    'Remaley'
);

INSERT INTO provider VALUES (
    'PER001',
    'Dr',
    'April',
    'Manahan'
);

INSERT INTO provider VALUES (
    'PER002',
    'Dr',
    'Joseph',
    'Hazelton'
);

INSERT INTO provider VALUES (
    'PRO001',
    'Dr',
    'Jane',
    'Fransen'
);

--===PROVIDER_SERVICE===--
INSERT INTO provider_service VALUES (
    'AST001',
    'X001'
);

INSERT INTO provider_service VALUES (
    'AST001',
    'X002'
);

INSERT INTO provider_service VALUES (
    'AST001',
    'P001'
);

INSERT INTO provider_service VALUES (
    'AST001',
    'P002'
);

INSERT INTO provider_service VALUES (
    'AST001',
    'P003'
);

INSERT INTO provider_service VALUES (
    'AST002',
    'X001'
);

INSERT INTO provider_service VALUES (
    'AST002',
    'X002'
);

INSERT INTO provider_service VALUES (
    'AST002',
    'P001'
);

INSERT INTO provider_service VALUES (
    'AST002',
    'P002'
);

INSERT INTO provider_service VALUES (
    'AST002',
    'P003'
);

INSERT INTO provider_service VALUES (
    'END001',
    'D002'
);

INSERT INTO provider_service VALUES (
    'END001',
    'RC01'
);

INSERT INTO provider_service VALUES (
    'END001',
    'RC02'
);

INSERT INTO provider_service VALUES (
    'END001',
    'RC03'
);

INSERT INTO provider_service VALUES (
    'END001',
    'RC04'
);

INSERT INTO provider_service VALUES (
    'GEN001',
    'D001'
);

INSERT INTO provider_service VALUES (
    'GEN001',
    'D002'
);

INSERT INTO provider_service VALUES (
    'GEN001',
    'P001'
);

INSERT INTO provider_service VALUES (
    'GEN001',
    'P002'
);

INSERT INTO provider_service VALUES (
    'GEN001',
    'P003'
);

INSERT INTO provider_service VALUES (
    'GEN001',
    'EX01'
);

INSERT INTO provider_service VALUES (
    'GEN001',
    'DF01'
);

INSERT INTO provider_service VALUES (
    'GEN001',
    'DF02'
);

INSERT INTO provider_service VALUES (
    'GEN002',
    'D001'
);

INSERT INTO provider_service VALUES (
    'GEN002',
    'D002'
);

INSERT INTO provider_service VALUES (
    'GEN002',
    'D003'
);

INSERT INTO provider_service VALUES (
    'GEN002',
    'P001'
);

INSERT INTO provider_service VALUES (
    'GEN002',
    'P002'
);

INSERT INTO provider_service VALUES (
    'GEN002',
    'P003'
);

INSERT INTO provider_service VALUES (
    'GEN002',
    'EX01'
);

INSERT INTO provider_service VALUES (
    'GEN002',
    'DF01'
);

INSERT INTO provider_service VALUES (
    'GEN002',
    'DF02'
);

INSERT INTO provider_service VALUES (
    'GEN003',
    'D001'
);

INSERT INTO provider_service VALUES (
    'GEN003',
    'D002'
);

INSERT INTO provider_service VALUES (
    'GEN003',
    'P001'
);

INSERT INTO provider_service VALUES (
    'GEN003',
    'P002'
);

INSERT INTO provider_service VALUES (
    'GEN003',
    'P003'
);

INSERT INTO provider_service VALUES (
    'GEN003',
    'EX01'
);

INSERT INTO provider_service VALUES (
    'GEN003',
    'DF01'
);

INSERT INTO provider_service VALUES (
    'GEN003',
    'DF02'
);

INSERT INTO provider_service VALUES (
    'ORS001',
    'D002'
);

INSERT INTO provider_service VALUES (
    'ORS001',
    'EX01'
);

INSERT INTO provider_service VALUES (
    'ORS001',
    'EX02'
);

INSERT INTO provider_service VALUES (
    'ORS001',
    'EX03'
);

INSERT INTO provider_service VALUES (
    'ORT001',
    'D002'
);

INSERT INTO provider_service VALUES (
    'ORT001',
    'OT01'
);

INSERT INTO provider_service VALUES (
    'ORT001',
    'OT02'
);

INSERT INTO provider_service VALUES (
    'ORT001',
    'OT03'
);

INSERT INTO provider_service VALUES (
    'ORT001',
    'OT04'
);

INSERT INTO provider_service VALUES (
    'PED001',
    'D001'
);

INSERT INTO provider_service VALUES (
    'PED001',
    'D002'
);

INSERT INTO provider_service VALUES (
    'PED001',
    'P001'
);

INSERT INTO provider_service VALUES (
    'PED001',
    'P002'
);

INSERT INTO provider_service VALUES (
    'PED001',
    'P003'
);

INSERT INTO provider_service VALUES (
    'PED001',
    'EX01'
);

INSERT INTO provider_service VALUES (
    'PED002',
    'D001'
);

INSERT INTO provider_service VALUES (
    'PED002',
    'D002'
);

INSERT INTO provider_service VALUES (
    'PED002',
    'P001'
);

INSERT INTO provider_service VALUES (
    'PED002',
    'P002'
);

INSERT INTO provider_service VALUES (
    'PED002',
    'P003'
);

INSERT INTO provider_service VALUES (
    'PED002',
    'EX01'
);

INSERT INTO provider_service VALUES (
    'PER001',
    'D002'
);

INSERT INTO provider_service VALUES (
    'PER001',
    'PG01'
);

INSERT INTO provider_service VALUES (
    'PER001',
    'PG02'
);

INSERT INTO provider_service VALUES (
    'PER002',
    'D002'
);

INSERT INTO provider_service VALUES (
    'PER002',
    'PG01'
);

INSERT INTO provider_service VALUES (
    'PER002',
    'PG02'
);

INSERT INTO provider_service VALUES (
    'PRO001',
    'D002'
);

INSERT INTO provider_service VALUES (
    'PRO001',
    'DV01'
);

INSERT INTO provider_service VALUES (
    'PRO001',
    'DV02'
);

INSERT INTO provider_service VALUES (
    'PRO001',
    'DV03'
);

INSERT INTO provider_service VALUES (
    'PRO001',
    'DV04'
);

INSERT INTO provider_service VALUES (
    'PRO001',
    'DC01'
);

INSERT INTO provider_service VALUES (
    'PRO001',
    'DC02'
);

INSERT INTO provider_service VALUES (
    'PRO001',
    'DC03'
);

INSERT INTO provider_service VALUES (
    'PRO001',
    'DC04'
);

INSERT INTO provider_service VALUES (
    'PRO001',
    'DC05'
);

INSERT INTO provider_service VALUES (
    'PRO001',
    'DT01'
);

INSERT INTO provider_service VALUES (
    'PRO001',
    'DT02'
);

INSERT INTO provider_service VALUES (
    'PRO001',
    'DT03'
);

INSERT INTO provider_service VALUES (
    'PRO001',
    'DT04'
);

INSERT INTO provider_service VALUES (
    'PRO001',
    'DT05'
);

--===APPOINTMENT===--
INSERT INTO appointment VALUES (
    1,
    TO_DATE('13/OCT/2023 10:00', 'dd/MON/yyyy hh24:mi'),
    'L',
    'ORS001'
);

INSERT INTO appointment VALUES (
    2,
    TO_DATE('13/OCT/2023 10:00', 'dd/MON/yyyy hh24:mi'),
    'S',
    'GEN002'
);

INSERT INTO appointment VALUES (
    3,
    TO_DATE('13/OCT/2023 12:00', 'dd/MON/yyyy hh24:mi'),
    'L',
    'ORS001'
);

INSERT INTO appointment VALUES (
    4,
    TO_DATE('13/OCT/2023 15:00', 'dd/MON/yyyy hh24:mi'),
    'T',
    'GEN001'
);

INSERT INTO appointment VALUES (
    5,
    TO_DATE('13/OCT/2023 16:00', 'dd/MON/yyyy hh24:mi'),
    'T',
    'GEN001'
);

COMMIT;