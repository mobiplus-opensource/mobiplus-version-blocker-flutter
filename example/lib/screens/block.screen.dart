// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:store_redirect/store_redirect.dart';

class BlockScreen extends StatefulWidget {
  const BlockScreen({Key? key}) : super(key: key);

  @override
  State<BlockScreen> createState() {
    return BlockScreenStates();
  }
}

class BlockScreenStates extends State<BlockScreen> {
  String titleText = 'Tá na hora de atualizar seu aplicativo';
  final String middleText = 'Fizemos algumas atualizações desde a última vez por aqui.';
  final String bottomText = 'Clica aí no botão para baixar a nova versão.';
  final String buttonText = 'ATUALIZAR';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 160),
                child: Text(
                  titleText,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                alignment: Alignment(0.0, 0.0),
              ),
              SizedBox(
                child: Image(
                  image: AssetImage('assets/images/update_icon.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30),
                child: Text(
                  middleText,
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 70, right: 70, top: 20),
                child: Text(
                  bottomText,
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ElevatedButtonTheme(
                  data: ElevatedButtonThemeData(
                      style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all<Size>(Size(320, 50)),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                          textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(fontSize: 20)))),
                  child: ElevatedButton(
                    onPressed: () {
                      StoreRedirect.redirect(androidAppId: "com.android.chrome", iOSAppId: "535886823");
                    },
                    child: Text(buttonText),
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
