import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:version_blocker_flutter/src/block.screen.dart';

class BlockApp {
  late final _child = FirebaseDatabase.instanceFor(app: Firebase.app())
      .ref()
      .child('blockedVersions');

  static late final BuildContext _context;

  late Color _backgroundColor = Colors.white;

  late String _titleText = 'Tá na hora de atualizar seu aplicativo';
  late TextStyle _titleStyle =
      const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,);

  late String _middleText =
      'Fizemos algumas atualizações desde a última vez por aqui.';
  late TextStyle _middleTextStyle = const TextStyle(fontSize: 20);

  late String _bottomText = 'Clica aí no botão para baixar a nova versão.';
  late TextStyle _bottomTextStyle = const TextStyle(fontSize: 20);

  late String _buttonText = 'ATUALIZAR';
  late TextStyle _buttonTextStyle = const TextStyle(fontSize: 20);

  late ButtonStyle _buttonStyle = ButtonStyle(
      minimumSize: MaterialStateProperty.all<Size>(const Size(320, 50)),
      backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
      textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(fontSize: 20)));

  late Image _image = Image(
    image: AssetImage('assets/images/update_icon.jpg'),
  );

  void backGroundColor({Color? backgroundColor}) {
    if (backgroundColor != null) {
      _backgroundColor = backgroundColor;
    }
  }

  void titleText({TextStyle? titleStyle, String? titleText}) {
    if (titleText != null) {
      _titleText = titleText;
    }

    if (titleStyle != null) {
      _titleStyle = titleStyle;
    }
  }

  void middleText({String? middleText, TextStyle? middleTextStyle}) {
    if (middleText != null) {
      _middleText = middleText;
    }

    if (middleTextStyle != null) {
      _middleTextStyle = middleTextStyle;
    }
  }

  void bottomText({String? bottomText, TextStyle? bottomTextStyle}) {
    if (bottomText != null) {
      _bottomText = bottomText;
    }

    if (bottomTextStyle != null) {
      _bottomTextStyle = bottomTextStyle;
    }
  }

  void button(
      {String? buttonText,
      TextStyle? buttonTextStyle,
      ButtonStyle? buttonStyle}) {
    if (buttonText != null) {
      _buttonText = buttonText;
    }

    if (buttonTextStyle != null) {
      _buttonTextStyle = buttonTextStyle;
    }

    if (buttonStyle != null) {
      _buttonStyle = buttonStyle;
    }
  }

  void image({Image? image}) {
    if (image != null) {
      _image = image;
    }
  }

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

    final int checkVersion = Platform.isIOS
        ? blockData.iosBuildNumber
        : blockData.androidBuildNumber;
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
            _titleText,
            _middleText,
            _bottomText,
            _buttonText,
            _titleStyle,
            _middleTextStyle,
            _bottomTextStyle,
            _buttonTextStyle,
            _buttonStyle,
            _image,
            _backgroundColor);
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
