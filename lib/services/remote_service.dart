import 'dart:convert';

import 'package:connect_api/models/user.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  var client = http.Client();
  final token =
      'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYXBpL3VzZXIvbG9naW4iLCJpYXQiOjE3MDUzMDcyNTYsImV4cCI6MTcwNTMxMDg1NiwibmJmIjoxNzA1MzA3MjU2LCJqdGkiOiJvMVdhRzlndkNGckEwSm5lIiwic3ViIjoiMSIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.XOHFYsyQMA1-Gv9ysh7qq8Z8i5RYIFFuEkyfNg3LY7Q';

  Future<UserModel?> getUserModel() async {
    final url = Uri.parse('http://10.0.2.2:8000/api/user/profile');
    var response = await client.get(
      url,
      headers: {'Content-Type': 'application/json', 'Authorization': token},
    );
    if (response.statusCode == 200) {
      var json = response.body;
      return userModelFromJson(json);
    }
    return null;
  }

  Future<LoginData?> login(email, password) async {
    final url = Uri.parse('http://10.0.2.2:8000/api/user/login');
    var response = await client.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          'email': email,
          'password': password,
        },
      ),
    );
    // print(response.body);
    if (response.statusCode == 200) {
      var data = response.body;
      return loginDataFromJson(data);
    }
    return null;
  }
}
