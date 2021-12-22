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

  String _titleText = 'Tá na hora de atualizar seu aplicativo';
  late String _middleText = 'Fizemos algumas atualizações desde a última vez por aqui.';
  late String _bottomText = 'Clica aí no botão para baixar a nova versão.';
  late String _buttonText = 'ATUALIZAR';

  void title(String titleText) {
    titleText.isNotEmpty
        ? _titleText = titleText
        : _titleText = 'Tá na hora de atualizar seu aplicativo';
  }

  void middleText(String middleText) {
    middleText.isNotEmpty
        ? _middleText = middleText
        : _middleText =
            'Fizemos algumas atualizações desde a última vez por aqui.';
  }

  void bottomText(String bottomText) {
    bottomText.isNotEmpty
        ? _bottomText = bottomText
        : _bottomText = 'Clica aí no botão para baixar a nova versão.';
  }

  void buttonText(String buttonText) {
    buttonText.isNotEmpty
        ? _buttonText = buttonText
        : _buttonText = 'ATUALIZAR';
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
