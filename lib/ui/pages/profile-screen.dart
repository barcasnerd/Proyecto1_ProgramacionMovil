import 'package:exercise_tracker/ui/controllers/nav_controller.dart';
import 'package:exercise_tracker/ui/widgets/CustomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/user_controller.dart';
import 'package:flutter/foundation.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static NavController controllerNav = Get.put(NavController());
  static UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    double windowHeight = MediaQuery.of(context).size.height;
    double windowWidth = MediaQuery.of(context).size.width;
    ImageProvider<Object> customImage = kIsWeb == false
        ? NetworkImage(userController.currentUser.value.profileImageUrl)
        : AssetImage('assets/images/profile_pic.png') as ImageProvider<Object>;
    return Obx(() => Scaffold(
          body: ListView(children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text('Profile',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: windowHeight * 0.04))),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      SizedBox.fromSize(
                          size: Size.fromRadius(46),
                          child: ColorFiltered(
                            colorFilter: const ColorFilter.mode(
                              Color.fromRGBO(250, 250, 250, 0),
                              BlendMode.saturation,
                            ),
                            child: Image(
                              //fit: BoxFit.cover,
                              image: customImage,
                              width: windowWidth * 0.2,
                            ),
                          )),
                      SizedBox(width: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userController.currentUser.value.firstName +
                                " " +
                                userController.currentUser.value.lastName,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 22.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'lose a fat program',
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Poppins',
                                fontSize: 18.0,
                                fontWeight: FontWeight.w200),
                          ),
                        ],
                      ),
                      Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xff97d1fc), Color(0xff09fba5)],
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          child: Text(
                            'Edit',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _InfoCard(
                          topText:
                              "${userController.currentUser.value.height} cm",
                          bottomText: 'Height'),
                      _InfoCard(
                          topText:
                              "${userController.currentUser.value.weight} kg",
                          bottomText: 'Weight'),
                      _InfoCard(
                          topText:
                              "${DateTime.now().year - userController.currentUser.value.dateOfBirth.year} yo",
                          bottomText: 'Age'),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _InfoCard(
                          topText: '18Km/h', bottomText: 'Avg. running speed'),
                      _InfoCard(
                          topText: '28Km/h', bottomText: 'Avg. riding speed'),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _InfoCard(
                          topText: '18Km/h', bottomText: 'Max running speed'),
                      _InfoCard(
                          topText: '42Km/h', bottomText: 'Max riding speed'),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _InfoCard(
                          topText: '1.2 Hours',
                          bottomText: 'Avg. running time'),
                      _InfoCard(
                          topText: '3.7 Hours', bottomText: 'Avg. riding time'),
                    ],
                  ),
                  SizedBox(height: 40.0),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    child: Text(
                      'Delete Account',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                ],
              ),
            ),
          ]),
          bottomNavigationBar: CustomNavBar(controller: controllerNav),
        ));
  }
}

class _InfoCard extends StatelessWidget {
  final String topText;
  final String bottomText;

  const _InfoCard({required this.topText, required this.bottomText});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              topText,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..shader = LinearGradient(
                    colors: [Color(0xff97d1fc), Color(0xff09fba5)],
                  ).createShader(Rect.fromLTWH(0, 0, 200, 70)),
              ),
            ),
            SizedBox(height: 5),
            Text(
              bottomText,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
