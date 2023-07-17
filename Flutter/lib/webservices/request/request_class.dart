class Request{
  final int? id;
  final String? title;
  final String? timer;
  final int? client;
  final int? type;
  final int? slots;
  final int? accepted;
  final int? done;

  Request({
    this.id,
    required this.title,
    required this.timer,
    required this.client,
    required this.type,
    required this.slots,
    this.accepted,
    this.done,
  });

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      id: json['id'] is int ? json['id'] : null,
      title: json['title'] is String ? json['title'] : null,
      timer: json['timer'] is String ? json['timer'] : null,
      client: json['client'] is int ? json['client'] : null,
      type: json['type'] is int ? json['type'] : null,
      slots: json['slots'] is int ? json['slots'] : null,
      accepted: json['accepted'] is int ? json['accepted'] : null,
      done: json['done'] is int ? json['done'] : null,
    );
  }

  // tojson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'timer': timer,
      'client': client,
      'type': type,
      'slots': slots,
      'accepted': accepted,
      'done': done,
    };
  }

  @override
  String toString() {
    return 'Request{id: $id, title: $title, timer: $timer, client: $client, type: $type, slots: $slots, accepted: $accepted, done: $done}';
  }
}