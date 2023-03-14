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
          
          SizedBox(height: 10),
          Text(
            _bio,
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue,
              
            ),
          )
          
          SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  'https://randomuser.me/api/portraits/men/1.jpg',
                ),
                ),
          ),
          



          SizedBox(height: 20),
          Text(
            _username,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
         
      
      Padding(
      padding:EdgeInsets.only(top:50)
      child:Container(
      width: 400,
      height: 200,
      color: Colors.cyan,
      padding: EdgeInsets.all(20),
      child: Text(
        'Recorrido total: 863km/n'
        'tiempo de ruta total: 18 horas/n'
        'tiempo en a pie total: 40 horas 15 minutos /n'
        'velocidad promedio de ruta:32km/h /n'
        'velocidad promedio a pie: 14km/h /n',
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    )
    )
  
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
