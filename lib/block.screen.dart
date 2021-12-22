// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:store_redirect/store_redirect.dart';

class BlockScreen extends StatefulWidget {
  final String titleText;
  final String middleText;
  final String bottomText;
  final String buttonText;

  final TextStyle titleStyle;
  final TextStyle middleStyle;
  final TextStyle bottomStyle;
  final TextStyle buttonStyle;

  const BlockScreen(
    this.titleText,
    this.middleText,
    this.bottomText,
    this.buttonText,
    this.titleStyle,
    this.middleStyle,
    this.bottomStyle,
    this.buttonStyle,
  ) : super();

  @override
  State<BlockScreen> createState() => BlockScreenStates();
}

class BlockScreenStates extends State<BlockScreen> {
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
                  widget.titleText,
                  style: widget.titleStyle,
                ),
                alignment: Alignment(0.0, 0.0),
              ),
              Container(
                child: Image(
                  image: AssetImage('assets/images/update_icon.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30),
                child: Text(
                  widget.middleText,
                  style: widget.middleStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 70, right: 70, top: 20),
                child: Text(
                  widget.bottomText,
                  style: widget.bottomStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ElevatedButtonTheme(
                  data: ElevatedButtonThemeData(
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all<Size>(Size(320, 50)),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red),
                          textStyle: MaterialStateProperty.all<TextStyle>(
                              TextStyle(fontSize: 20)))),
                  child: ElevatedButton(
                    onPressed: () {
                      StoreRedirect.redirect(
                          androidAppId: "com.android.chrome",
                          iOSAppId: "535886823");
                    },
                    child: Text(widget.buttonText),
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
