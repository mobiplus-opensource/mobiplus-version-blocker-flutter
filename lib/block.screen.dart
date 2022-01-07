// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:store_redirect/store_redirect.dart';

class BlockScreen extends StatefulWidget {
  final String titleText;
  final String middleText;
  final String bottomText;
  final String buttonText;

  final TextStyle titleTextStyle;
  final TextStyle middleTexteStyle;
  final TextStyle bottomTextStyle;
  final TextStyle buttonTextStyle;

  final ButtonStyle buttonStyle;

  final Image image;

  const BlockScreen(
    this.titleText,
    this.middleText,
    this.bottomText,
    this.buttonText,
    this.titleTextStyle,
    this.middleTexteStyle,
    this.bottomTextStyle,
    this.buttonTextStyle,
    this.buttonStyle,
    this.image,
  ) : super();

  @override
  State<BlockScreen> createState() => BlockScreenStates();
}

class BlockScreenStates extends State<BlockScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 110, left: 30, right: 30),
              child: Text(widget.titleText,
                  style: widget.titleTextStyle, textAlign: TextAlign.center),
              alignment: Alignment.topCenter,
            ),
            Container(
              alignment: Alignment(0, 0),
              child: widget.image),
            Container(
              alignment: Alignment(0, 0.5),
              margin: EdgeInsets.only(left: 30, right: 30),
              child: Text(
                widget.middleText,
                style: widget.middleTexteStyle,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 70, right: 70, top: 20),
              alignment: Alignment(0, 0.7),
              child: Text(
                widget.bottomText,
                style: widget.bottomTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButtonTheme(
                data: ElevatedButtonThemeData(style: widget.buttonStyle),
                child: ElevatedButton(
                  onPressed: () async {
                    final PackageInfo _info = await PackageInfo.fromPlatform();
                    StoreRedirect.redirect(
                        androidAppId: _info.packageName,
                        iOSAppId: _info.packageName);
                  },
                  child: Text(widget.buttonText),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
