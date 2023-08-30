class Types {
  final int? id;
  final String name;

  Types({
    this.id,
    required this.name,
  });

  factory Types.fromJson(Map<String, dynamic> json) {
    return Types(
      id: json['id'] is int ? json['id'] : -1,
      name: json['name'] is String ? json['name'] : '',
    );
  }

  // tojson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() {
    return 'Types{id: $id, name: $name}';
  }
}