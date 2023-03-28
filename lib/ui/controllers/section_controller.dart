import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SectionController extends GetxController {
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
      }else{
        if(dir == 4){
        Get.toNamed('/sectionCreator', arguments: index);
        }
      }
      }
    }
  }
}
