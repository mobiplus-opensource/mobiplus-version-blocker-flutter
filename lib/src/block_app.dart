import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:version_blocker_flutter/src/screens/block.screen.dart';

class BlockApp {
  late final _child = FirebaseDatabase.instanceFor(app: Firebase.app()).ref().child('blockedVersions');

  static late final BuildContext _context;

  late Color? _backgroundColor = Colors.white;

  late String? _titleText = 'Tá na hora de atualizar seu aplicativo';
  late TextStyle? _titleStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  late String? _middleText = 'Fizemos algumas atualizações desde a última vez por aqui.';
  late TextStyle? _middleTextStyle = const TextStyle(fontSize: 20);

  late String? _bottomText = 'Clica aí no botão para baixar a nova versão.';
  late TextStyle? _bottomTextStyle = const TextStyle(fontSize: 20);

  late String? _buttonText = 'ATUALIZAR';
  late TextStyle? _buttonTextStyle = const TextStyle(fontSize: 20);

  late ButtonStyle? _buttonStyle = ButtonStyle(
    minimumSize: MaterialStateProperty.all<Size>(const Size(320, 50)),
    backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
    textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(fontSize: 20)),
  );

  late Widget? _image = const Image(image: AssetImage('assets/images/update_icon.jpg'));

  void backGroundColor([Color? backgroundColor]) => _backgroundColor = backgroundColor;

  void titleText({TextStyle? titleStyle, String? titleText}) {
    _titleText = titleText;
    _titleStyle = titleStyle;
  }

  void middleText({String? middleText, TextStyle? middleTextStyle}) {
    _middleText = middleText;
    _middleTextStyle = middleTextStyle;
  }

  void bottomText({String? bottomText, TextStyle? bottomTextStyle}) {
    _bottomText = bottomText;
    _bottomTextStyle = bottomTextStyle;
  }

  void button({String? buttonText, TextStyle? buttonTextStyle, ButtonStyle? buttonStyle}) {
    _buttonText = buttonText;
    _buttonTextStyle = buttonTextStyle;
    _buttonStyle = buttonStyle;
  }

  void image([Widget? image]) => _image = image;

  Future<bool> initVersionBlocker(BuildContext buildContext) {
    _context = buildContext;
    _child.onChildChanged.listen((_) => checkAndBlockVersion());
    return checkAndBlockVersion();
  }

  Future<bool> checkAndBlockVersion() async {
    final snapshot = await _child.once();
    final value = snapshot.snapshot.value as dynamic;
    final blockData = BlockData(
      androidBuildNumber: value['androidBuildNumber'] as int,
      iosBuildNumber: value['iosBuildNumber'] as int,
    );

    final PackageInfo _info;
    _info = await PackageInfo.fromPlatform();
    final appBuildNumber = int.parse(_info.buildNumber);

    final int checkVersion = Platform.isIOS ? blockData.iosBuildNumber : blockData.androidBuildNumber;
    if (appBuildNumber > checkVersion) {
      return false;
    }

    _showBlockModal(blockData);
    return true;
  }

  void _showBlockModal(BlockData blockData) {
    showModalBottomSheet(
      elevation: 0,
      context: _context,
      isDismissible: false,
      isScrollControlled: true,
      enableDrag: false,
      backgroundColor: Colors.red,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) {
        return BlockScreen(
          titleText: _titleText,
          middleText: _middleText,
          bottomText: _bottomText,
          buttonText: _buttonText,
          titleTextStyle: _titleStyle,
          middleTexteStyle: _middleTextStyle,
          bottomTextStyle: _bottomTextStyle,
          buttonTextStyle: _buttonTextStyle,
          buttonStyle: _buttonStyle,
          image: _image,
          backgroundColor: _backgroundColor,
        );
      },
    );
  }
}

class BlockData {
  BlockData({
    required this.androidBuildNumber,
    required this.iosBuildNumber,
  });

  factory BlockData.fromJson(String str) => BlockData.fromMap(json.decode(str));

  factory BlockData.fromMap(Map<String, dynamic> json) => BlockData(
        androidBuildNumber: json["androidBuildsNumber"],
        iosBuildNumber: json["iosBuildsNumber"],
      );

  final int androidBuildNumber;
  final int iosBuildNumber;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "androidBuildsNumber": androidBuildNumber,
        "iosBuildsNumber": iosBuildNumber,
      };
}
