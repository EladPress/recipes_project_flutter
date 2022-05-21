import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Methods {
  static Future<http.Response> flaskRequest(String url) async {
    http.Response response =
        await http.get(Uri.http('192.168.0.8:8081', url, {'q': '{http}'}));
    return response;
  }
}
