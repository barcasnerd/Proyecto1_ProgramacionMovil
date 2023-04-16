import 'package:exercise_tracker/models/user_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrayectoryPoint {
  DateTime? timestamp;
  double? speedKmH;
  LatLng? position;
  double? distanceBetweenLastPosition;
  double? acummulatedDistance;
  String? acummulatedElapsedTime;

  TrayectoryPoint(
    this.timestamp,
    this.speedKmH,
    this.position,
    this.distanceBetweenLastPosition,
    this.acummulatedDistance,
    this.acummulatedElapsedTime,
  );

  Map<String, dynamic> toJson() => {
        'timestamp': timestamp?.toIso8601String(),
        'speedKmH': speedKmH,
        'position': position?.toJson(),
        'distanceBetweenLastPosition': distanceBetweenLastPosition,
        'acummulatedDistance': acummulatedDistance,
        'acummulatedElapsedTime': acummulatedElapsedTime,
      };

  factory TrayectoryPoint.fromJson(Map<String, dynamic> json) => TrayectoryPoint(
        json['timestamp'] == null ? null : DateTime.parse(json['timestamp']),
        json['speedKmH'],
        json['position'] == null ? null : LatLng.fromJson(json['position']),
        json['distanceBetweenLastPosition'],
        json['acummulatedDistance'],
        json['acummulatedElapsedTime'],
      );
}

class TrayectoryMetadata {
  User user;
  List<TrayectoryPoint> points;

  TrayectoryMetadata(this.user, this.points);

  Map<String, dynamic> toJson() => {
        'user': user.toJson(),
        'points': points.map((p) => p.toJson()).toList(),
      };

  factory TrayectoryMetadata.fromJson(Map<String, dynamic> json) => TrayectoryMetadata(
        User.fromJson(json['user']),
        (json['points'] as List<dynamic>)
            .map((p) => TrayectoryPoint.fromJson(p))
            .toList(),
      );
}
