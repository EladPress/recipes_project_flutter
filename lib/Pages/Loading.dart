import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:final_project_v0/Methods.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Map map = {};
  Future<void> getRecipes() async {
    final url = "/select_recipes";
    var response = await Methods.flaskRequest(url); 
    List data = jsonDecode(response.body);
    Navigator.pushReplacementNamed(context, 'Home', arguments: data);
  }

  Future<void> getFavorites(int id) async {
    final url = '/select_favorites/' + id.toString();
    var response = await Methods.flaskRequest(url); // as http.Response;
    List data = jsonDecode(response.body);
    Navigator.pushReplacementNamed(context, 'Favorites', arguments: data);
  }

  Future<void> getFinalRecipe() async {

    final url = "/display_recipe2/" + map['recipe'];
    var response = await Methods.flaskRequest(url);
    List data = jsonDecode(response.body) as List;
    Navigator.pushReplacementNamed(context, 'Recipe', arguments: data);

  }

  @override
  Widget build(BuildContext context) {
    //Map map = {};
    try {
      map = ModalRoute.of(context)!.settings.arguments as Map;
    } catch (e) {}
    //if (map == "{}") print("yes");
    if (map.isEmpty) {
      getRecipes();
    } else if (map['target'] == 'recipe') {
      getFinalRecipe();
    } else if (map['target'] == 'favorites') {
      getFavorites(map['id']);
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SpinKitRing(
            color: Colors.orange,
            size: 50.0,
          ),
        ));
  }
}
