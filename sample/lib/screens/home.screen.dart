import 'package:flutter/material.dart';
import 'package:version_blocker_flutter/version_blocker_flutter.dart';
import 'block.screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initBlockVersion(context);
    return MaterialApp(
      home: Builder(builder: (context) {
        return Center(
          child: ElevatedButtonTheme(
            data: ElevatedButtonThemeData(
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(Size(320, 50)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                        TextStyle(fontSize: 20)))),
            child: ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BlockScreen()),
                );
              },
              child: Text('Me clique'),
            ),
          ),
        );
      }),
    );
  }

  void initBlockVersion(BuildContext context) async {
    final blockApp = BlockApp();
    blockApp.title();
    blockApp.middleText(middleText: 'teste de midle text');
    blockApp.bottomText(bottomText: 'teste de bottom text');
    blockApp.buttonText(buttonText: 'teste de button text');
    await blockApp.initVersionBlocker(context);
  }
}