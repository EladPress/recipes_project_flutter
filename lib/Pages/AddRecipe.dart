import 'package:flutter/material.dart';
import 'package:final_project_v0/Methods.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({Key? key}) : super(key: key);

  @override
  _AddRecipeState createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String name, description, url;

  Widget buildField(String type) {
    return TextFormField(
      decoration: InputDecoration(labelText: type),
      validator: (value) {
        if (value == null || value.isEmpty) return type + ' required';
      },
      onSaved: (value) {
        /*if (type == 'name') name = value!;
        if(type )*/
        switch (type) {
          case 'name':
            {
              name = value!;
            }
            break;
          case 'description':
            {
              description = value!;
            }
            break;
          default:
            {
              url = value!;
            }
            break;
        }
        //firstName = value!;
      },
    );
  }

  String final_result = '';
  void Submit() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    String url1 = '/process_recipe2/' + url;
    var response = await Methods.flaskRequest(url1);
    var recipe = response.body;
    final url2 =
        '/insert_recipe/' + name + '/' + description + '/' + recipe + '/NULL';
    response = await Methods.flaskRequest(url2);
    setState(() {
      final_result = response.body;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pushNamed(context, 'Loading', arguments: {});
        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            title: Text('New Recipe'),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildField('name'),
                  buildField('description'),
                  buildField('URL'),
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
                      Submit();
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
