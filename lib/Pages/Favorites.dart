import 'dart:convert';

import 'package:final_project_v0/MyAppBar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Variables.dart';


class Favorites extends StatefulWidget {
  const Favorites({ Key? key }) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    List recipes = ModalRoute.of(context)!.settings.arguments as List;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        title: Text("Favorites"),
        
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
                
              ),
            ),
          );
        },
      ),
    );
  }
}