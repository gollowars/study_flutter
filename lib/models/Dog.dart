import 'package:intl/intl.dart';

class Dog {
  int? id;
  final String name;
  final int age;
  late final DateTime createdAt;
  late final DateTime editedAt;

  Dog({
    this.id,
    required this.name,
    required this.age,
    DateTime? created,
    DateTime? edited,
  }) {
    createdAt = created ?? DateTime.now();
    editedAt = edited ?? DateTime.now();
  }

  String get createdAtStr {
    return DateFormat('yyyy/MM/dd HH:mm:ss', 'ja_JP').format(createdAt);
  }

  String get editedAtStr {
    return DateFormat('yyyy/MM/dd HH:mm:ss', 'ja_JP').format(createdAt);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'created_at': createdAt.toUtc().toIso8601String(),
      'edited_at': editedAt.toUtc().toIso8601String(),
    };
  }

  static Dog fromMap(Map<String, dynamic> json) {
    return Dog(
        id: json['id'],
        name: json['name'],
        age: json['age'],
        created: DateTime.parse(json['created_at']).toLocal(),
        edited: DateTime.parse(json['edited_at']).toLocal());
  }

  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}
