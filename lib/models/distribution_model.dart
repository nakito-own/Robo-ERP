import 'robot_model.dart';

class Distribution {
  final int id;
  final String? storage;
  final String? coordinates;
  final String? location;
  final String? client;
  final String? hub;
  final int? minRobots;
  final int? maxRobots;
  final int? robotCount;
  final List<Robot> robots;

  Distribution({
    required this.id,
    this.storage,
    this.coordinates,
    this.location,
    this.client,
    this.hub,
    this.minRobots,
    this.maxRobots,
    required this.robotCount,
    required this.robots,
  });

  factory Distribution.fromJson(Map<String, dynamic> json) {
    return Distribution(
      id: json['id'],
      storage: json['storage'] as String?,
      coordinates: json['coordinates'] as String?,
      location: json['location'] as String?,
      client: json['client'] as String?,
      hub: json['hub'] as String?,
      minRobots: json['min_robots'] as int?,
      maxRobots: json['max_robots'] as int?,
      robotCount: json['robot_count'] as int,
      robots: (json['robots'] as List)
          .map((robotJson) => Robot.fromJson(robotJson))
          .toList(),
    );
  }
}
