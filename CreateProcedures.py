import mysql.connector


connection = mysql.connector.connect(
    host="localhost",
    user="root",
    password="1234",
    database="LittleLemon"
)

cursor = connection.cursor()


# -------- إنشاء الإجراءات المخزنة --------

# 1. AddBooking
cursor.execute("DROP PROCEDURE IF EXISTS AddBooking;")
cursor.execute("""
    CREATE PROCEDURE AddBooking (
        IN p_BookingID INT,
        IN p_CustomerID INT,
        IN p_EmployeeID INT,
        IN p_BookingDate DATETIME
    )
    BEGIN
        INSERT INTO Bookings (BookingID, CustomerID, EmployeeID, BookingDate)
        VALUES (p_BookingID, p_CustomerID, p_EmployeeID, p_BookingDate);
    END
""")

# 2. UpdateBooking
cursor.execute("DROP PROCEDURE IF EXISTS UpdateBooking;")
cursor.execute("""
    CREATE PROCEDURE UpdateBooking (
        IN p_BookingID INT,
        IN p_BookingDate DATETIME
    )
    BEGIN
        UPDATE Bookings
        SET BookingDate = p_BookingDate
        WHERE BookingID = p_BookingID;
    END
""")

# 3. CancelBooking
cursor.execute("DROP PROCEDURE IF EXISTS CancelBooking;")
cursor.execute("""
    CREATE PROCEDURE CancelBooking (
        IN p_BookingID INT
    )
    BEGIN
        DELETE FROM Bookings
        WHERE BookingID = p_BookingID;
    END
""")

print("Stored procedures created successfully!")


connection.commit()





