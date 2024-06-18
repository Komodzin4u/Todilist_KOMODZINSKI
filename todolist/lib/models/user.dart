import 'package:uuid/uuid.dart';

class User {
  final String id;
  final String firstname;
  final String lastname;
  final String email;
  final String password;
  final List<String> tasks;

  User({
    String? id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
    this.tasks = const [],
  }) : id = id ?? Uuid().v4();

  @override
  String toString() {
    return 'User(id: $id, firstname: $firstname, lastname: $lastname, email: $email)';
  }
}
