import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SectionController extends GetxController {
  var nameSection = "".obs;
  Rx<List<LatLng>> coordinatesList = Rx<List<LatLng>>([]);
  List<LatLng> segment1 = [];
  void addCoordinate(LatLng coordinate) {
    if (coordinatesList.value.length >= 5) {
      coordinatesList.update((list) {
        list!.removeAt(0);
        list.add(coordinate);
      });
    } else {
      coordinatesList.update((list) {
        list!.add(coordinate);
      });
    }
  }

  List<List<LatLng>> segments = [];
  void initSections() {
    if (segments.length == 0) {
      segments.add([
        LatLng(10.989556475956679, -74.84836120158434),
        LatLng(10.990023837084326, -74.84687089920044),
        LatLng(10.990644241381219, -74.84507616609335),
        LatLng(10.992451799141081, -74.84510734677315)
      ]);

      segments.add([
        LatLng(10.989530803985971, -74.848278388381),
        LatLng(10.990059382829939, -74.84688967466356),
        LatLng(10.990633709329774, -74.84516501426697),
        LatLng(10.989997836026959, -74.84462689608335)
      ]);

      segments.add([
        LatLng(10.990663330723507, -74.8499483987689),
        LatLng(10.991207047333605, -74.84995611011982),
        LatLng(10.992723655923154, -74.8500731214881),
        LatLng(10.993282837547973, -74.84944112598896)
      ]);
    }
  }

  void saveSegment(Rx<List<LatLng>> coordinates, var nameSection) {
    segment1 = coordinates.value;
    print("Segmento guardado ${segment1}");
    sections.add(nameSection.value);
    segments.add(segment1);
  }

  final List<String> sections = [
    "Buenavista",
    "Mi Casa",
    "Puente Pumarejo",
  ].obs;
  var selectedItem = "Buenavista".obs;
  List<String> getActivities() {
    return sections;
  }

  void setSelectedItem(String value) {
    log("Ejecuto ${value}");
    selectedItem.value = value;
    this.selectedItem.value = value;
    log("${selectedItem}");

    update();
  }

  void eliminarSection(int index) {
    sections.removeAt(index);
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
          if (dir == 4) {
            Get.toNamed('/sectionCreator', arguments: index);
          }
        }
      }
    }
  }
}
