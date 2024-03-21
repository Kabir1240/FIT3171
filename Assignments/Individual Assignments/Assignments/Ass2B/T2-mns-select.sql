--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T2-mns-select.sql

--Student ID: 30032067
--Student Name: Kabir Kashif
--Unit Code: FIT3171
--Applied Class No: 03

/* Comments for your marker:




*/

/*2(a)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT
    item_id,
    item_desc,
    item_stdcost,
    item_stock
FROM
    mns.item
WHERE
    item_stock >= 50
    AND
    lower(item_desc) LIKE lower('%composite%')
ORDER BY
    item_stock DESC, item_id;
    
/*2(b)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT
    p.provider_code,
    CASE
        WHEN p.provider_title IS NOT NULL AND p.provider_fname IS NOT NULL AND p.provider_lname IS NOT NULL
        THEN p.provider_title || '. ' || p.provider_fname || ' ' || p.provider_lname
        WHEN p.provider_title IS NOT NULL AND p.provider_fname IS NOT NULL
        THEN p.provider_title || '. ' || p.provider_fname
        WHEN p.provider_title IS NOT NULL AND p.provider_lname IS NOT NULL
        THEN p.provider_title || '. ' || p.provider_lname
        WHEN p.provider_fname IS NOT NULL AND p.provider_lname IS NOT NULL
        THEN p.provider_fname || ' ' || p.provider_lname
        WHEN p.provider_title IS NOT NULL
        THEN p.provider_title
        WHEN p.provider_fname IS NOT NULL
        THEN p.provider_fname
        WHEN p.provider_lname IS NOT NULL
        THEN p.provider_lname
        ELSE ''
    END AS provider_name
FROM
    mns.provider p
JOIN mns.specialisation s ON p.spec_id = s.spec_id
WHERE
    upper(s.spec_name) = upper('PAEDIATRIC DENTISTRY')
ORDER BY
    p.provider_lname, p.provider_fname, p.provider_code;

/*2(c)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT
    service_code,
    service_desc,
    LPAD('$' || to_char(service_stdfee, '9990.99'), 12, ' ') AS service_stdfee
FROM
    mns.service
WHERE
    service_stdfee > (SELECT AVG(service_stdfee) FROM mns.service)
ORDER BY
    service_stdfee DESC, service_code;

/*2(d)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT
    a.appt_no,
    a.appt_datetime,
    p.patient_no,
    p.patient_fname || ' ' || p.patient_lname AS patient_fullname,
    LPAD('$' || TO_CHAR(s.appt_totalcost, '9990.99'), 12, ' ') AS appt_totalcost
FROM
    mns.patient p
    JOIN mns.appointment a ON p.patient_no = a.patient_no
    JOIN (
        SELECT
            appt_no,
            apptserv_fee + apptserv_itemcost AS appt_totalcost
        FROM
            mns.appt_serv
        WHERE
            apptserv_fee + apptserv_itemcost = (
                SELECT MAX(apptserv_fee + apptserv_itemcost)
                FROM mns.appt_serv
            )
    ) s ON a.appt_no = s.appt_no
ORDER BY
    s.appt_totalcost DESC, a.appt_no;

/*2(e)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT
    s.service_code,
    s.service_desc,
    s.service_stdfee,
    CASE
        WHEN AVG(a.apptserv_fee) IS NOT NULL
        THEN LPAD('$' || TO_CHAR(AVG(a.apptserv_fee) 
            - s.service_stdfee, '9990.99'), 12, ' ')
        ELSE ''
    END AS service_fee_differential
FROM
    mns.service s
    LEFT JOIN mns.appt_serv a ON s.service_code = a.service_code
GROUP BY
    s.service_code, s.service_desc, s.service_stdfee
HAVING
    CASE
        WHEN AVG(a.apptserv_fee) IS NOT NULL
        THEN LPAD('$' || TO_CHAR(AVG(a.apptserv_fee) 
            - s.service_stdfee, '9990.99'), 12, ' ')
        ELSE ''
    END IS NOT NULL
ORDER BY
    s.service_code;

/*2(f)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer
    
SELECT
    p.patient_no,
    p.patient_fname || ' ' || p.patient_lname AS patientname,
    FLOOR((TO_DATE('30-Oct-2023', 'dd-Mon-yyyy') - p.patient_dob) / 365.25) AS current_age,
    COUNT(a.appt_no) AS numappts,
    LPAD(ROUND((COUNT(CASE WHEN a.appt_prior_apptno IS NOT NULL THEN 1 ELSE NULL END) / COUNT(a.appt_no)) * 100, 1) || '%', 12, ' ') AS followups
FROM
    mns.patient p
    LEFT JOIN mns.appointment a ON p.patient_no = a.patient_no
GROUP BY
    p.patient_no, p.patient_fname, p.patient_lname, p.patient_dob
ORDER BY
    p.patient_no;
    
/*2(g)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT
    p.provider_code AS pcode,
    CASE WHEN COUNT(DISTINCT a.appt_no)> 0
        THEN LPAD(COUNT(DISTINCT a.appt_no), 12, ' ')
        ELSE LPAD('-', 12, ' ')
    END AS numberappts,
    CASE WHEN SUM(CASE WHEN fees.apptserv_fee IS NOT NULL THEN fees.apptserv_fee ELSE 0 END) > 0
        THEN LPAD('$' || TO_CHAR(SUM(CASE WHEN fees.apptserv_fee IS NOT NULL THEN fees.apptserv_fee ELSE 0 END), '99990.99'), 12, ' ')
        ELSE LPAD('-', 12, ' ') 
    END AS totalfees,
    CASE WHEN SUM(CASE WHEN asi.item_quantity IS NOT NULL THEN asi.item_quantity ELSE 0 END)> 0 
        THEN LPAD(SUM(CASE WHEN asi.item_quantity IS NOT NULL THEN asi.item_quantity ELSE 0 END), 12, ' ')
        ELSE LPAD('-', 12, ' ') 
    END AS noitems
FROM
    mns.provider p
LEFT JOIN
    mns.appointment a ON p.provider_code = a.provider_code
LEFT JOIN
    (
        SELECT aps.appt_no, aps.apptserv_fee
        FROM mns.appt_serv aps
        WHERE aps.appt_no IN (
            SELECT appt_no
            FROM mns.appointment
            WHERE appt_datetime >= TO_DATE('10-SEP-2023 09:00', 'dd-MON-yyyy hh24:mi')
            AND appt_datetime <= TO_DATE('14-SEP-2023 17:00', 'dd-MON-yyyy hh24:mi')
        )
    ) fees ON a.appt_no = fees.appt_no
LEFT JOIN
    (
        SELECT asi.appt_no, item_id, SUM(asi.as_item_quantity) AS item_quantity
        FROM mns.apptservice_item asi
        WHERE asi.appt_no IN (
            SELECT appt_no
            FROM mns.appointment
            WHERE appt_datetime >= TO_DATE('10-SEP-2023 09:00', 'dd-MON-yyyy hh24:mi')
            AND appt_datetime <= TO_DATE('14-SEP-2023 17:00', 'dd-MON-yyyy hh24:mi')
        )
        GROUP BY asi.appt_no, item_id
    ) asi ON a.appt_no = asi.appt_no
LEFT JOIN
    mns.item i ON asi.item_id = i.item_id
GROUP BY p.provider_code
ORDER BY p.provider_code;
