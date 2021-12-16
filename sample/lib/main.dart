import 'package:flutter/material.dart';
import 'package:version_blocker_flutter/block_app.dart';
import 'package:version_blocker_flutter_example/screens/home.screen.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  final blockApp = BlockApp();
  blockApp.initBlockApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}