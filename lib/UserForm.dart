import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Pages/Variables.dart';
import 'package:final_project_v0/Methods.dart';

class UserForm extends StatefulWidget {
  //const UserForm({Key? key}) : super(key: key);

  late final bool isRegistered;
  UserForm(this.isRegistered);

  @override
  _UserFormState createState() => _UserFormState(this.isRegistered);
}

class _UserFormState extends State<UserForm> {
  late String firstName;
  late String lastName;
  late String password;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final bool isRegistered;

  _UserFormState(this.isRegistered);

  Widget buildFName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'First name'),
      validator: (value) {
        if (value == null || value.isEmpty) return 'First name required';
      },
      onSaved: (value) {
        firstName = value!;
      },
    );
  }

  Widget buildLName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Last name'),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Last name required';
      },
      onSaved: (value) {
        lastName = value!;
      },
    );
  }

  Widget buildPassword() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Password'),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Password required';
      },
      onSaved: (value) {
        password = value!;
      },
    );
  }

  String final_result = '';

  void register() async {
    if (!formKey.currentState!.validate()) return;

    formKey.currentState!.save();
    //http://192.168.0.15:8081
    final url = "/insert_user/" + firstName + "/" + lastName + "/" + password;
    var response = await Methods.flaskRequest(url);

    setState(() {
      final_result = response.body;
    });
  }

  void login() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    var url = "/select_user/" + firstName + "/" + lastName + "/" + password;
    var response = await Methods.flaskRequest(url);
    print(response.body.runtimeType);
    try {
      user = json.decode(response.body)[0];
      //print(user);
    } on Exception catch (e) {}
    if (user.isNotEmpty) {
      url = '/select_favorites_id/' + user['id'].toString();
      response = await Methods.flaskRequest(url);
      user['favorites'] = json.decode(response.body) as List;
    }

    setState(() {
      if (user.isEmpty)
        final_result = 'User not found!';
      else
        final_result = 'Logged in!';
    });
    print(user);
  }

  @override
  Widget build(BuildContext context) {
    String location = ModalRoute.of(context)!.settings.name.toString();
    String submit_button = location == "Registration" ? "Submit" : "Login";
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildFName(),
          buildLName(),
          buildPassword(),
          //SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              final_result,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (this.isRegistered == false)
                register();
              else
                login();
            },
            child: Text(
              submit_button,
              
            ),
          ),
          Visibility(
            child: ElevatedButton(
              child: const Text('Not Registered? Click here!'),
              onPressed: () {
                Navigator.pushNamed(context, 'Registration');
              },
            ),
            visible: location == "Login" ? true : false,
          ),
          //Text(),
        ],
      ),
    );
  }
}
