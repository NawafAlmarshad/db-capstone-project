# استيراد المكتبة مع alias
import mysql.connector as connector

# إنشاء الاتصال بقاعدة البيانات
connection = connector.connect(
    user="root",
    password="1234",
    database="littlelemon"
)


cursor = connection.cursor()
