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
if __name__ == "__main__":
    app.run(host="0.0.0.0", port="8082")