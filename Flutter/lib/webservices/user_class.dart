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

  User({
    required this.id,
    required this.email,
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
      lastname: json['lastname'] is String ? json['lastname'] : null,
      firstname: json['firstname'] is String ? json['firstname'] : null,
      birthdate: json['birthdate'] is String ? json['birthdate'] : null,
      validated: json['validated'] is int ? json['validated'] : null,
      note: json['note'] is double ? json['note'] : null,
      profession: json['profession'] is int ? json['profession'] : null,
      role: json['role'] is int ? json['role'] : null,
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
      'role': role,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, lastname: $lastname, firstname: $firstname, profession: $profession, role: $role, validated: $validated}';
    //return 'User{email: $email, password: $password, firstname: $firstname, birthdate: $birthdate, validated: $validated, note: $note, profession: $profession, role: $role}';
  }
}
