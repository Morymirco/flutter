import "dart:convert";

import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";

class User {
  int id;
  String firstName;
  String lastName;
  String email;
  String image;

  User(
      {required this.email,
      required this.id,
      required this.firstName,
      required this.lastName,
      required this.image});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        email: json['email'],
        firstName: json['first_name'],
        image: json['avatar'],
        lastName: json['last_name']);
  }
}

Future<List<User>> getUsers(
    {int page = 1,
    required PagingController<int, User> pagingController}) async {
  List<User> users = [];

  http.Response response = await http
      .get(Uri.parse("https://reqres.in/api/users?$page&per_page=10"));

  if (response.statusCode == 200) {
    dynamic data = jsonDecode(response.body);

    List newData = data["data"];

    newData.forEach((element) {
      users.add(User.fromJson(element));
    });

    if (users.length < 4) {
      pagingController.appendLastPage(users);
    } else {
      final nextPageKey = page + 1;
      pagingController.appendPage(users, nextPageKey);
    }
  }

  return users;
}
