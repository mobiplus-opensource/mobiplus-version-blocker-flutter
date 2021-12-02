import 'package:flutter/material.dart';

class BlockScreen extends StatefulWidget {
  BlockScreen({Key? key}) : super(key: key);

  @override
  State<BlockScreen> createState() {
    return BlockScreenStates();
  }
}

class BlockScreenStates extends State<BlockScreen> {
  String titleText = "Tá na hora de atualizar seu aplicativo";
  final String middleText =
      "Fizemos algumas atualizações desde a ultima vez por aqui";
  final String bottomText = "Clica aí no botão para baixar a nova versão";
  final String buttonText = "ATUALIZAR";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text(
                titleText,
                style: TextStyle(fontSize: 20),
              ),
              Text(
                middleText,
                style: TextStyle(fontSize: 20),
              ),
              Text(
                bottomText,
                style: TextStyle(fontSize: 20),
              ),
              TextButton(
                onPressed: () {},
                child: Text(buttonText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
