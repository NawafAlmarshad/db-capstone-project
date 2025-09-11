# استيراد المكتبة مع alias
import mysql.connector as connector

# إنشاء الاتصال بقاعدة البيانات
connection = connector.connect(
    user="root",       # حط اسم المستخدم حق قاعدة البيانات
    password="1234",   # حط الباسوورد
    db="restaurantdb"           # اسم قاعدة البيانات
)

# إنشاء كائن cursor لإرسال الاستعلامات
cursor = connection.cursor()
# استعلام لعرض الجداول
# استعلام JOIN بين جدول Customers و Orders
query = """
SELECT c.FullName, c.ContactNumber, o.TotalCost
FROM customers c
JOIN  bookings o ON c.CustomerID = o.CustomerID
WHERE o.TotalCost > 60
"""

# تنفيذ الاستعلام
cursor.execute(query)

# الحصول على النتائج
high_value_customers = cursor.fetchall()

# طباعة النتائج
print("Customers with orders > $60:")
for customer in high_value_customers:
    print(f"Name: {customer[0]}, Contact: {customer[1]}, Total Cost: ${customer[2]}")
