class User {
  final int? id;
  final String? email;
  final String? password;
  final String? lastname;
  final String? firstname;
  final String? birthdate;
  final int? validated;
  final int? note;
  final int? profession;
  final int? role;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.lastname,
    required this.firstname,
    required this.birthdate,
    required this.validated,
    required this.note,
    required this.profession,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] is int ? json['id'] : null,
      email: json['email'] is String ? json['email'] : null,
      password: json['password'] is String ? json['password'] : null,
      lastname: json['lastname'] is String ? json['lastname'] : null,
      firstname: json['firstname'] is String ? json['firstname'] : null,
      birthdate: json['birthdate'] is String ? json['birthdate'] : null,
      validated: json['validated'] is int ? json['validated'] : null,
      note: json['note'] is int ? json['note'] : null,
      profession: json['profession'] is int ? json['profession'] : null,
      role: json['role'] is int ? json['role'] : null,
    );
  }

  @override
  String toString() {
    return 'User{id: $id, lastname: $lastname, firstname: $firstname, profession: $profession, role: $role, validated: $validated}';
    //return 'User{email: $email, password: $password, firstname: $firstname, birthdate: $birthdate, validated: $validated, note: $note, profession: $profession, role: $role}';
  }
}
