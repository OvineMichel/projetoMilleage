import 'package:flutter/material.dart';

class telaForm extends StatefulWidget {
  const new({super.key});

  @override
  State<telaForm> createState() => _telaFormState();
}

class _telaFormState extends State<telaForm> {
  @override
  final TextEditingController controllerDistancia = TextEditingController();
  final TextEditingController controllerPrecoComb = TextEditingController();
  final TextEditingController controllerConsumo = TextEditingController();
  final TextEditingController controllerVelMedia = TextEditingController();
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          foregroundColor: Colors.white,
          title: Text("Cálculo de Viagem"),
        ),
        body: Center(
          child: Column(
            spacing: 30,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("insira os dados abaixo, e selecione um cálculo nos botões abaixo",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blue,
                fontSize: 40,
                ),
                ),
              TextField(
                controller: controllerDistancia,
                decoration: InputDecoration(labelText: "Distância da viagem",constraints: BoxConstraints(maxWidth: 600))
              ),
               TextField(
                controller: controllerPrecoComb,
                decoration: InputDecoration(labelText: "Valor do Combustivel",constraints: BoxConstraints(maxWidth: 600))
              ),
               TextField(
                controller: controllerConsumo,
                decoration: InputDecoration(labelText: "Consumo do veículo Km/L",constraints: BoxConstraints(maxWidth: 600))
              ),
               TextField(
                controller: controllerVelMedia,
                decoration: InputDecoration(labelText: "Velocidade média",constraints: BoxConstraints(maxWidth: 600))
              )
              
            ],
          ),
        ),
        ),
    );
  }
}