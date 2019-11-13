import 'dart:convert';

import 'package:http/http.dart' as http;

class User {
  final String userId;
  final String name;
  final List history;
  final List review;



  User({this.userId, this.name, this.history, this.review,});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json["userId"],
      name: json["name"],
      history: json["history"],
      review: json["review"]
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

  static Future<User> postUser() async {
    final String url = "http://localhost:3000/user";
    final response = await http.post(url);

    if ( response.statusCode == 200 ) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load User");
    }
  }  


}