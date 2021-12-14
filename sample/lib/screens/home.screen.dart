import 'package:example/screens/version_blocker/version.blocker.functions.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
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
                  final blockVersion = await initVersionBlocker();
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => BlockScreen()),
                  // );
                },
                child: Text('Me clique'),
              ),
            ),
          );
        }
      ),
    );
  }
}