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
                onPressed: () => {mostrarAlertaEliminar(context, '00:22:45', '6 KM')},
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










void mostrarAlertaEliminar(BuildContext context, String tiempo, String distancia) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomAlertDialog(tiempo: tiempo, distancia: distancia);
    },
  );
}

class CustomAlertDialog extends StatelessWidget {
  final String tiempo;
  final String distancia;

  CustomAlertDialog({required this.tiempo, required this.distancia});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Eliminar registro'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(tiempo, style: TextStyle(fontSize: 20)),
              SizedBox(width: 30),
              Text(distancia, style: TextStyle(fontSize: 20)),
            ],
          ),
          SizedBox(height: 7),
          Row(
            children: [
              Text('Tiempo', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(width: 50),
              Text('Distancia', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Eliminar'),
          onPressed: () {
            // Aquí puedes agregar la lógica para eliminar el registro
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}






