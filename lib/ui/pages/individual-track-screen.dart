import 'package:flutter/material.dart';

class IndividualTrackScreen extends StatelessWidget {
  const IndividualTrackScreen({super.key});
  

  @override
  Widget build(BuildContext context) {
    TextStyle qntStyle =TextStyle(color: Colors.black, fontSize: 24.0,fontWeight: FontWeight.bold);
     TextStyle titleStyle =TextStyle(color: Colors.black, fontSize: 15.0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('4 de Marzo Del 2023'),
      ),
      body: Center(
        child:Column(
          children: [
            Image.network('https://cdn.discordapp.com/attachments/778729768828141618/1085105723660316692/mapa_widget.jpg'),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column( 
                  children: [
                    Row(
                      children: [
                        Text("00:22:45", style: qntStyle ),SizedBox(width: 30,),Text("6 KM", style: qntStyle )
                      ],
                    ),SizedBox(height: 7),
                    Row(
                      children: [
                        Text("Tiempo", style: titleStyle ),SizedBox(width: 50,),Text("Distancia", style:titleStyle  )
                      ],
                    )
                  , ElevatedButton(
                onPressed: () => {Navigator.of(context).pushNamed("/delete")},
                child: const Text("Eliminar")),],
                ),
              ],
            )
          ],
        ),
      ),
        
    );
  }
}







