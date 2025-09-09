Use littlelemondb;
-- ✅ Task 1: إنشاء Virtual Table (View)
CREATE VIEW OrdersView AS
SELECT OrderID, Quantity, TotalCost
FROM Orders
WHERE Quantity > 2;

-- جرب الاستعلام على الـ View
SELECT * FROM OrdersView;


-- ✅ Task 2: استخراج بيانات العملاء مع الطلبات > 150
SELECT 
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS FullName,
    o.OrderID,
    o.TotalCost,
    m.ItemName,
    m.Category,
    m.Price
FROM Customers c
JOIN Bookings b ON c.CustomerID = b.CustomerID
JOIN Orders o ON b.BookingID = o.BookingID
JOIN Menu m ON o.MenuID = m.MenuID
WHERE o.TotalCost > 150
ORDER BY o.TotalCost ASC;


-- ✅ Task 3: استخدام Subquery للبحث عن الـ Menu اللي له طلبات أكثر من 2
SELECT m.ItemName
FROM Menu m
WHERE m.MenuID = ANY (
    SELECT o.MenuID
    FROM Orders o
    WHERE o.Quantity > 2
);


