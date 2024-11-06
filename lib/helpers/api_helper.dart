import 'dart:convert';
import 'package:daelim_project/config.dart';

class ApiHelper {
  void signIn({required String email, required String password}) async {
    final loginData = {
      'email': email,
      'password': password,
    };

    final response = await http.post(
      Uri.parse(getTokenUrl),
      body: jsonEncode(loginData),
    );

    final statusCode = response.statusCode;
    final body = utf8.decode(response.bodyBytes);
  }
}
