-- Table creation for N_Roll_Call
CREATE TABLE N_Roll_Call (
  student_id NUMBER,
  attendance_date DATE,
  attendance_status VARCHAR2(10),
  CONSTRAINT pk_n_roll_call PRIMARY KEY (student_id, attendance_date)
);

-- Table creation for O_Roll_Call
CREATE TABLE O_Roll_Call (
  student_id NUMBER,
  attendance_date DATE,
  attendance_status VARCHAR2(10),
  CONSTRAINT pk_o_roll_call PRIMARY KEY (student_id, attendance_date)
);

-- Insert sample data into N_Roll_Call
INSERT ALL
  INTO N_Roll_Call (student_id, attendance_date, attendance_status) VALUES (1, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'Present')
  INTO N_Roll_Call (student_id, attendance_date, attendance_status) VALUES (2, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'Absent')
  INTO N_Roll_Call (student_id, attendance_date, attendance_status) VALUES (3, TO_DATE('2023-01-02', 'YYYY-MM-DD'), 'Present')
  INTO N_Roll_Call (student_id, attendance_date, attendance_status) VALUES (4, TO_DATE('2023-01-02', 'YYYY-MM-DD'), 'Present')
SELECT * FROM dual;


-- Create or replace procedure to merge data from N_Roll_Call to O_Roll_Call
CREATE OR REPLACE PROCEDURE merge_roll_call_data (
  p_student_id NUMBER,
  p_date DATE
) IS
  CURSOR c_roll_call_data IS
    SELECT *
    FROM N_Roll_Call
    WHERE student_id = p_student_id
      AND attendance_date = p_date;

  v_existing_data_check NUMBER;

BEGIN
  -- Loop through the records in N_Roll_Call
  FOR n_rec IN c_roll_call_data
  LOOP
    -- Check if the data already exists in O_Roll_Call
    SELECT COUNT(*)
    INTO v_existing_data_check
    FROM O_Roll_Call
    WHERE student_id = n_rec.student_id
      AND attendance_date = n_rec.attendance_date;

    -- If data doesn't exist, insert into O_Roll_Call
    IF v_existing_data_check = 0 THEN
      INSERT INTO O_Roll_Call
      VALUES (n_rec.student_id, n_rec.attendance_date, n_rec.attendance_status);
    ELSE
      -- If data exists, skip insertion
      DBMS_OUTPUT.PUT_LINE('Data already exists for Student ID ' || n_rec.student_id ||
                           ' on ' || TO_CHAR(n_rec.attendance_date, 'YYYY-MM-DD'));
    END IF;
  END LOOP;
  
  -- Commit the transaction
  COMMIT;
  
  DBMS_OUTPUT.PUT_LINE('Data merge completed successfully.');

EXCEPTION
  WHEN OTHERS THEN
    -- Handle exceptions if needed
    DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
    ROLLBACK;
END merge_roll_call_data;
/


DECLARE
  -- Provide actual values for the parameters
  v_student_id NUMBER := 1; -- Replace with an actual student ID
  v_date DATE := TO_DATE('2023-01-01', 'YYYY-MM-DD'); -- Replace with an actual date
  
BEGIN
  -- Call the procedure with the provided parameters
  merge_roll_call_data(v_student_id, v_date);
END;
/

-- Query the O_Roll_Call table
SELECT * FROM O_Roll_Call;

SELECT * FROM N_Roll_Call;