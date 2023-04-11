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
      this.acummulatedElapsedTime);
}

class TrayectoryMetadata {
  User user;
  List<TrayectoryPoint> points;

  TrayectoryMetadata(this.user, this.points);
}
