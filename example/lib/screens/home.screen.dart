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
                minimumSize: MaterialStateProperty.all<Size>(const Size(320, 50)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(fontSize: 20)),
              ),
            ),
            child: ElevatedButton(
              onPressed: () async {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const BlockScreen()));
              },
              child: const Text('Me clique'),
            ),
          ),
        );
      }),
    );
  }

  void initBlockVersion(BuildContext context) async {
    final blockApp = BlockApp();
    blockApp.image(image: const Image(image: AssetImage('assets/images/10772206.jpg')));
    await blockApp.initVersionBlocker(context);
  }
}
