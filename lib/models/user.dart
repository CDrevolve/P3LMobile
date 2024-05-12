import 'dart:convert';

class User {
  int? id;
  String? username;
  String? email;
  String? password;
  int? idRole;
  String? verifyKey;
  int? active;
  String? token;

  User({
    this.id,
    this.username,
    this.email,
    this.password,
    this.idRole,
    this.verifyKey,
    this.active,
    this.token,
  });

  factory User.fromRawJson(String str)=>User.fromRawJson(json.decode(str));

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      idRole: json['id_role'],
      verifyKey: json['verify_key'],
      active: json['active'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'username' : username,
      'email': email,
      'password': password,
      'id_role' :idRole,
      'verify_key' : verifyKey,
      'active' : active,
      'token' :token,
    };
  }

  String toRawJson() => json.encode(toJson());
}