import 'dart:developer';
import 'package:exercise_tracker/models/trayectory_point.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class HistoryController extends GetxController {
  List<List<LatLng>> historial = [];
  List<LatLng>? test = [];
  void initHistory() {
    if (historial.length == 0) {
      historial.add([
        LatLng(10.990274961102779, -74.85150642693043),
        LatLng(10.99206738137508, -74.85141288489103),
        LatLng(10.993063311986464, -74.85069505870342),
        LatLng(10.993338788564511, -74.84994605183601),
        LatLng(10.993982224491754, -74.84930600970984),
        LatLng(10.993936476408244, -74.8490096256137),
        LatLng(10.993446082837105, -74.84863512217999),
        LatLng(10.991745826061036, -74.84855700284243)
      ]);

      historial.add([
        LatLng(10.990004418573344, -74.84689671546221),
        LatLng(10.990012317628816, -74.84646756201982),
        LatLng(10.99129130357091, -74.84508655965328),
        LatLng(10.992424810923847, -74.84518010169268),
        LatLng(10.992685477503999, -74.8452427983284),
        LatLng(10.99239420233305, -74.84683435410261),
        LatLng(10.990035027412109, -74.8464910313487),
        LatLng(10.991283733675584, -74.84503995627165)
      ]);

      historial.add([
        LatLng(10.98926618508074, -74.84971370548011),
        LatLng(10.99150260231019, -74.85000237822533),
        LatLng(10.992812519465877, -74.85029105097055),
        LatLng(10.993693254463802, -74.84887082129717),
        LatLng(10.991832056896124, -74.84855096787214),
        LatLng(10.99219211972905, -74.84728697687389),
        LatLng(10.992559751985269, -74.84518010169268),
        LatLng(10.990200578388276, -74.8450319096446)
      ]);
      historial.add([
        LatLng(10.990092953807979, -74.8468266427517),
        LatLng(10.992069027000154, -74.84728697687389),
        LatLng(10.992138143244622, -74.84684240072966),
        LatLng(10.99020024926117, -74.84639748930931),
        LatLng(10.990728826905766, -74.84493836760521),
        LatLng(10.992161181989188, -74.84515696763992),
        LatLng(10.99216875186201, -74.84522704035044),
        LatLng(10.992161181989188, -74.84525050967932)
      ]);
      historial.add([
        LatLng(10.994178052538816, -74.85481359064579),
        LatLng(10.994070758532498, -74.8534245416522),
        LatLng(10.992952397210349, -74.85364314168693),
        LatLng(10.991359103494405, -74.85434520989656),
        LatLng(10.991053016337549, -74.85387716442347),
        LatLng(10.991359103494405, -74.85236339271069),
        LatLng(10.993258811519963, -74.84986659139395),
        LatLng(10.99410136694932, -74.84729167073965)
      ]);
      historial.add([
        LatLng(10.998355576857113, -74.84623052179813),
        LatLng(10.996318329422946, -74.84947632998228),
        LatLng(10.995583073822676, -74.84980423003435),
        LatLng(10.994311347185548, -74.84910182654858),
        LatLng(10.989608478146925, -74.84855566173793),
        LatLng(10.989822740239166, -74.84707307070494),
        LatLng(10.989853349096773, -74.8449507728219),
        LatLng(10.99254987825115, -74.8449507728219)
      ]);
    }
  }

  String formatDate(String dateString) {
    final months = [
      'Enero',
      'Febrero',
      'Marzo',
      'Abril',
      'Mayo',
      'Junio',
      'Julio',
      'Agosto',
      'Septiembre',
      'Octubre',
      'Noviembre',
      'Diciembre'
    ];

    final dateParts = dateString.split('-');
    final day = int.parse(dateParts[2]);
    final month = months[int.parse(dateParts[1]) - 1];
    final year = dateParts[0];

    return '$day de $month $year';
  }

  void addHistory(TrayectoryMetadata? route) {
    var abc = route?.points.length;

    for (int i = 0; i < abc!; i++) {
      LatLng? position = route?.points[i].position;
      if (position != null) {
        test!.add(position);
      }
    }
    historial.add(test!);
    String fecha = route?.points[abc - 1].timestamp.toString() ?? '';
    fecha = fecha.substring(0, 9);
    final formattedDate = formatDate(fecha);
    double? distancia = route?.points[abc - 1].acummulatedDistance;
    //int distanceint = distancia!.toInt() ?? 0;
    String tiempo =
        route?.points[abc - 1].acummulatedElapsedTime.toString() ?? '';
    //items.add(fecha);

    items.add(formattedDate);

    if (distancia != null) {
      distance.add(distancia.toPrecision(1));
    }

    duration.add(tiempo);
    type.add(true);
  }

  final RxList<String> items = [
    "1 de marzo 2023",
    "3 de marzo 2023",
    "7 de marzo 2023",
    "10 de marzo 2023",
    "12 de marzo 2023",
    "15 de marzo 2023"
  ].obs;
  final List<double> distance = [25.0, 83.0, 14.0, 69.0, 55.0, 42.0].obs;

  final List<String> duration = [
    "00:02:22",
    "00:01:16",
    "00:04:49",
    "00:07:07",
    "00:10:23",
    "00:01:11"
  ].obs;
  final List<bool> type = [true, false, false, true, true, false];

  void _setItems(List<String> value) {
    this.items.value = value;
  }

  void eliminarHistory(int index) {
    items.removeAt(index);
    distance.removeAt(index);
    duration.removeAt(index);
    Get.toNamed('/history');
  }

  void changePage(int index, int dir) {
    //Get.toNamed('route': '/individualTrack', 'page': const IndividualTrackScreen());
    if (dir == 1) {
      Get.toNamed('/individualTrack', arguments: index);
    } else {
      if (dir == 2) {
        Get.toNamed('/sections');
      } else {
        if (dir == 3) {
          Get.toNamed('/individualSection', arguments: index);
        } else {
          Get.toNamed('/sectionCreator');
        }
      }
    }
  }

  void changePageSections() {
    Get.toNamed('/sections');
  }

  RxList<String> getActivities() {
    return items;
  }

  List<String> getDuration() {
    return duration;
  }

  List<double> getDistance() {
    return distance;
  }

  List<bool> getType() {
    return type;
  }
}
