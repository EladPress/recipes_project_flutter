import 'dart:convert';

import 'package:final_project_v0/MyAppBar.dart';
import 'package:final_project_v0/Pages/AddRecipe.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Variables.dart';
import 'package:final_project_v0/Methods.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _username = '';
  @override
  Widget build(BuildContext context) {
    List recipes = ModalRoute.of(context)!.settings.arguments as List;

    print(recipes[2]['id']); /////////

    Future<void> add_recipe(int recipe_id, int user_id) async {
      print('recipeid: ' +
          recipe_id.toString() +
          ", userid: " +
          user_id.toString());
      final url =
          '/insert_favorite/' + recipe_id.toString() + '/' + user_id.toString();
      var response = await Methods.flaskRequest(url);
    }

    void test() {
      setState(() {
        if (user.isNotEmpty) {
          print('not empty');
          _username = user['firstname'] + ' ' + user['lastname'];
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        title: Text("Home"),
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: Card(
              elevation: 2,
              child: ExpansionTile(
                childrenPadding:
                    EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                //onTap: () {},
                title: Text(recipes[index]['name']),
                //expandedAlignment: Alignment.topLeft,
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    recipes[index]['description'],
                    style: Theme.of(context).textTheme.bodyText1,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Visibility(
                        child: IconButton(
                          onPressed: () {
                            add_recipe(recipes[index]['id'], user['id']);
                          },
                          icon: Icon(Icons.favorite_border),
                          tooltip: "Add to favorites",
                          color: Colors.red,
                        ),
                        visible: user.isNotEmpty,
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          //Navigator.pushNamed(context, 'Recipe',
                          //arguments: recipes[index]);

                          Navigator.pushNamed(context, 'Loading', arguments: {
                            'target': 'recipe',
                            'recipe': recipes[index]['recipe']
                          });
                        },
                        child: Text("Pick recipe"),
                      ),
                    ],
                  )
                  //Image.network(recipes[index]['thumbnail']),
                ],
                //leading: CircleAvatar(
                //backgroundImage: NetworkImage(recipes[index]['thumbnail']),
                //
                //),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[400],
        //shape: const NotchedShape(),
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Visibility(
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'Loading',
                      arguments: {'target': 'favorites', 'id': user['id']});
                },
                icon: Icon(Icons.favorite),
                tooltip: 'Favorite Recipes',
              ),
              visible: user.isNotEmpty,
            ),
            Visibility(
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      user = {};
                    });
                  },
                  icon: Icon(Icons.logout)),
              visible: user.isNotEmpty,
            ),
            Spacer(),
            Visibility(
              child: Text(
                _username,
              ),
              visible: user.isNotEmpty,
            ),
            IconButton(
              iconSize: 30,
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.pushNamed(context, 'Login').then((value) {
                  test();
                });
              },
              tooltip: "Login",
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Visibility(
        child: FloatingActionButton(
          onPressed: () {
            print('pressed');
            Navigator.pushNamed(context, 'AddRecipe');
          },
          child: Icon(Icons.add),
          tooltip: 'Add recipe',
        ),
        visible: user['isAdmin'] == 1,
      ),
    );
  }
}
