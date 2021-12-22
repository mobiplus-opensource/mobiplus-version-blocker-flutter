import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:version_blocker_flutter/block.screen.dart';
import 'package:package_info_plus/package_info_plus.dart';

class BlockApp {
  late final _child = FirebaseDatabase.instanceFor(app: Firebase.app())
      .ref()
      .child('blockedVersions');

  static late final BuildContext _context;

  late String _titleText = 'Tá na hora de atualizar seu aplicativo';
  late TextStyle? _titleStyle;
  late String _middleText =
      'Fizemos algumas atualizações desde a última vez por aqui.';
  late TextStyle? _middleTextStyle;
  late String _bottomText = 'Clica aí no botão para baixar a nova versão.';
  late TextStyle? _bottomTextStyle;
  late String _buttonText = 'ATUALIZAR';
  late TextStyle? _buttonTextStyle;

  void title({TextStyle? titleStyle, String? titleText}) {
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

  void buttonText({String? buttonText, TextStyle? buttonTextStyle}) {
    if (buttonText != null) {
      _buttonText = buttonText;
    }

    if (buttonTextStyle != null) {
      _buttonTextStyle = buttonTextStyle;
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
        return BlockScreen(_titleText, _middleText, _bottomText, _buttonText);
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
