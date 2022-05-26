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

@app.route('/tomato_spaghetti')
def tomato_spaghetti():
    return '''
    <h1> Equipment: Normal cooking equipment </h1>
    <h1> Ingredients: Two tbsp of butter, one half tbsp oil, one small onion, finely chopped, two cloves of garlic, crushed,
    one large carrot, finely chopped, two stalks of celery, finely chopped, two chopped tomatoes, one half tbsp dried oregano,
    twenty capers, cut in half or thirds, salt and pepper to taste </h1>

    <h2>1  Add the butter and oil to a pan and melt. Add in the onion and cook on a medium heat for three minutes 
    until it starts to soften. Add the carrots, celery and garlic and fry for another couple of minutes, 
    stirring regularly. </h2>
    <h2>2 Pour in the chopped tomatoes, dried oregano and chopped capers and mix well. </h2>
    <h2>3 Cook on a high simmer for twelve minutes before serving with cooked spaghetti.
     Season with salt and pepper to taste. </h2>
    '''

@app.route('/chicken_schnitzel')
def chicken_schnitzel():
    return '''
    <h1> Equipment: Plastic wrap, mallet, plates and bowls, sauté pan or skillet, spatula or tongs, drying rack, paper towels </h1>
    <h1> Ingredients: One lb boneless skinless chicken breasts, one half cup flour, two large eggs, one cup breadcrumbs, matzo meal, or panko,
    one tbsp paprika, one tbsp sesame seeds, one fourth tsp salt, or more to taste, Oil for frying, avocado oil or grapeseed oil both work well,
    Fresh lemon wedges for garnish</h1>
    <h2>1 For each breast, check to see if there is a tenderloin </h2>
    <h2>2 If there is a tenderloin, slice it off of the breast. Trim any visible tendons or extra bits of fat from the breast and the tenderloin. Set tenderloin aside.</h2>
    <h2>3 Lay the breast on cutting board with smooth side facing upward. Identify the thickest round edge of the breast. Place your hand flat on the top of the breast. Slice carefully horizontally into the thickest round edge, slicing about three quarters of the way into the breast. Do not slice all the way through.</h2>
    <h2>4 Unfold the breast to reveal two symmetrical halves. Slice down the middle to divide the breast into two equal pieces. When finished with the pound of chicken, you should have 4 breasts of relatively equal size, and perhaps a couple of tenderloins as well.</h2>
    <h2>5 Lay down a three foot long strip of plastic wrap on your kitchen countertop. Place chicken breasts and tenderloins on the plastic, leaving a two inch space between each piece of meat. Cover the breasts with another strip of plastic, so the meat is sandwiched between two layers of plastic.</h2>
    <h2>6 Use the flat side of a mallet to pound the breasts thin until they are of a uniform thickness, roughly one eigth inch thin throughout.</h2>
    <h2>7 Place all the pounded breasts and tenderloins on a plate. Set up three wide, shallow bowls and a large empty plate on your countertop. In your first bowl, put the flour. In your second bowl, beat the eggs together with two tsp of water until well mixed. In your third bowl, stir together the breadcrumbs, paprika, one fourth tsp salt and sesame seeds until well blended. Place empty plate nearby where you will put your coated schnitzels.</h2>
    <h2>8 Pour oil into a skillet or saute pan until it is deep enough for frying. Heat the oil slowly over medium. While oil is heating, dip each breast one by one into your breading bowls first dredge with flour.</h2>
    <h2>9 dip the floured breast in egg until well coated.</h2>
    <h2>10 Finally, place the egg-covered breast into the bowl of breadcrumb mixture. Use a dry hand to coat the breast evenly with breadcrumbs. Repeat process for remaining breasts and tenderloins.</h2>
    <h2>11 Frying oil should be three hundred and fifty degrees F. Fry the coated breasts in singlelayer batches until they are golden brown on both sides. If your oil is at the right temperature, it should take about three minutes per side to cook the schnitzels.</h2>
    <h2>12 After frying, set the schnitzels on a drying rack to drain excess oil.</h2>


    '''
if __name__ == "__main__":
    app.run(host="0.0.0.0", port="8082")