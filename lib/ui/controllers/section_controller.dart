import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SectionController extends GetxController {
  Rx<List<LatLng>> coordinatesList = Rx<List<LatLng>>([]);

  void addCoordinate(LatLng coordinate) {
    if (coordinatesList.value.length >= 4) {
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

  final List<String> sections = [
    "Buenavista",
    "Mi Casa",
    "Puente Pumarejo",
    "Adelita",
    "La 30",
    "Circunvalar",
    "Corredor",
    "im",
    "done",
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
