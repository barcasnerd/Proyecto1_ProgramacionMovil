import 'package:get/get.dart';

class historyController extends GetxController {
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

  final List<String> duration =
      ["142", "76", "289", "427", "623", "71", "91", "182", "38", "126"].obs;

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

  void changePage() {
    //Get.toNamed('route': '/individualTrack', 'page': const IndividualTrackScreen());
    Get.toNamed('/individualTrack');
  }
}
