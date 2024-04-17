import "package:http/http.dart" as http;

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

Future<List<User>> getUsers() async {
  List<User> users = [];

  http.Response response =
      await http.get(Uri.parse("https://reqres.in/api/users?page=1"));

  if (response.statusCode == 200) {}

  return users;
}
