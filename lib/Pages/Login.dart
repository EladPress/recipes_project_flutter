//import 'package:final_project_v0/Registration.dart';
import 'package:final_project_v0/Pages/Registration.dart';
import 'package:final_project_v0/UserForm.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  //const Login({ Key? key }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        title: Text('Login'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(24),
        child: UserForm(true),
      ),
        
      

      
    );
  }
}