import 'package:exercise_tracker/models/user_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserController extends GetxController {
  List<User> users = [
    User("Admin", "Barcasnegras", "admin@admin.com", "admin", "Male",
        DateTime(2000, 8, 10), 70.0, 175)
  ];

  var currentUser = User("", "", "", "", "", DateTime(2000), 1.0, 1.0).obs;

  User? getUserByEmailAndPassword(String email, String password) {
    for (var user in users) {
      if (user.email == email && user.password == password) {
        return user;
      }
    }
    return null;
  }

  User? getUserByEmail(String email) {
    for (var user in users) {
      if (user.email == email) {
        return user;
      }
    }
    return null;
  }

  void addUser(User user) {
    fetchNameFromUrl(
            'https://this-person-does-not-exist.com/en?new=1679983211425&gender=all&age=all&etnic=all')
        .then((result) {
      user.profileImageUrl = result;
    }).catchError((e) => print(e));
    print(user.profileImageUrl);
    users.add(user);
  }

  Future<String> fetchNameFromUrl(String url) async {
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var name = data['name'];
      return 'https://this-person-does-not-exist.com/img/$name';
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
