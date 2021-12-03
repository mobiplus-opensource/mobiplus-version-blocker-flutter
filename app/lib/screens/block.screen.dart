import 'package:flutter/material.dart';

class BlockScreen extends StatefulWidget {
  BlockScreen({Key? key}) : super(key: key);

  @override
  State<BlockScreen> createState() {
    return BlockScreenStates();
  }
}

class BlockScreenStates extends State<BlockScreen> {
  String titleText = 'Tá na hora de atualizar seu aplicativo';
  final String middleText =
      'Fizemos algumas atualizações desde a ultima vez por aqui';
  final String bottomText = 'Clica aí no botão para baixar a nova versão';
  final String buttonText = 'ATUALIZAR';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(.0),
                margin: EdgeInsets.only(top: 90),
                child: Text(
                  titleText,  
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/cat.png'),
                    fit: BoxFit.fitWidth,
                    alignment: Alignment(0.0, -1.05),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  middleText,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  bottomText,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {},
                  child: Text(buttonText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
