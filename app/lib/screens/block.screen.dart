import 'package:flutter/material.dart';

class BlockScreen extends StatefulWidget {
  const BlockScreen({Key? key}) : super(key: key);
  final String titleText = "Tá na hora de atualizar seu aplicativo";
  final String middleText = "Fizemos algumas atualizações desde a ultima vez por aqui";
  final String bottomText = "Clica aí no botão para baixar a nova versão";
  final String buttonText = "ATUALIZAR";

  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Scaffold(
        body: Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
