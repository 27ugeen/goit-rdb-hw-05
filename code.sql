-- Task 1.
SELECT 
    order_details.*,
    (SELECT orders.customer_id 
     FROM orders 
     WHERE orders.id = order_details.order_id) AS customer_id
FROM 
    order_details;


-- Task 2.
SELECT *
FROM order_details
WHERE order_id IN (
    SELECT id
    FROM orders
    WHERE shipper_id = 3
);

-- Task 3.
SELECT 
    subquery.order_id,
    AVG(subquery.quantity) AS avg_quantity
FROM (
    SELECT *
    FROM order_details
    WHERE quantity > 10
) AS subquery
GROUP BY subquery.order_id;

-- Task 4.
WITH temp AS (
    SELECT *
    FROM order_details
    WHERE quantity > 10
)
SELECT 
    temp.order_id,
    AVG(temp.quantity) AS avg_quantity
FROM temp
GROUP BY temp.order_id;

-- Task 5-1.
DROP FUNCTION IF EXISTS divide;

DELIMITER //

CREATE FUNCTION divide(a FLOAT, b FLOAT)
RETURNS FLOAT
DETERMINISTIC
BEGIN
    IF b = 0 THEN
        RETURN NULL;
    ELSE
        RETURN a / b;
    END IF;
END //

DELIMITER ;

-- Task 5-2.
SELECT 
    order_id,
    product_id,
    quantity,
    divide(quantity, 2) AS divided_quantity
FROM 
    order_details;