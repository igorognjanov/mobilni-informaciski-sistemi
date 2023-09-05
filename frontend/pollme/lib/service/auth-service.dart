import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pollme/model/request/login-request.dart';
import 'package:pollme/model/request/user-request.dart';
import 'package:pollme/service/shared-prefences.dart';

String path = 'http://10.0.2.2:8080/api/auth';

Future<void> register(
    String email, String password, String confirmPassword) async {
  var url = Uri.parse('$path/register');
  var response = await http.post(url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(UserRequest(
          email: email, password: password, confirmPassword: confirmPassword)));

  if (response.statusCode == 200) {
    print('Response data: ${response.body}');
  }
}

Future<bool> login(String email, String password) async {
  saveToken('');
  var url = Uri.parse('$path/login');
  var response = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(LoginRequest(username: email, password: password)));
  if (response.statusCode == 200) {
    print('Login data: ${response.body}');
    await saveToken(response.body);
    return Future(() => true);
  }
  return Future(() => false);
}
