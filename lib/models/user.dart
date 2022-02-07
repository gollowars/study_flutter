class UserResponse {
  final String message;
  final List<User> users;
  final int total;

  UserResponse(
      {required this.message, required this.users, required this.total});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    final message = json['message'];
    final total = json['total'];

    final List<Map<String, dynamic>> usersjson = json['users'];

    const List<User> users = [];
    for (var element in usersjson) {
      users.add(User.fromJson(element));
    }

    return UserResponse(message: message, users: users, total: total);
  }
}

class User {
  final String userId;
  final String firstname;
  final String lastname;
  final List<Map<String, String>> friends;

  User(
      {required this.userId,
      required this.firstname,
      required this.lastname,
      required this.friends});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      friends: json['friends'],
    );
  }
}
