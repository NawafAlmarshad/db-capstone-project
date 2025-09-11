import mysql.connector as connector

# إنشاء الاتصال بقاعدة البيانات
connection = connector.connect(
    user="root",       # حط اسم المستخدم حق قاعدة البيانات
    password="1234",   # حط الباسوورد
              # اسم قاعدة البيانات
)

# إنشاء كائن cursor لإرسال الاستعلامات
cursor = connection.cursor()
