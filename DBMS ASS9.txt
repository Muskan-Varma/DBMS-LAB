import mysql.connector
from mysql.connector import Error

try:
    connection = mysql.connector.connect(host='localhost',
                                         database='mkdb1',
                                         user='root',
                                         password='')
    if connection.is_connected():
        db_Info = connection.get_server_info()
        print("Connected to MySQL Server version ", db_Info)
        cursor = connection.cursor()
        cursor.execute("select database();")
        record = cursor.fetchone()
        print("You're connected to database: ", record)

    '''sql="create table Employee(eid int(10), name varchar(250),salary float, age int(10),primary key(eid))"
    cursor.execute(sql)
    print("\nEmployee Table Created Successfully !\n")
    '''

    while True:
        print("\n1. Insert \n2. Update \n3. Delete \n4. Display \n5. Exit\n")
        ch=int(input("\nEnter your choice : "))

        if ch==1:
            #sql1= "INSERT INTO Employee (eid, name, salary, age) VALUES(105, 'Bhavika Parekh', 170000, 20) "
            eid=input("\nEnter ID :")
            name=input("\nName :")
            salary=input("\nSalary :")
            age=input("\nAge :")

            sql1="insert into Employee values("+ eid +",'" +name+ "'," +salary+ "," +age+ ")"

            cursor.execute(sql1)
            connection.commit()
            print("\n")
            print(cursor.rowcount, "Record inserted successfully into Employee table")

        elif ch==2:
            eid=input("\nEnter ID to update:")
            name=input("\nNew Name :")
            salary=input("\nNew Salary :")
            age=input("\nNew Age :")

            sql2="update Employee set name='"+name+"', salary="+salary+", age="+age+" where eid="+eid+""
            cursor.execute(sql2)
            connection.commit()
            print("\n")
            print(cursor.rowcount, "Record updated successfully into Employee table")

        elif ch==3:
            eid=input("\nEnter Employee ID to delete:")

            sql3="delete from Employee where eid="+eid+""
            cursor.execute(sql3)
            connection.commit()
            print("\n")
            print(cursor.rowcount, "Record deleted successfully from Employee table")

        elif ch==4:
            sql_select_Query = "select * from Employee"
            cursor.execute(sql_select_Query)
            records = cursor.fetchall()
            print("\nTotal number of rows in table: ", cursor.rowcount)

            print("\nPrinting each row")
            for row in records:
                print("Id = ", row[0], )
                print("Name = ", row[1])
                print("Salary  = ", row[2])
                print("Age  = ", row[3])
                print("\n")

        elif ch==5:
            quit()

    else :
        print("\nInvalid Choice !!!")
       
except Error as e:
    print("Error while connecting to MySQL", e)
finally:
    if connection.is_connected():
        cursor.close()
        connection.close()
        print("MySQL connection is closed")