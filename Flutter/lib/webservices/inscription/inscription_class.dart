class RequestInscription {
  final int id;
  final int requete;
  final int user;
  final bool accepted;

  RequestInscription({
    required this.id,
    required this.requete,
    required this.user,
    required this.accepted,
  });

  factory RequestInscription.fromJson(Map<String, dynamic> json) {
    return RequestInscription(
      id: json['id'] is int ? json['id'] : null,
      requete: json['requete'] is int ? json['requete'] : null,
      user: json['user'] is int ? json['user'] : null,
      accepted: json['accepted'] is bool ? json['accepted'] : null,
    );
  }

  // tojson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'requete': requete,
      'user': user,
      'accepted': accepted,
    };
  }
}