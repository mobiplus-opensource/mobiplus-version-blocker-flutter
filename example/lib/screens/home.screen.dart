import 'package:flutter/material.dart';
import 'package:version_blocker_flutter/version_blocker_flutter.dart';
import 'block.screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // initBlockVersion(context);
    return const MaterialApp(
      home: BlockScreen(
        titleText: "Tá na hora de atualizar seu aplicativo",
        middleText: "meio",
        bottomText: "bootom",
        buttonText: "button",
        titleTextStyle: TextStyle(),
        middleTexteStyle: TextStyle(),
        bottomTextStyle: TextStyle(),
        buttonTextStyle: TextStyle(),
        buttonStyle: ButtonStyle(),
        image: FlutterLogo(
          size: 100,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  void initBlockVersion(BuildContext context) async {
    final blockApp = BlockApp();
    blockApp.image(const Image(image: AssetImage('assets/images/10772206.jpg')));
    await blockApp.initVersionBlocker(context);
  }
}
