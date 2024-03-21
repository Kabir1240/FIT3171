--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T3-mns-json.sql

--Student ID: 30032067
--Student Name: Kabir Kashif
--Unit Code: FIT3171
--Applied Class No: 03

/* Comments for your marker:




*/

/*3(a)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT TO GENERATE 
-- THE COLLECTION OF JSON DOCUMENTS HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer
 
SELECT
    JSON_OBJECT (
        '_id' VALUE a.appt_no,
        'datetime' VALUE TO_CHAR(a.appt_datetime, 'dd-mm-yyyy hh24:mi'),
        'provider_code' VALUE p.provider_code,
        'provider_name' VALUE provider_name,
        'item_totalcost' VALUE SUM(aps.apptserv_itemcost),
        'no_of_items' VALUE COUNT(asi.item_id),
        'items' VALUE JSON_ARRAYAGG(
        JSON_OBJECT(
                'id' VALUE i.item_id,
                'desc' VALUE i.item_desc,
                'standardcost' VALUE i.item_stdcost,
                'quantity' VALUE asi.as_item_quantity
            )) FORMAT JSON
        )
    || ','
FROM
    mns.appointment a
    JOIN (
        SELECT
            provider_code,
            (CASE
                WHEN provider_title IS NOT NULL AND provider_fname IS NOT NULL AND provider_lname IS NOT NULL
                    THEN provider_title || '. ' || provider_fname || ' ' || provider_lname
                WHEN provider_title IS NOT NULL AND provider_fname IS NOT NULL
                    THEN provider_title || '. ' || provider_fname
                WHEN provider_title IS NOT NULL AND provider_lname IS NOT NULL
                    THEN provider_title || '. ' || provider_lname
                WHEN provider_fname IS NOT NULL AND provider_lname IS NOT NULL
                    THEN provider_fname || ' ' || provider_lname
                WHEN provider_title IS NOT NULL
                    THEN provider_title
                WHEN provider_fname IS NOT NULL
                    THEN provider_fname
                WHEN provider_lname IS NOT NULL
                    THEN provider_lname
                ELSE ''
            END) AS provider_name
        FROM mns.provider
    ) p ON a.provider_code = p.provider_code
    JOIN mns.appt_serv aps ON a.appt_no = aps.appt_no
    JOIN mns.apptservice_item asi ON a.appt_no = asi.appt_no
    JOIN mns.item i ON asi.item_id = i.item_id
GROUP BY
    a.appt_no, a.appt_datetime, p.provider_code, provider_name
ORDER BY
    a.appt_no;
