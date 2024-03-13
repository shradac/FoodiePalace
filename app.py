import time
import matplotlib.pyplot as plt

from flask import Flask, render_template, request, redirect, url_for
import pymysql

app = Flask(__name__)

user = ""
loginStatus = False


class Customer:
    def __init__(self):
        self.tableNumber = 1
        self.customerId = 1
        self.orderId = 1
        self.orderList = None


c = Customer()


@app.route('/')
@app.route('/home', methods=['GET', 'POST'])
def home():
    global loginStatus
    global user
    loginStatus = False
    user = ""
    return render_template('index.html', login=loginStatus)


@app.route('/about')
def about():
    return render_template('about.html', login=loginStatus)


@app.route('/menu')
def menu():
    if 'menuId' in request.args:
        currentMenuId = request.args['menuId']
    else:
        currentMenuId = '1'
    menuList = [{"menuId": '1', "title": "Chinese"},
                {"menuId": '2', "title": "Mexican"},
                {"menuId": '3', "title": "Indian"}]

    stmt_getDish = "call getDishOfMenu('" + currentMenuId + "');"
    cur.execute(stmt_getDish)
    menuItems = cur.fetchall()
    print(menuItems)
    return render_template('menu.html', login=loginStatus, menuList=menuList,
                           menuItems=menuItems, currentMenuId=currentMenuId)


@app.route('/contact')
def contact():
    return render_template('contact.html', login=loginStatus)


@app.route('/login', methods=['GET', 'POST'])
def login():
    error = None
    if request.method == 'POST':
        if request.form['username'] != 'admin' or request.form['password'] != 'admin':
            error = 'Invalid Credentials. Please try again.'
        else:
            setLogin()
            global user
            user = "admin"
            return redirect('/' + user)
    return render_template('auth/login.html', login=loginStatus, error=error)


@app.route('/admin')
def admin():
    if user == "admin":
        return render_template('admin.html', login=loginStatus)
    else:
        return redirect(url_for('login'))


@app.route('/admin/admin')
def editAdmin():
    if user == "admin":
        getAdminStatement = "call getAllAdmin();"
        cur.execute(getAdminStatement)
        adminNameIdList = cur.fetchall();
        return render_template('/admin/admin/editAdmin.html', login=loginStatus,
                               adminNameIdList=adminNameIdList)
    else:
        return redirect(url_for('login'))


@app.route('/admin/addAdmin', methods=["GET", "POST"])
def addAdmin():
    if user == "admin":
        if request.method == 'POST':
            firstName = request.form["firstname"]
            lastName = request.form["lastname"]
            mobile = request.form["mobile"]
            email = request.form["email"]
            salary = request.form["salary"]
            streetAddress = request.form["streetAddress"]
            aptNumber = request.form["aptNumber"]
            city = request.form["city"]
            state = request.form["state"]
            zipcode = request.form["zipcode"]
            stmt_insert = "call insertStaffAdmin('" + firstName + "','" + lastName + "','" + mobile + \
                          "','" + email + "','" + salary + "','" + streetAddress + "','" + aptNumber + \
                          "','" + city + "','" + state + "','" + zipcode + "')"
            cur.execute(stmt_insert)
            cnx.commit()
            return editAdmin()
        return render_template('/admin/admin/addAdmin.html', login=loginStatus)
    else:
        return redirect(url_for('login'))


@app.route('/admin/updateAdmin', methods=["GET", "POST"])
def updateAdmin():
    if user == "admin":
        if 'staffId' in request.args:
            staffId = request.args['staffId']
            getAdminStatement = "call getAdmin('" + staffId + "');"
            cur.execute(getAdminStatement)
            adminDetails = cur.fetchall()
            if request.method == 'POST':
                firstName = request.form["firstname"]
                lastName = request.form["lastname"]
                mobile = request.form["mobile"]
                email = request.form["email"]
                salary = request.form["salary"]
                streetAddress = request.form["streetAddress"]
                aptNumber = request.form["aptNumber"]
                city = request.form["city"]
                state = request.form["state"]
                zipcode = request.form["zipcode"]
                stmt_update = "call updateStaff('" + staffId + "','" + firstName + "','" + lastName + "','" + mobile + \
                              "','" + email + "','" + salary + "','" + streetAddress + "','" + aptNumber + \
                              "','" + city + "','" + state + "','" + zipcode + "')"
                cur.execute(stmt_update)
                cnx.commit()
                return editAdmin()

            return render_template('/admin/admin/updateAdmin.html', login=loginStatus,
                                   adminDetails=adminDetails[0])
        return render_template('/admin/admin/addAdmin.html', login=loginStatus)
    else:
        return redirect(url_for('login'))


@app.route('/admin/removeAdmin')
def removeAdmin():
    if user == "admin":
        staffId = request.args['staffId']
        stmt_delete = "call deleteStaff('" + staffId + "')"
        cur.execute(stmt_delete)
        cnx.commit()
        getChefStatement = "call getAllAdmin();"
        cur.execute(getChefStatement)
        adminNameIdList = cur.fetchall();
        return render_template('/admin/admin/editAdmin.html', login=loginStatus,
                               adminNameIdList=adminNameIdList)
    else:
        return redirect(url_for('login'))


@app.route('/admin/chef')
def editChef():
    if user == "admin":
        getChefStatement = "call getAllChef();"
        cur.execute(getChefStatement)
        chefNameIdList = cur.fetchall();
        return render_template('/admin/chef/editChef.html', login=loginStatus,
                               chefNameIdList=chefNameIdList)
    else:
        return redirect(url_for('login'))


@app.route('/admin/addChef', methods=["GET", "POST"])
def addChef():
    if user == "admin":
        if request.method == 'POST':
            firstName = request.form["firstname"]
            lastName = request.form["lastname"]
            mobile = request.form["mobile"]
            email = request.form["email"]
            salary = request.form["salary"]
            streetAddress = request.form["streetAddress"]
            aptNumber = request.form["aptNumber"]
            city = request.form["city"]
            state = request.form["state"]
            zipcode = request.form["zipcode"]
            stmt_insert = "call insertStaffChef('" + firstName + "','" + lastName + "','" + mobile + \
                          "','" + email + "','" + salary + "','" + streetAddress + "','" + aptNumber + \
                          "','" + city + "','" + state + "','" + zipcode + "')"
            cur.execute(stmt_insert)
            cnx.commit()
            return editChef()

        return render_template('/admin/chef/addChef.html', login=loginStatus)
    else:
        return redirect(url_for('login'))


@app.route('/admin/updateChef', methods=["GET", "POST"])
def updateChef():
    if user == "admin":
        if 'staffId' in request.args:
            staffId = request.args['staffId']
            getChefStatement = "call getChef('" + staffId + "');"
            cur.execute(getChefStatement)
            chefDetails = cur.fetchall()
            if request.method == 'POST':
                firstName = request.form["firstname"]
                lastName = request.form["lastname"]
                mobile = request.form["mobile"]
                email = request.form["email"]
                salary = request.form["salary"]
                streetAddress = request.form["streetAddress"]
                aptNumber = request.form["aptNumber"]
                city = request.form["city"]
                state = request.form["state"]
                zipcode = request.form["zipcode"]
                stmt_update = "call updateStaff('" + staffId + "','" + firstName + "','" + lastName + "','" + mobile + \
                              "','" + email + "','" + salary + "','" + streetAddress + "','" + aptNumber + \
                              "','" + city + "','" + state + "','" + zipcode + "')"
                cur.execute(stmt_update)
                cnx.commit()
                return editChef()

            return render_template('/admin/chef/updateChef.html', login=loginStatus,
                                   chefDetails=chefDetails[0])
        else:
            return redirect(url_for('editChef'))
    else:
        return redirect(url_for('login'))


@app.route('/admin/removeChef')
def removeChef():
    if user == "admin":
        staffId = request.args['staffId']
        stmt_delete = "call deleteStaff('" + staffId + "')"
        cur.execute(stmt_delete)
        cnx.commit()
        getChefStatement = "call getAllChef();"
        cur.execute(getChefStatement)
        chefNameIdList = cur.fetchall();
        return render_template('/admin/chef/editChef.html', login=loginStatus,
                               chefNameIdList=chefNameIdList)
    else:
        return redirect(url_for('login'))


@app.route('/admin/customer')
def adminCustomer():
    if user == "admin":
        return render_template('admin/customer/editCustomer.html', login=loginStatus)
    else:
        return redirect(url_for('login'))


@app.route('/admin/analysis')
def analysis():
    if user == "admin":
        saveFigSortDishesBasedOnNumberOfOrders()
        saveFigSortCustomersBasedOnNumberOfOrders()
        saveFigSortCustomersBasedOnAmount()
        saveFigGetMostOrderedDishByCustomers()

        return render_template("admin/analysis.html", login=loginStatus)
    else:
        return redirect(url_for('login'))


@app.route('/admin/addCustomer', methods=["GET", "POST"])
def adminCheckCustomer():
    if user == "admin":
        if request.method == 'POST':
            mobile = request.form["mobile"]
            capacity = request.form["capacity"]
            stmt_checkNewCustomer = "select ifNewCustomer('" + mobile + "');"
            cur.execute(stmt_checkNewCustomer)
            existingCustomer = list(cur.fetchall()[0].values())
            existingCustomer = existingCustomer[0]
            if not existingCustomer:
                return redirect(url_for("adminAddCustomer", capacity=capacity, mobile=mobile))
            else:
                return redirect(url_for('adminAddOrder', capacity=capacity, mobile=mobile))
        return render_template('admin/customer/checkCustomer.html', login=loginStatus)
    else:
        return redirect(url_for('login'))


@app.route('/admin/addNewCustomer', methods=["GET", "POST"])
def adminAddCustomer():
    if user == "admin":
        if "mobile" in request.args:
            mobile = request.args['mobile']
            capacity = request.args['capacity']
            tableNumber = getFreeTable(capacity)
            customerId = getCustomerId(mobile)
            c.tableNumber = tableNumber
            c.customerId = customerId

        if request.method == 'POST' and "firstName" in request.form:
            firstName = request.form["firstName"]
            lastName = request.form["lastName"]
            email = request.form["email"]
            streetAddress = request.form["streetAddress"]
            aptNumber = request.form["aptNumber"]
            city = request.form["city"]
            state = request.form["state"]
            zipcode = request.form["zipcode"]
            stmt_insert = "call insertCustomer('" + firstName + "','" + lastName + "','" + mobile + \
                          "','" + email + "','" + streetAddress + "','" + aptNumber + \
                          "','" + city + "','" + state + "','" + zipcode + "')"
            cur.execute(stmt_insert)
            cnx.commit()
            return redirect(url_for("adminAddOrder", capacity=capacity, mobile=mobile))

        return render_template('admin/customer/addCustomer.html', login=loginStatus)
    else:
        return redirect(url_for('login'))


@app.route('/admin/showCustomers')
def adminShowCustomers():
    if user == "admin":
        stmt_getCustomers = "call getAllCustomers();"
        cur.execute(stmt_getCustomers)
        customerList = cur.fetchall()
        return render_template('admin/customer/showCustomers.html', login=loginStatus,
                               customerList=customerList)
    else:
        return redirect(url_for('login'))


@app.route('/admin/table', methods=["GET", "POST"])
def adminTable():
    if user == "admin":
        if request.method == "POST" and "clearTable" in request.form:
            tableNumberToClear = request.form['clearTable']
            stmt_clearTable = "call updateRestaurantTableStatus('" + tableNumberToClear + "','" + "Free" + "');"
            cur.execute(stmt_clearTable)
            cnx.commit()

        stmt_getTables = "call getAllTables();"
        cur.execute(stmt_getTables)
        tableList = cur.fetchall()
        return render_template('admin/table/editTable.html', login=loginStatus, tableList=tableList)
    else:
        return redirect(url_for('login'))


@app.route('/admin/tableData', methods=["GET", "POST"])
def adminTableData():
    if user == "admin":
        if 'tableNumber' in request.args:
            currentTableNumber = request.args['tableNumber']
            table = currentTableNumber
        else:
            table = c.tableNumber
        if "customerId" in request.args:
            customerId = request.args['customerId']
            c.customerId = customerId
        if "orderList" in request.args:
            orderList = request.json
            stmt_getTableDetails = "call getTableDetails('" + str(table) + "');"
            cur.execute(stmt_getTableDetails)
            tableDetails = cur.fetchall()
            orderId = tableDetails[0]['orderId']
            deleteFromOrderContainsDishTable(orderList, orderId)
            insertIntoOrderContainsDishTable(orderList, orderId)

        time.sleep(0.5)
        stmt_getTableDetails = "call getTableDetails('" + str(table) + "');"
        cur.execute(stmt_getTableDetails)
        tableDetails = cur.fetchall()
        time.sleep(0.5)
        customerId = tableDetails[0]['customerId']
        orderId = tableDetails[0]['orderId']
        time.sleep(0.5)
        stmt_getCustomer = "call getCustomerDetails('" + str(customerId) + "');"
        cur.execute(stmt_getCustomer)
        customer = cur.fetchall()
        time.sleep(0.5)
        stmt_getOrder = "call getOrderDetails('" + str(orderId) + "');"
        cur.execute(stmt_getOrder)
        orderDetails = cur.fetchall()

        menuItems = []
        for i in ["1", "2", "3"]:
            stmt_getDish = "call getDishOfMenu('" + i + "');"
            cur.execute(stmt_getDish)
            for j in cur.fetchall():
                menuItems.append(j)
        for item in menuItems:
            item['quantity'] = 0

        for order in orderDetails:
            for item in menuItems:
                if order['dishId'] == item['dishId']:
                    item['quantity'] = order['quantity']
                    break

        return render_template('admin/table/tableData.html', login=loginStatus,
                               currentTableNumber=table, customer=customer, menuItems=menuItems)
    else:
        return redirect(url_for('login'))


@app.route('/admin/order')
def order():
    if user == "admin":
        return render_template('editOrder.html', login=loginStatus)
    else:
        return redirect(url_for('login'))


@app.route('/admin/addOrder', methods=["GET", "POST"])
def adminAddOrder():
    if user == "admin":
        menuItems = []
        for i in ["1", "2", "3"]:
            stmt_getDish = "call getDishOfMenu('" + i + "');"
            cur.execute(stmt_getDish)
            for j in cur.fetchall():
                menuItems.append(j)
        if "capacity" in request.args:
            capacity = request.args['capacity']
            mobile = request.args['mobile']
            tableNumber = getFreeTable(capacity)
            customerId = getCustomerId(mobile)
            c.tableNumber = tableNumber
            c.customerId = customerId

        if request.method == "POST" and "orderList" in request.args:
            orderList = request.json
            stmt_insert = "call insertCustomerOrder('" + "Ongoing" + "','" + "0" + "','" + "" + "','" + "0" + "');"
            cur.execute(stmt_insert)
            cnx.commit()
            stmt_getOrderId = "select getLatestOrderId();"
            cur.execute(stmt_getOrderId)
            orderId = list(cur.fetchall()[0].values())
            orderId = orderId[0]
            c.orderId = orderId
            insertIntoOrderContainsDishTable(orderList, c.orderId);
            stmt_insertTableData = "call insertCustomerWithOrderAtTable('" + str(
                c.tableNumber) + "','" + str(c.customerId) + "','" + str(c.orderId) + "');"
            cur.execute(stmt_insertTableData)
            stmt_updateTableStatus = "call updateRestaurantTableStatus('" + str(
                c.tableNumber) + "','" + "Ongoing" + "');"
            cur.execute(stmt_updateTableStatus)
            cnx.commit()
            # redirecting is handled by form action in addOrder.html

        return render_template('admin/order/addOrder.html', login=loginStatus,
                               menuItems=menuItems)
    else:
        return redirect(url_for('login'))


@app.route('/admin/menu')
def adminMenu():
    if user == "admin":
        if 'menuId' in request.args:
            currentMenuId = request.args['menuId']
        else:
            currentMenuId = '1'
        menuList = [{"menuId": '1', "title": "Chinese"},
                    {"menuId": '2', "title": "Mexican"},
                    {"menuId": '3', "title": "Indian"}]

        stmt_getDish = "call getDishOfMenu('" + currentMenuId + "');"
        cur.execute(stmt_getDish)
        menuItems = cur.fetchall()
        return render_template('admin/menu/menu.html', login=loginStatus, menuList=menuList,
                               menuItems=menuItems, currentMenuId=currentMenuId)
    else:
        return redirect(url_for('login'))


@app.route('/admin/menuAddDish', methods=["GET", "POST"])
def addDish():
    if user == "admin":
        if 'menuId' in request.args:
            currentMenuId = request.args['menuId']
            if request.method == 'POST':
                dishName = request.form["dishName"]
                price = request.form["price"]
                isVegan = request.form["isVegan"]
                instructions = request.form["instructions"]
                stmt_insert = "call insertDish('" + dishName + "','" + price + "','" + isVegan + \
                              "','" + currentMenuId + "','" + instructions + "');"
                cur.execute(stmt_insert)
                cnx.commit()
                return adminMenu()

        return render_template('admin/menu/addDish.html', login=loginStatus,
                               currentMenuId=currentMenuId)
    else:
        return redirect(url_for('login'))


@app.errorhandler(500)
def internal_server_error(e):
    # note that we set the 500 status explicitly
    return render_template('error/500.html'), 500


def getFreeTable(capacity):
    stmt_tableNumber = "select getFreeRestaurantTable('" + capacity + "')"
    cur.execute(stmt_tableNumber)
    tableNumber = list(cur.fetchall()[0].values())
    return tableNumber[0]


def getCustomerId(mobile):
    stmt_customerId = "select getCustomerId('" + mobile + "')"
    cur.execute(stmt_customerId)
    customerId = list(cur.fetchall()[0].values())
    return customerId[0]


def setLogin():
    global loginStatus
    loginStatus = True


def insertIntoOrderContainsDishTable(orderList, orderId):
    for dishId, quantity in orderList.items():
        if quantity != 0:
            stmt_insert = "call insertCustomerOrderContainsDish('" + str(orderId) + "','" + str(
                dishId) + "','" + str(quantity) + "');"
            cur.execute(stmt_insert)
    cnx.commit()


def deleteFromOrderContainsDishTable(orderList, orderId):
    for dishId, quantity in orderList.items():
        stmt_deleteCustomerOrderContainsDish = "call deleteCustomerOrderContainsDish('" + str(
            orderId) + "','" + str(dishId) + "');"
        cur.execute(stmt_deleteCustomerOrderContainsDish)
    cnx.commit()


def saveFigSortDishesBasedOnNumberOfOrders():
    stmt_call = "call sortDishesBasedOnNumberOfOrders()"
    cur.execute(stmt_call)
    sortDishesBasedOnNumberOfOrders = cur.fetchall()
    dict = {}
    for d in sortDishesBasedOnNumberOfOrders:
        dishName = d['DishName']
        number = float(d['numberOfOrders'])
        dict[dishName] = number
    fig = plt.figure(figsize=(10, 5))
    plt.ylabel("Dish Name")
    plt.xlabel("Number of Orders")
    x = list(dict.keys())
    y = list(dict.values())
    plt.barh(x, y)
    plt.savefig("static/img/analysis/sortDishesBasedOnNumberOfOrders.png", bbox_inches='tight')


def saveFigSortCustomersBasedOnNumberOfOrders():
    stmt_call = "call sortCustomersBasedOnNumberOfOrders()"
    cur.execute(stmt_call)
    sortCustomersBasedOnNumberOfOrders = cur.fetchall()
    dict = {}
    for d in sortCustomersBasedOnNumberOfOrders:
        dishName = d['CustomerName']
        number = float(d['numberOfOrders'])
        dict[dishName] = number
    fig = plt.figure(figsize=(10, 5))
    x = list(dict.keys())
    y = list(dict.values())
    plt.ylabel("Customer Name")
    plt.xlabel("Number of Orders")
    plt.barh(x, y)
    plt.savefig("static/img/analysis/sortCustomersBasedOnNumberOfOrders.png", bbox_inches='tight')


def saveFigSortCustomersBasedOnAmount():
    stmt_call = "call sortCustomersBasedOnAmount()"
    cur.execute(stmt_call)
    sortCustomersBasedOnAmount = cur.fetchall()
    dict = {}
    for d in sortCustomersBasedOnAmount:
        dishName = d['CustomerName']
        number = float(d['Amount'])
        dict[dishName] = number
    fig = plt.figure(figsize=(10, 5))
    plt.xlabel("Customer Name")
    plt.ylabel("Amount")
    x = list(dict.keys())
    y = list(dict.values())
    plt.bar(x, y)
    plt.savefig("static/img/analysis/sortCustomersBasedOnAmount.png", bbox_inches='tight')


def saveFigGetMostOrderedDishByCustomers():
    stmt_call = "call getMostOrderedDishByCustomers()"
    cur.execute(stmt_call)
    getMostOrderedDishByCustomers = cur.fetchall()
    dict = {}
    for d in getMostOrderedDishByCustomers:
        dishName = d['CustomerName'] + " - " + d['DishName']
        number = float(d['MostOrderedDish'])
        dict[dishName] = number
    fig = plt.figure(figsize=(10, 5))
    x = list(dict.keys())
    y = list(dict.values())
    plt.ylabel("Customer and Dish")
    plt.xlabel("Number of times Ordered")
    plt.barh(x, y)
    plt.savefig("static/img/analysis/getMostOrderedDishByCustomers.png", bbox_inches='tight')


def connectDB():
    config = {'host': 'localhost',
              'port': 3306, 'database': 'foodiepalace',
              'user': "root",  # Enter MySQL Server User
              'password': password,  # Enter MySQL Server Password
              'charset': 'utf8',
              'use_unicode': True,
              'cursorclass': pymysql.cursors.DictCursor
              }
    cnx = pymysql.connect(**config)
    return cnx


if __name__ == '__main__':
    try:
        cnx = connectDB()
        cur = cnx.cursor()
        app.run()
    except (pymysql.Error, pymysql.Warning) as e:
        render_template("MYSQL Server Error! Restart Server")
    except Exception as e:
        print(repr(e))
