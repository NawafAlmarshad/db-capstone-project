-- نغير الـ delimiter عشان نقدر نكتب الإجراء بالكامل
DELIMITER $$

CREATE PROCEDURE GetMaxQuantity()
BEGIN
    SELECT MAX(quantity) AS MaxQuantity
    FROM Orders;
END $$

DELIMITER ;

-- لتشغيل الإجراء:
CALL GetMaxQuantity();

DELIMITER $$

CREATE PROCEDURE CancelOrder(IN order_id INT)
BEGIN
    DELETE FROM Orders
    WHERE OrderID = order_id;
END $$

DELIMITER ;

-- لتشغيل الإجراء وحذف طلب رقم 5 مثلا:
CALL CancelOrder(5);
