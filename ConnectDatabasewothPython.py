import mysql.connector as connector

# إنشاء الاتصال بقاعدة البيانات
connection = connector.connect(
    user="root",       
    password="1234",   
           
)

# إنشاء كائن cursor لإرسال الاستعلامات
cursor = connection.cursor()
