from flask import Flask, jsonify, request
import json
import mysql.connector  
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

@app.route('/pizza', methods = ['GET'])
def pizza():
    return '''<h2> 1 dough </h2> 
    <h2> 2 sauce </h2>
    <h2> 3 cheese </h2>
    '''
@app.route('/test', methods = ['GET'])
def test():
    return '''
    <h2> 1 first </h2>
    <h2> 2 second </h2>
    <h2> 3 third </h2>
    '''

@app.route('/pizza2', methods = ['GET'])
def pizza2():
    return '''
    <h1> Equipment: Tray, Rolling pin, Oven, Pizza stone </h1>
    <h1> Ingredients: Dough, Tomato Sauce, Cheese, Flour </h1>
    <h2> Steps: </h2>
    <h2> 1 Preheat oven as high as it will go </h2>
    <h2> 2 Place pizza stone inside the oven </h2>
    <h2> 3 Stretch the dough </h2>
    <h2> 4 Add the sauce on top of the dough </h2>
    <h2> 5 Sprinkle the cheese above the sauce </h2>
    <h2> 6 insert into the oven for 15 minutes or until the crust and cheese are golden brown </h2>
    
    '''
if __name__ == "__main__":
    app.run(host="0.0.0.0", port="8082")