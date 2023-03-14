import 'package:exercise_tracker/ui/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  static RegisterController controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50.0),
              const Text(
                'Regístrate',
                style: TextStyle(
                  fontSize: 44.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 18.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nombre de usuario',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 18.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nombre completo',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 18.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 18.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 18.0),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: null,
                      onChanged: null,
                      items: const [
                        DropdownMenuItem(
                          value: 'M',
                          child: Text('Masculino'),
                        ),
                        DropdownMenuItem(
                          value: 'F',
                          child: Text('Femenino'),
                        ),
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Género',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Fecha de nacimiento',
                        border: OutlineInputBorder(),
                      ),
                      onTap: () async {
                        DateTime? selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                      },
                    ),
                  ),
                ],
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
                    'Registrarse',
                    style: TextStyle(color: Color.fromARGB(170, 0, 0, 0)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
