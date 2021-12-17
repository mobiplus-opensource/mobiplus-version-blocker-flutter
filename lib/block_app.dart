import 'dart:convert';
import 'dart:io';

import 'package:firebase/firebase.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:version_blocker_flutter/block.screen.dart';
import 'package:version_blocker_flutter/exceptions/exceptions_imports.dart';
import 'package:package_info_plus/package_info_plus.dart';

class BlockApp {
  static late final PackageInfo _info;
  final _child = FirebaseDatabase.instanceFor(app: Firebase.app())
      .ref()
      .child('blockedVersions');

  Text? _message;
  static late final BuildContext _context;

  Text get message => _messageValue;

  set message(Text value) => _message = value;

  String get _buildApp => _info.buildNumber;
  RegExp get _regexContainsOnlyNumbers => RegExp(r"^[0-9]+$");

  Text get _messageValue =>
      _message ??
      Text(
        "Por favor, atualize seu aplicativo!",
        style: Theme.of(_context).textTheme.headline2,
      );

  void block({required String build}) {
    build.trim();
    if (build.isEmpty) throw BuildEmptyException();
    if (!build.contains(_regexContainsOnlyNumbers)) throw BuildWrongFormat();
    if (build.compareTo(_buildApp) == 0) _blockAppAction();
  }

  void showViewBlock() {
    Navigator.push(
      _context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          body: WillPopScope(
            onWillPop: () async => false,
            child: Center(
              child: _messageValue,
            ),
          ),
        ),
      ),
    );
  }

  void _blockAppAction() => showViewBlock();

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

  static void _showBlockModal(BlockData blockData) {
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
        return BlockScreen();
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
