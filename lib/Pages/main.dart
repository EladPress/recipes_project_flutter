import 'package:final_project_v0/Pages/AddRecipe.dart';
import 'package:final_project_v0/Pages/Favorites.dart';
import 'package:final_project_v0/Pages/Home.dart';
import 'package:final_project_v0/Pages/Loading.dart';
import 'package:final_project_v0/Pages/Login.dart';
import 'package:final_project_v0/Pages/Recipe.dart';
import 'package:final_project_v0/Pages/Registration.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      initialRoute: 'Loading',
      routes: {
        'Registration': (context) => Registration(),
        'Login': (context) => Login(),
        'Home': (context) => Home(),
        'Loading': (context) => Loading(),
        'Recipe': (context) => Recipe(),
        'AddRecipe': (context) => AddRecipe(),
        'Favorites': (context) => Favorites(),
      },
      theme: ThemeData(
          primarySwatch: Colors.orange,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            primary: Colors.grey[400],
            onPrimary: Colors.black,
          )))));
}
