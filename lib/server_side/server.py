from importlib.resources import path
from flask import Flask, jsonify, request
import json
import mysql.connector
from requests_html import HTMLSession  
import re

mydb = mysql.connector.connect(
  host="127.0.0.1",
  user="root",
  password="Test@3092",
  database="EladDB",
)

app = Flask(__name__)

@app.route('/', methods = ['GET'])
def main():
    return '<h1> API running </h1>'

@app.route('/insert_user/<string:firstname>/<string:lastname>/<string:password>', methods = ['POST', 'GET'])
def insert_user(firstname : str, lastname : str, password : str):
    mycursor = mydb.cursor()
    mycursor.execute("insert into Users(firstname, lastname, password) values('{}', '{}', '{}')".format(firstname, lastname, password))
    mydb.commit()
    return "Entered {} to DataBase".format(firstname)

@app.route('/insert_recipe/<string:name>/<string:description>/<string:recipe>/<string:thumbnail>', methods = ['POST', 'GET'])
def insert_recipe(name : str, description : str, recipe : str, thumbnail : str):
    mycursor = mydb.cursor()
    mycursor.execute("insert into Recipes(name, description, recipe, thumbnail) values('{}', '{}', '{}', '{}')".format(name, description, recipe, thumbnail))
    mydb.commit()
    return 'entered {} to Database'.format(name)

@app.route('/select_user/<string:firstname>/<string:lastname>/<string:password>', methods = ['GET'])
def select_user(firstname : str, lastname : str, password : str):
    mycursor = mydb.cursor()
    mycursor.execute("select * from Users where FirstName = '{}' and LastName = '{}' and Password = '{}'".format(firstname, lastname, password))
    myresult = mycursor.fetchall()
    result = list(myresult)
    #return str(result == True)
    #return str(len(result))
    #return len(result) > 0 and 'Logged in!' or 'User not in database.'
    if len(result) > 0:
        dic = []
        dic.append({
            'id': result[0][0],
            'firstname': result[0][1],
            'lastname' : result[0][2],
            'password' : result[0][3],
        })
        return jsonify(dic)
    else:
        return 'No user found!'

@app.route('/select_recipes')
def select_recipes():
    mycursor = mydb.cursor()
    mycursor.execute("select * from recipes")
    myresult = list(mycursor.fetchall())
    for i in myresult:
        print(list(i))
    
    dic = []
    for i in myresult:
        lis = list(i)
        dic.append({
            "id": lis[0],
            "name": lis[1],
            "description": lis[2],
            "recipe": lis[3],
            "thumbnail": lis[4]
        })
    
    print(dic)
    return jsonify(dic)

@app.route('/select_favorites/<string:id>')
def select_favorites(id : str):
    mycursor = mydb.cursor()
    mycursor.execute("select recipes.id, recipes.name, recipes.description, recipes.recipe, recipes.thumbnail from favorites inner join Recipes on recipe_id = recipes.id inner join Users on user_id = Users.id where user_id = " + id)
    myresult = list(mycursor.fetchall())
    for i in myresult:
        print(list(i))
    
    dic = []
    for i in myresult:
        lis = list(i)
        dic.append({
            "id": lis[0],
            "name": lis[1],
            "description": lis[2],
            "recipe": lis[3],
            "thumbnail": lis[4]
        })
    
    print(dic)
    return jsonify(dic)


@app.route('/display_recipe/<string:recipe>')
def display_recipe(recipe: str):
    #txt = '1 Dough 2 Tomato sauce 3 Cheese '
    txt = recipe
    result = re.findall('\d((\s[A-Za-z]+)+)', txt)
    final_result = list()
    for i in result:
        final_result.append(i[0])
    print(final_result)
    return jsonify(final_result)

@app.route('/process_recipe/<path:url>')
def process_recipe(url : path):
    session = HTMLSession()
    r = session.get(url)
    about = r.html.find('h2')
    final = ''
    for i in about:
        print(i.text)
        final += i.text + ' '
    return final
    
    #print(r.html.find('h2'))
    
    return r.text
    
    result = re.findall('\d((\s[A-Za-z]+)+)', r.text)
    final_result = list()
    for i in result:
        final_result.append(i[0])
    print(final_result)
    return jsonify(final_result)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port="8081")