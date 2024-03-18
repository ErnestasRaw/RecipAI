class User {
  int userId;
  String name;
  String surname;
  String username;
  String email;

  User({
    required this.userId,
    required this.name,
    required this.surname,
    required this.username,
    required this.email,
  });

  String get fullName => '$name $surname';

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json['userId'],
        name: json['name'],
        surname: json['surname'],
        username: json['username'],
        email: json['email'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['userId'] = userId;
    data['name'] = name;
    data['surname'] = surname;
    data['username'] = username;
    data['email'] = email;
    return data;
  }
}
