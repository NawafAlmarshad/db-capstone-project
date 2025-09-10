DELIMITER $$

CREATE PROCEDURE CheckBooking(
    IN p_BookingDate DATE,
    IN p_TableNumber INT
)
BEGIN
    DECLARE tableStatus VARCHAR(50);

    IF EXISTS (
        SELECT 1
        FROM Bookings
        WHERE BookingDate = p_BookingDate
          AND TableNumber = p_TableNumber
    ) THEN
        SET tableStatus = CONCAT('Table ', p_TableNumber, ' is already booked on ', p_BookingDate);
    ELSE
        SET tableStatus = CONCAT('Table ', p_TableNumber, ' is available on ', p_BookingDate);
    END IF;

    SELECT tableStatus AS StatusMessage;
END$$

DELIMITER ;
DELIMITER $$

CREATE PROCEDURE AddValidBooking(
    IN p_BookingDate DATE,
    IN p_TableNumber INT,
    IN p_CustomerID INT
)
BEGIN
    DECLARE tableTaken INT;

    START TRANSACTION;

    -- التحقق إذا الطاولة محجوزة
    SELECT COUNT(*) INTO tableTaken
    FROM Bookings
    WHERE BookingDate = p_BookingDate
      AND TableNumber = p_TableNumber;

    IF tableTaken > 0 THEN
        -- الطاولة محجوزة، الغاء العملية
        ROLLBACK;
        SELECT CONCAT('Booking failed: Table ', p_TableNumber, ' is already booked on ', p_BookingDate) AS Message;
    ELSE
        -- الطاولة متاحة، إضافة الحجز
        INSERT INTO Bookings (BookingDate, TableNumber, CustomerID)
        VALUES (p_BookingDate, p_TableNumber, p_CustomerID);
        COMMIT;
        SELECT CONCAT('Booking successful: Table ', p_TableNumber, ' booked for ', p_BookingDate) AS Message;
    END IF;
END$$

DELIMITER ;
