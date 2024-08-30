class Robot {
  final int id;
  final String name;
  String storage;
  final String generation;
  bool blockers;
  bool delivery;

  Robot({
    required this.id,
    required this.name,
    required this.storage,
    required this.generation,
    required this.blockers,
    required this.delivery,
  });

  Robot copyWith({
    int? id,
    String? name,
    String? storage,
    String? generation,
    bool? blockers,
    bool? delivery,
  }) {
    return Robot(
      id: id ?? this.id,
      name: name ?? this.name,
      storage: storage ?? this.storage,
      generation: generation ?? this.generation,
      blockers: blockers ?? this.blockers,
      delivery: delivery ?? this.delivery,
    );
  }

  factory Robot.fromJson(Map<String, dynamic> json) {
    return Robot(
      id: json['id'],
      name: json['name'],
      storage: json['storage'],
      generation: json['generation'],
      blockers: json['blockers'],
      delivery: json['delivery'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'storage': storage,
      'generation': generation,
      'blockers': blockers,
      'delivery': delivery,
    };
  }
}
