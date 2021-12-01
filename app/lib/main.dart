import 'package:app/screens/block.screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp(titleText: '',
                                  bottomText: '',
                                  buttonText: '',
                                  middleText: '',));

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.titleText,required this.middleText,required this.bottomText,required this.buttonText}) : super(key: key);

  final String bottomText;
  final String buttonText;
  final String middleText;
  final String titleText;

  @override
  Widget build(BuildContext context) {
    return const BlockScreen();
  }
}