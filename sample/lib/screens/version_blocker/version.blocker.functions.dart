import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:package_info_plus/package_info_plus.dart';


final _app = Firebase.app();
final _child = FirebaseDatabase.instanceFor(app: _app).ref().child('blockedVersions');

Future<bool> initVersionBlocker() {
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
  return true;
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