import 'dart:convert';

class UserModel {
  final int id;
  final String username;
  final String firstName;
  final String lastName;

  UserModel({required this.id, required this.username, required this.firstName, required this.lastName});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'username': username, 'firstName': firstName, 'lastName': lastName};
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int,
      username: map['username'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
    );
  }

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
