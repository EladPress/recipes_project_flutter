import 'package:final_project_v0/UserForm.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Registration extends StatefulWidget {
  //const Registration({ Key? key }) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  late String firstName;
  late String lastName;
  late String password;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        foregroundColor: Colors.white,
        title: Text("Register"),
      ),
      body: Container(
        margin: EdgeInsets.all(24),
        child: UserForm(false)
      ),
    );
  }
}
