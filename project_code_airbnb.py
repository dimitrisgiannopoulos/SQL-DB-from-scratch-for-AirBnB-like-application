import MySQLdb
import datetime


# input information for connection to phpMyAdmin
host = input("Enter IP of database host [127.0.0.1]: ") or "127.0.0.1"
user = input("Enter username [root]: ") or "root"
password = input("Enter password : ")
conn = MySQLdb.connect(host, user, password, "airbnb")
print("Connection established!")
c = conn.cursor()


#######################################################################################
# load database with data from Airbnb.sql
def executeScriptsFromFile(filename):
    # Open and read the file as a single buffer
    fd = open(filename, 'r')
    sqlFile = fd.read()
    fd.close()

    # all SQL commands (split on ';')
    sqlCommands = sqlFile.split(';')

    # Execute every command from the input file
    for command in sqlCommands:
        try:
            c.execute(command)
        except:
            print("", end = "")
    print("")
    
    
#######################################################################################    
# main menu for user choices
def main_menu():
    print('\nOPTIONS (press enter to exit)')
    print('1: Insert an SQL command')
    print('2: Create a new user')
    print('3: Book a house')
    print('4: Insert a new house for rent')
    print('5: Send a message to another user')
    answer = ' '
    while not answer in '1 2 3 4 5'.split():
        answer = input('επιλογή.....')
        if answer == '': return 0
    else:
        return answer
            

#######################################################################################            
# function for SQL command execution through python            
def sql_command():
    print("Press enter to go back to the main menu")
    while 1:
        command = input("Enter your SQL query : ")
        if command == '':
            break
        try:
            c.execute(command)
            result = c.fetchall()
            for row in result:
                print(row)
        except:
            print("Error, please try again!") 


#######################################################################################  
# function for new user creation              
def create_new_user():
    name = input("Enter new user's name :")
    tel = input("Enter a phone number :")
    email = input("Enter an email :")
    if name == '' or tel == '' or email == '':
        print("Inserted info is incomplete, please try again!")
        create_new_user()
        return
    else:
        try:
            c.execute("INSERT INTO `XRHSTHS`(`onoma`, `proskalei`, `kinhto`, `email`) VALUES (%s, NULL, %s, %s);", (name, tel, email))
            print("User " + name + " was inserted successfully!")
        except:
            print("User " + name + " was NOT inserted, query failed!")
        
        
#######################################################################################
# function for users to book a house        
def book_house():
    name = input("What is your username ? ")
    c.execute("SELECT account_number from XRHSTHS WHERE onoma LIKE %s", [name]) # look for user in database
    result = c.fetchall()
    if len(result) > 0:
        enoikos = result[0]
        print("Authentication completed successfully, welcome " + name + "!")
    else:
        print("Authentication failed, wrong username!")
        book_house()
        return
  
    print("Choose from the choices below : ")
    c.execute("SELECT owner_account, home_ID, onomasia, xwra, polh, arxikh_timh_ana_mera FROM KATALYMA") #fetch all houses 
    result = c.fetchall()
    count = 1;
    for row in result:
        print(count, " : ", row)
        count = count + 1
    choice = 0
    while not int(choice) in range(1, len(result)):
        choice = input("Choice : ")
        try: int(choice)
        except: choice = 0
    book = ''
    while not book in "y n".split():
        print("Are you sure you want to book ", result[int(choice) - 1][2], " ? [y/n] : ", end = "") # promt user for booking confirmation
        book = input().lower()
    if book == "y":
        days = ''
        while not days in "1 2 3 4 5 6 7 8 9".split():
            days = input("How long will you be staying in days? ")
        checkout = ''
        while not checkout in "y n".split():
            price = float(result[int(choice) - 1][5])*int(days)
            print("The total cost for your stay will be ", price, ". Pay now? [y/n] :",end = "") # calculate total cost of stay and ask for payment
            checkout = input().lower()
        if checkout == 'y': paid = 1
        else: paid = 0
        c.execute("INSERT INTO DIAMONH(`owner_account`) VALUES(%s);", [result[int(choice)-1][0]]) # make new diamonh entry
        c.execute("SELECT stay_ID FROM DIAMONH ORDER BY stay_ID DESC LIMIT 1") # find the id for this stay 
        temp1 = c.fetchall()
        review =''
        while review == '':
            review = input("Please leave a review for your stay : ") # prompt user to leave review
        c.execute("INSERT INTO KRITIKH(`reviewer`, `reviewed_home`, `review_text`) VALUES(%s, %s, %s);", (enoikos, result[int(choice)-1][1], review))
        c.execute("SELECT review_ID FROM KRITIKH ORDER BY review_ID DESC LIMIT 1")
        temp2 = c.fetchall()
        c.execute("INSERT INTO BOOKING (`home_ID`, `enoikiasths`, `enoikos`, `stay_ID`, `review_ID`, `booking_date` ,`stay_date_arrive`, `stay_date_leave`, `timh_diamonhs`, `plhrwthike`) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s);",(result[int(choice)-1][1], result[int(choice)-1][1], enoikos, temp1[0][0], temp2[0][0], datetime.datetime.now(), datetime.datetime.now(), datetime.datetime.now()+datetime.timedelta(days=int(days)), price, paid))
        print("Room booked successfully! Thank you, enjoy your stay!")
        return
        
    else:
        print("Booking cancelled...Going back to the main menu!")
        return
        
        
#######################################################################################
# function for home owners to post new houses        
def insert_new_house():
    name = input("What is your username ? ")
    c.execute("SELECT account_number from XRHSTHS WHERE onoma LIKE %s", [name])
    result = c.fetchall()
    if len(result) > 0:
        owner_account = result[0]
        print("Authentication completed successfully, welcome " + name + "!")
    else:
        print("Authentication failed, wrong username!")
        insert_new_house()
        return
    xwra = input("Country of house :")
    polh = input("City of house :")
    odos = input("Street of house without number :")
    arithmos = input("Street number of house :")
    tax_kwd = input("Zip code of house :")
    arxikh_timh_ana_mera = input("Price per day for house :")
    onomasia = input("House name or short description :")
    try:
        c.execute("INSERT INTO `KATALYMA`(`owner_account`, `arxikh_timh_ana_mera`, `xwra`, `polh`, `odos` ,`arithmos`, `tax_kwd`, `onomasia`) VALUES (%s, %s, %s, %s, %s, %s, %s, %s);", (owner_account, arxikh_timh_ana_mera, xwra, polh, odos, arithmos, tax_kwd, onomasia))
        print("House was inserted successfully!")
    except:
        print("House was NOT inserted, query failed!")
   

#######################################################################################
# function for users to meassage each other   
def send_message():
    name = input("What is your username ? ")
    c.execute("SELECT account_number from XRHSTHS WHERE onoma LIKE %s", [name]) # search database for this user
    result = c.fetchall()
    if len(result) > 0:
        sender = result[0]
        print("Authentication completed successfully, welcome " + name + "!")
    else:
        print("Authentication failed, wrong username!")
        send_message()
        return
    name = input("Who do you want to send a message to ? ")
    c.execute("SELECT account_number from XRHSTHS WHERE onoma LIKE %s", [name]) # search database for this user
    result = c.fetchall()
    if len(result) > 0:
        receiver = result[0]
        print(name + " is a valid user!")
    else:
        print("No user has that username!")
        send_message()
        return
    msg = input("Insert message to send : ")
    c.execute("INSERT INTO MHNYMA(`sender`, `receiver`, `msg_text`) VALUES (%s, %s, %s);", (sender, receiver, msg))
        
        
        
#######################################################################################
# mainloop function with main menu that calls all other functions
def main():   
    print("Loading database airbnb with data...")
    # try:
    filename = "Airbnb.sql"
    executeScriptsFromFile(filename)
    # except:
        # print("Loading Failed!")
    while 1:
        answer = main_menu()
        if not answer: break
        elif answer == '1': sql_command()
        elif answer == '2': create_new_user()
        elif answer == '3': book_house()
        elif answer == '4': insert_new_house()
        elif answer == '5': send_message()
        
#######################################################################################
#execute main function
main()

