import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  final RxList<String> items = [
    "1 de marzo 2023",
    "3 de marzo 2023",
    "7 de marzo 2023",
    "10 de marzo 2023",
    "12 de marzo 2023",
    "15 de marzo 2023",
    "17 de marzo 2023",
    "28 de marzo 2023",
    "29 de marzo 2023",
    "30 de marzo 2023"
  ].obs;
  final List<String> distance =
      ["25", "83", "14", "69", "55", "42", "91", "18", "76", "29"].obs;

  final List<String> duration = [
    "00:02:22",
    "00:01:16",
    "00:04:49",
    "00:07:07",
    "00:10:23",
    "00:01:11",
    "00:01:31",
    "00:03:02",
    "00:00:38",
    "00:02:06"
  ].obs;
  final List<bool> type = [
    true,
    false,
    false,
    true,
    true,
    false,
    true,
    true,
    false,
    true
  ];

  void _setItems(List<String> value) {
    this.items.value = value;
  }

  void editarItem() {
    _setItems([
      "1 de test 2023",
      "3 de marzo 2023",
      "7 de marzo 2023",
      "10 de marzo 2023",
      "12 de marzo 2023",
      "15 de marzo 2023",
      "17 de marzo 2023",
      "28 de marzo 2023",
      "29 de marzo 2023",
      "30 de test 2023"
    ]);
  }

  var selectedItem = "Option 1".obs;
  final RxList<String> myList = ["Option 1", "Option 2", "Option 3", "xd"].obs;

  void setSelectedItem(String value) {
    log("Ejecuto ${value}");
    selectedItem.value = value;
    this.selectedItem.value = value;
    log("${selectedItem}");

    update();
  }

  void eliminarHistory(int index) {
    items.removeAt(index);
    distance.removeAt(index);
    duration.removeAt(index);
  }

  void changePage(int index) {
    //Get.toNamed('route': '/individualTrack', 'page': const IndividualTrackScreen());
    Get.toNamed('/individualTrack', arguments: index);
  }
}
