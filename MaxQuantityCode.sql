DELIMITER //

CREATE PROCEDURE GetMaxQuantity()
BEGIN
    SELECT MAX(quantity) AS MaxQuantity
    FROM Orders;
END //

DELIMITER ;
