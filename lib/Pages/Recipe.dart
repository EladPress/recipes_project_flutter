import 'dart:convert';

import 'package:final_project_v0/MyAppBar.dart';
import 'package:final_project_v0/Pages/Variables.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class Recipe extends StatefulWidget {
  const Recipe({Key? key}) : super(key: key);

  @override
  _RecipeState createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {
  final FlutterTts tts = FlutterTts();

  stt.SpeechToText speech = stt.SpeechToText();
  bool isListening = false;
  String text = 'Press the button and start speaking';
  double confidence = 1.0;

  late List recipe;

  int index = 0;
  int recipeLength = 0;
  String currentStep = '';

  @override
  void initState() {
    super.initState();
    //speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    recipe = ModalRoute.of(context)!.settings.arguments as List;
    tts.setLanguage('en');
    tts.setSpeechRate(0.4);
    recipeLength = recipe.length;
    currentStep = recipe[index];

    //print(recipe['id']);
    //print('recipe length = ' + recipeLength.toString());

    //String current = recipe[index];
    //print(name);

    //print(recipe);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        title: Text('recipe'),
      ),
      //body: Text(recipe.toString()),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(
            height: 100,
          ),
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      //recipe text
                      recipe[index],
                      textAlign: TextAlign.center,

                      style: TextStyle(
                          fontSize: 28,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                          height: 1.5),
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                FloatingActionButton(
                  //text to speech button
                  heroTag: 'output button',
                  onPressed: () {
                    tts.speak(recipe[index]);
                  },
                  child: Icon(Icons.volume_up),
                  foregroundColor: Colors.white,
                ),
                AvatarGlow(
                  animate: isListening,
                  glowColor: Theme.of(context).primaryColor,
                  endRadius: 75.0,
                  duration: const Duration(milliseconds: 2000),
                  repeatPauseDuration: const Duration(milliseconds: 100),
                  repeat: true,
                  child: FloatingActionButton(
                    //speech to text button
                    heroTag: 'mic button',
                    onPressed: () {
                      listen();
                      //constantListening();
                      print(isListening);
                    },
                    child: Icon(isListening ? Icons.mic : Icons.mic_none),
                    foregroundColor: Colors.white,
                  ),
                )
              ],
            ),
          ),
          //SizedBox(height: 100),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Visibility(
                  child: FloatingActionButton(
                    onPressed: () {
                      back();
                    },
                    child: Icon(Icons.chevron_left),
                    foregroundColor: Colors.white,
                    heroTag: null,
                  ),
                  visible: index > 0,
                  maintainState: true,
                  maintainSize: true,
                  maintainAnimation: true,
                ),
                //SizedBox(width: 260),
                Spacer(),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    (index + 1).toString(),
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Spacer(),
                Visibility(
                  child: FloatingActionButton(
                    onPressed: () {
                      next(recipe.length);
                    },
                    child: Icon(Icons.chevron_right),
                    foregroundColor: Colors.white,
                    heroTag: null,
                  ),
                  visible: index < recipeLength - 1,
                  maintainState: true,
                  maintainSize: true,
                  maintainAnimation: true,
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  void back() {
    if (index > 0) {
      setState(() {
        index--;
        //current = recipe[index];
        print(index);
      });
    }
  }

  void next(int length) {
    if (index < length - 1) {
      setState(() {
        index++;

        //current = recipe[index];
        print(index);
      });
    }
  }

  void constantListening() async {
    listen();
    while (true) {
      if (isListening == false) {
        listen();
      }
    }
  }

  void listen() async {
    if (!isListening) {
      bool available = await speech.initialize(
        onStatus: (val) {
          print('onStatus: $val');
          if (val == 'done') {
            setState(() {
              isListening = false;

              //listen();
            });
          }
        },
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => isListening = true);

        speech.listen(
          partialResults: false,
          onResult: (val) => setState(() {
            print(val.recognizedWords);
            //if (val.recognizedWords.contains('stop')) print('stop');
            if (val.recognizedWords.contains('next')) {
              next(recipeLength); ///////////////

            }
            print(val.recognizedWords);
            if (val.recognizedWords.contains('repeat')) {
              tts.speak(recipe[index]);
            }

            if (val.recognizedWords.contains('back')) back();
            text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              confidence = val.confidence;
            }
            listen();
            return;
            print('here2');
          }),
        );
        print('here1');
        //print('islistening:' + isListening.toString());
      }
    } else {
      setState(() => isListening = false);
      speech.stop();
    }
  }
}
