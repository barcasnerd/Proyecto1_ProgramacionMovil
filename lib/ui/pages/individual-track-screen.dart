import 'package:flutter/material.dart';



class IndividualTrackScreen extends StatelessWidget {
  const IndividualTrackScreen({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('4 de Marzo Del 2023'),
      ),
      body: Center(
        child:Image.network('https://cdn.discordapp.com/attachments/778729768828141618/1085105723660316692/mapa_widget.jpg'),
        //child:nombre(),
      ),
        
    );
  }
}

//Widget nombre(){
 // return Text("00:22:45", style: TextStyle(color: Colors.black, fontSize: 15.0) )
//}


