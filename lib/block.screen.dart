// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:store_redirect/store_redirect.dart';

class BlockScreen extends StatefulWidget {
  final Color backgroundColor;

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
    this.backgroundColor,
  ) : super();

  @override
  State<BlockScreen> createState() => BlockScreenStates();
}

class BlockScreenStates extends State<BlockScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: widget.backgroundColor,
        body: LayoutBuilder(builder: (_, constraints) {
          return Column(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  child: Text(widget.titleText,
                      style: widget.titleTextStyle,
                      textAlign: TextAlign.center),
                  alignment: Alignment.bottomCenter,
                ),
              ),
              Flexible(
                flex: 3,
                child: Container(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: widget.image,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 30, right: 30),
                          child: Text(
                            widget.middleText,
                            style: widget.middleTexteStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          margin:
                              EdgeInsets.only(left: 70, right: 70, top: 20),
                          child: Text(
                            widget.bottomText,
                            style: widget.bottomTextStyle,
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    )),
              ),
              Container(
                height: constraints.maxWidth / 5,
                padding: EdgeInsets.only(bottom: 10),
                alignment: Alignment.bottomCenter,
                child: ElevatedButtonTheme(
                  data: ElevatedButtonThemeData(style: widget.buttonStyle),
                  child: ElevatedButton(
                    onPressed: () async {
                      final PackageInfo _info =
                          await PackageInfo.fromPlatform();
                      StoreRedirect.redirect(
                          androidAppId: _info.packageName,
                          iOSAppId: _info.packageName);
                    },
                    child: Text(widget.buttonText),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
