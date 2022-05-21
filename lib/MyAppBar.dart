import 'package:flutter/material.dart';

class MyAppBar extends AppBar {
  MyAppBar({Key? key}) : super(key: key);

  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.orange,
      centerTitle: true,
      foregroundColor: Colors.white,
      //title: Text("Register"),
    );
  }
}
