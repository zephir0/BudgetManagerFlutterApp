import 'budget.dart';

class User {
  late String login;
  late String password;
  late String role;

  User(this.login, this.password, this.role);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(json['login'], json['password'], json['role']);
  }
}
