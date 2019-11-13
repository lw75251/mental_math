import 'dart:convert';

import 'package:http/http.dart' as http;

class User {
  final String userId;
  final String email;
  final String name;
  final List history;
  final List review;



  User({this.userId, this.email, this.name, this.history, this.review,});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json["_id"],
      email: json["email"],
      name: json["name"],
      // history: json["history"],
      // review: json["review"]
    );
  }

  static Future<User> fetchUser() async {
    final String url = "http://localhost:3000/user";
    final response = await http.get(url);

    if ( response.statusCode == 200 ) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load User");
    }
  }

  static Future<User> postUser(String email, String password) async {
    final String url = "http://10.0.2.2:3000/user";


    Map data = {
      "email": email,
      "password": password,
      "name": "Alucard"
    };

    final body = json.encode(data);

    final response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: body
    );

    if ( response.statusCode == 200 ) {
      print("made user");
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load User");
    }
  }  


}