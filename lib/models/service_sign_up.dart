import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import '../constants/routes.dart';

class Auth with ChangeNotifier {

  Future<void> createUser(String email, String firstName,
      String password) async {
    var url = Uri.parse(Routes.urlSignUp);
    final response = await http.put(url, body: json.encode({
    'userEmail': email,
    'userFirstName': firstName,
    'password': password,
    }));
    print('post ist done');
    print(json.decode(response.body));
  }
}