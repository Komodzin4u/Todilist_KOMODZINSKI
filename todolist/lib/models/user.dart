import 'package:uuid/uuid.dart';

class User {
  final String id;
  final String name;
  final String email;

  User({
    String? id,
    required this.name,
    required this.email,
  }) : id = id ?? const Uuid().v4();

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email}';
  }
}
