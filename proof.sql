-- =====================================================
-- PROOF OF CONSTRAINT TESTING
-- Three INSERT statements that PostgreSQL should refuse,
-- plus the exact error messages expected.
-- =====================================================


-- =====================================================
-- TEST 1: INVALID payment_id FOREIGN KEY
-- =====================================================

INSERT INTO payment_application
(payment_id, invoice_id, amount_applied, application_date)
VALUES (9999, 1, 100.00, CURRENT_DATE);

-- Expected Error:
-- ERROR: insert or update on table "payment_application"
-- violates foreign key constraint "fk_app_payment"
-- (SQLSTATE 23503)



-- =====================================================
-- TEST 2: NEGATIVE amount_applied CHECK CONSTRAINT
-- =====================================================

INSERT INTO payment_application
(payment_id, invoice_id, amount_applied, application_date)
VALUES (1, 1, -50.00, CURRENT_DATE);

-- Expected Error:
-- ERROR: new row for relation "payment_application"
-- violates check constraint
-- "payment_application_amount_applied_check"
-- (SQLSTATE 23514)



-- =====================================================
-- TEST 3: INVALID payment_method CHECK CONSTRAINT
-- =====================================================

INSERT INTO payment
(customer_id, payment_date, payment_method, amount_received, reference_number)
VALUES (1, CURRENT_DATE, 'Bitcoin', 500.00, 'BTC-TEST-001');

-- Expected Error:
-- ERROR: new row for relation "payment"
-- violates check constraint
-- "payment_payment_method_check"
-- (SQLSTATE 23514)