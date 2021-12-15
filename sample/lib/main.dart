import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:version_blocker_flutter/block_app.dart';
import 'package:version_blocker_flutter_example/screens/home.screen.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  const teste = BlockApp;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}