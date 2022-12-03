//TODO CLASS WITH BALANCES ETC, LIKE IN JAVA.
class User {
  late String login;
  late String password;

  User(
    this.login,
    this.password,
  );

  factory User.fromJson(Map<String, dynamic> json) {
    return User(json['login'], json['password']);
  }
}
