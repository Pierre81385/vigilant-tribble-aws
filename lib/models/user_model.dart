class User {
  late String id;
  late String firstName;
  late String lastName;
  late String email;
  late String password;
  late String type;

  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      required this.type});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'type': type,
    };
  }

  factory User.fromJson(Map<String, dynamic> user) {
    return User(
        id: user["_id"],
        firstName: user['firstName'],
        lastName: user["lastName"],
        email: user["email"],
        password: user["password"],
        type: user["type"]);
  }
}
