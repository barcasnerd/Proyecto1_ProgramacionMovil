/*import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfileScreen'),
      ),
      body: Center(
        child: Text("ProfileScreen"),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _username = 'Perfil';
  String _bio = 'Augusto';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profilescreen'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => _editProfile(context),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Text(
            _username,
            style: TextStyle(
              fontSize: 24,
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 40),
          Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/imagendeperfil.jpg'),
            ),
          ),
          SizedBox(height: 10),
          Text(
            _bio,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 60),
            child: Container(
              width: 500,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Recorrido total: 863km\n\n'
                  'Tiempo de ruta total: 18 horas\n\n'
                  'Tiempo en a pie total: 40 horas 15 minutos\n\n'
                  'Velocidad promedio de ruta: 32km/h\n\n'
                  'Velocidad promedio a pie: 14km/h\n\n',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),

                // Espacio entre el borde derecho y el botón
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => {},
            child: Padding(
              padding:
                  EdgeInsets.all(10), // Ajusta el relleno interno del botón
              child: Text(
                'Eliminar cuenta',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.red, // Cambia el color del botón a rojo
            ),
          ),
        ],
      ),
    );
  }

  void _editProfile(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Edit Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
                onChanged: (value) => _username = value,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'contraseña',
                ),
                onChanged: (value) => _bio = value,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'fecha de nacimiento',
                ),
                onChanged: (value) => _bio = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () => _saveProfile(context),
            ),
          ],
        );
      },
    );
  }

  void _saveProfile(BuildContext context) {
    // TODO: Implement logic to save profile changes
    Navigator.pop(context);
    setState(() {});
  }
}
