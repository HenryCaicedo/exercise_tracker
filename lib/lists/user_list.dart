import 'package:flutter/material.dart';

class User {
  final String username;
  final String password;
  final String email;
  final String name;
  final int id;

  User({
    required this.username,
    required this.password,
    required this.email,
    required this.name,
    required this.id,
  });
}

List<User> users = [
  User(
      username: 'johndoe',
      password: '1234',
      email: 'johndoe@example.com',
      name: 'John Doe',
      id: 1),
  User(
      username: 'janesmith',
      password: '5678',
      email: 'janesmith@example.com',
      name: 'Jane Smith',
      id: 2),
  User(
      username: '',
      password: '',
      email: 'janesmith@example.com',
      name: 'Jane Smith',
      id: 2),
];

void addUser(User user) {
  users.add(user);
}
