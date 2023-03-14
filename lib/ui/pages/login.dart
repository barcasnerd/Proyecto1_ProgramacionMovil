// import 'package:exercise_tracker/ui/controllers/login_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});
//   static LoginController controller = Get.put(LoginController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [

//             const Text(
//               'Iniciar Sesión',
//               style: TextStyle(
//                 fontSize: 44.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 18.0),
//             const SizedBox(height: 4.0),
//             TextFormField(
//               decoration: const InputDecoration(
//                 labelText: 'Usuario',
//                 border: OutlineInputBorder(),
//               ),
//               keyboardType: TextInputType.emailAddress,
//             ),
//             const SizedBox(height: 18.0),
//             const SizedBox(height: 4.0),
//             TextFormField(
//               decoration: const InputDecoration(
//                 labelText: 'Contraseña',
//                 border: OutlineInputBorder(),
//               ),
//               obscureText: true,
//             ),
//             const SizedBox(height: 50.0),
//             SizedBox(
//               width: 250,
//               child: OutlinedButton(
//                 style: ButtonStyle(
//                   backgroundColor:
//                       MaterialStateProperty.all<Color>(Colors.grey),
//                 ),
//                 onPressed: () {
//                   controller.changePageHome();
//                 },
//                 child: const Text(
//                   'Iniciar sesión',
//                   style: TextStyle(color: Color.fromARGB(170, 0, 0, 0)),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 60.0,
//               child: Align(
//                 alignment: Alignment.bottomRight,
//                 child: TextButton(
//                   onPressed: () {
//                     controller.changePageRegister();
//                   },
//                   child: Text(
//                     'Regístrate',
//                     style: TextStyle(
//                       fontSize: 18.0,
//                       color: Colors.blue,
//                       decoration: TextDecoration.underline,
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:exercise_tracker/ui/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 150.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.accessibility_new,
                    size: 100.0,
                    color: Colors.black,
                  ),
                  Text(
                    'Fitness Tracker',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18.0),
            const SizedBox(height: 4.0),
            const Text(
              'Iniciar Sesión',
              style: TextStyle(
                fontSize: 44.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 18.0),
            const SizedBox(height: 4.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Usuario',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 18.0),
            const SizedBox(height: 4.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 50.0),
            SizedBox(
              width: 250,
              child: OutlinedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.grey),
                ),
                onPressed: () {
                  controller.changePageHome();
                },
                child: const Text(
                  'Iniciar sesión',
                  style: TextStyle(color: Color.fromARGB(170, 0, 0, 0)),
                ),
              ),
            ),
            SizedBox(
              height: 60.0,
              child: Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    controller.changePageRegister();
                  },
                  child: Text(
                    'Regístrate',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
