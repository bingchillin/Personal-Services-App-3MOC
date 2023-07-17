class User {
  final int? id;
  final String? email;
  final String? lastname;
  final String? firstname;
  final String? birthdate;
  final int? validated;
  final double? note;
  final int? profession;
  final int? role;
  final String? dateSignIn;
  final String? password;

  User({
    this.id,
    required this.email,
    this.lastname,
    this.firstname,
    this.birthdate,
    this.validated,
    this.note,
    this.profession,
    this.dateSignIn,
    this.role,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] is int ? json['id'] : null,
      email: json['email'] is String ? json['email'] : null,
      lastname: json['lastname'] is String ? json['lastname'] : null,
      firstname: json['firstname'] is String ? json['firstname'] : null,
      birthdate: json['birthdate'] is String ? json['birthdate'] : null,
      validated: json['validated'] is int ? json['validated'] : null,
      note: json['note'] is double ? json['note'] : null,
      profession: json['profession'] is int ? json['profession'] : null,
      dateSignIn: json['dateSignIn'] is String ? json['dateSignIn'] : null,
      role: json['role'] is int ? json['role'] : null,
      password: json['password'] is String ? json['password'] : null,
    );
  }

  // tojson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'lastname': lastname,
      'firstname': firstname,
      'birthdate': birthdate,
      'validated': validated,
      'note': note,
      'profession': profession,
      'dateSignIn' : dateSignIn,
      'role': role,
      'password':password
    };
  }

  factory User.loginUser({
    required String email,
    required String password,
  }) {
    return User(
      email: email,
      password: password,
    );
  }

  @override
  String toString() {
    return 'User{id: $id, lastname: $lastname, firstname: $firstname, profession: $profession, role: $role, validated: $validated}';
    //return 'User{email: $email, password: $password, firstname: $firstname, birthdate: $birthdate, validated: $validated, note: $note, profession: $profession, role: $role}';
  }
}
