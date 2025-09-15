DELIMITER //

CREATE PROCEDURE ManageBooking (
    IN p_BookingID INT,
    IN p_BookingDate DATE,
    IN p_TableNumber INT
)
BEGIN
    DECLARE v_Count INT;

    -- نشيك إذا الطاولة محجوزة في نفس اليوم
    SELECT COUNT(*) INTO v_Count
    FROM Bookings
    WHERE BookingDate = p_BookingDate
      AND TableNumber = p_TableNumber;

    IF v_Count = 0 THEN
        -- الطاولة متاحة → نحجز
        INSERT INTO Bookings (BookingID, BookingDate, TableNumber)
        VALUES (p_BookingID, p_BookingDate, p_TableNumber);

        SELECT CONCAT('Booking confirmed for table ', p_TableNumber,
                      ' on ', p_BookingDate) AS Message;
    ELSE
        -- الطاولة محجوزة → نرفض
        SELECT CONCAT('Table ', p_TableNumber,
                      ' is already booked on ', p_BookingDate) AS Message;
    END IF;
END //

DELIMITER ;


