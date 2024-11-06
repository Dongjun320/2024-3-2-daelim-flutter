class ApiHelper {
  void signIn({required String email, required String password}) async {
    final email = _emailController.text;
    final password = _pwController.text;

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
