class User {
  int userId;
  String username;
  String email;

  User({
    required this.userId,
    required this.username,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json['userId'],
        username: json['username'],
        email: json['email'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['userId'] = userId;
    data['username'] = username;
    data['email'] = email;
    return data;
  }
}
