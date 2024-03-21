--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T4-mns-plsql.sql

--Student ID: 30032067
--Student Name: Kabir Kashif
--Unit Code: FIT3171
--Applied Class No: 03

/* Comments for your marker:

*/

SET SERVEROUTPUT ON

--4(a) 
-- Complete the procedure below
CREATE OR REPLACE PROCEDURE prc_insert_appt_serv (
    p_appt_no      IN NUMBER,
    p_service_code IN CHAR,
    p_output       OUT VARCHAR2
) AS
    var_appt_no_found       NUMBER;
    var_service_code_found  NUMBER;
    var_provider_code_valid CHAR(10);
    
BEGIN
    -- Check if the appointment number is valid
    SELECT
        COUNT(*)
    INTO var_appt_no_found
    FROM
        appointment
    WHERE
        appt_no = p_appt_no;

    -- Check if the service code is valid
    SELECT
        COUNT(*)
    INTO var_service_code_found
    FROM
        service
    WHERE
        service_code = p_service_code;
    
    -- Update output if any of the inputs are invalid
    IF var_appt_no_found = 0 THEN
        p_output := 'Invalid appointment number.';
    ELSIF var_service_code_found = 0 THEN
        p_output := 'Invalid service code.';
    
    ELSE
        -- Retrieve the provider code for the appointment
        SELECT provider_code
        INTO var_provider_code_valid
        FROM appointment
        WHERE appt_no = p_appt_no;

        -- Check if the provider can provide the service
        SELECT COUNT(*)
        INTO var_service_code_found
        FROM provider_service
        WHERE provider_code = var_provider_code_valid
        AND service_code = p_service_code;
        
        IF var_service_code_found = 0 THEN
            p_output := 'Provider cannot provide this service for the appointment.';
        ELSE
            -- Insert the appointment service
            INSERT INTO appt_serv (appt_no, service_code, apptserv_fee, apptserv_itemcost)
            VALUES (p_appt_no, p_service_code, 0, 0);
            p_output := 'Appointment service inserted successfully.';
            END IF;
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            p_output := 'An error occurred: ' || SQLERRM;
END prc_insert_appt_serv;
/

-- Write Test Harness for 4(a)
-- Define variables for input and output
DECLARE
    p_output       VARCHAR2(100);
BEGIN
    -- Call the procedure with the input variables
    prc_insert_appt_serv(5, 'sv55', p_output);

    -- Print the output
    DBMS_OUTPUT.PUT_LINE('Output: ' || p_output);
    
    -- You can add additional logic to handle the output as needed
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ');
END;
/

DECLARE
    p_output       VARCHAR2(100);
BEGIN
    -- Call the procedure with the input variables
    prc_insert_appt_serv(1234567, 'P001', p_output);

    -- Print the output
    DBMS_OUTPUT.PUT_LINE('Output: ' || p_output);
    
    -- You can add additional logic to handle the output as needed
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ');
END;
/

DECLARE
    p_output       VARCHAR2(100);
BEGIN
    -- Call the procedure with the input variables
    prc_insert_appt_serv(5, 'P001', p_output);

    -- Print the output
    DBMS_OUTPUT.PUT_LINE('Output: ' || p_output);
    
    -- You can add additional logic to handle the output as needed
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ');
END;
/


--4(b) 
--Write your trigger statement, 
--finish it with a slash(/) followed by a blank line
CREATE OR REPLACE TRIGGER tr_apptservice_item
AFTER INSERT OR UPDATE OR DELETE ON APPTSERVICE_ITEM
FOR EACH ROW
DECLARE
    l_total_cost NUMBER := 0;
    old_total_cost NUMBER := 0;
BEGIN
    IF INSERTING THEN
        -- Find New Total Cost
        SELECT i.item_stdcost * :NEW.as_item_quantity
        INTO l_total_cost
        FROM item i
        WHERE i.item_id = :NEW.item_id;
        
        -- Update item_stock
        UPDATE item i
        SET i.item_stock = i.item_stock - :NEW.as_item_quantity
        WHERE i.item_id = :NEW.item_id;
        
        -- Update apptserv_itemcost
        UPDATE appt_serv a
        SET a.apptserv_itemcost = a.apptserv_itemcost + l_total_cost
        WHERE a.appt_no = :NEW.appt_no;
    END IF;
    
    IF UPDATING THEN
            -- Find Old Total cost
        SELECT i.item_stdcost * :OLD.as_item_quantity
        INTO old_total_cost
        FROM item i
        WHERE i.item_id = :OLD.item_id;
        
        -- Find New Total Cost
        SELECT i.item_stdcost * :NEW.as_item_quantity
        INTO l_total_cost
        FROM item i
        WHERE i.item_id = :NEW.item_id;
        
        -- Update item_stock
        UPDATE item i
        SET i.item_stock = i.item_stock - (:OLD.as_item_quantity - :NEW.as_item_quantity)
        WHERE i.item_id = :NEW.item_id;
        
        -- Update apptserv_itemcost
        UPDATE appt_serv a
        SET a.apptserv_itemcost = a.apptserv_itemcost + (old_total_cost - l_total_cost)
        WHERE a.appt_no = :NEW.appt_no;
    END IF;
    
    IF DELETING THEN
            -- Find Old Total cost
        SELECT i.item_stdcost * :OLD.as_item_quantity
        INTO old_total_cost
        FROM item i
        WHERE i.item_id = :OLD.item_id;
        
        -- Update item_stock
        UPDATE item i
        SET i.item_stock = i.item_stock + :OLD.as_item_quantity
        WHERE i.item_id = :OLD.item_id;
        
        -- Update apptserv_itemcost
        UPDATE appt_serv a
        SET a.apptserv_itemcost = a.apptserv_itemcost - old_total_cost
        WHERE a.appt_no = :OLD.appt_no; 
    END IF;
END;
/

-- Write Test Harness for 4(b)
-- Simulate INSERT operation on APPTSERVICE_ITEM
INSERT INTO APPTSERVICE_ITEM (AS_ID, APPT_NO, SERVICE_CODE, ITEM_ID, AS_ITEM_QUANTITY)
VALUES (1, 5, 'P001', 1, 5);

-- Simulate UPDATE operation on APPTSERVICE_ITEM
UPDATE APPTSERVICE_ITEM
SET AS_ITEM_QUANTITY = 0
WHERE APPT_NO = 5 AND ITEM_ID = 1;

-- Simulate DELETE operation on APPTSERVICE_ITEM
DELETE FROM APPTSERVICE_ITEM
WHERE APPT_NO = 5 AND ITEM_ID = 1;

-- Check the updated values
SELECT APPTS.APTSERV_ITEMCOST, I.ITEM_STOCK
FROM APPT_SERV APPTS
JOIN ITEM I ON APPTS.ITEM_ID = I.ITEM_ID
WHERE APPTS.APPT_NO = 1;