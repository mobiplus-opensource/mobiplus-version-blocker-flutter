import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:version_blocker_flutter/exceptions/exceptions_imports.dart';

class BlockApp {
  BlockApp._();

  static late final PackageInfo _info;
  static final BlockApp _instance = BlockApp._();

  String get _buildApp => _info.buildNumber;
  RegExp get _regexContainsOnlyNumbers => RegExp(r"^[0-9]+$");

  static Future<BlockApp> init() async {
    _info = await PackageInfo.fromPlatform();
    return _instance;
  }

  void block(String build, BuildContext context) {
    build.trim();
    if (build.isEmpty) throw BuildEmptyException();
    if (!build.contains(_regexContainsOnlyNumbers)) throw BuildWrongFormat();
    if (build.compareTo(_buildApp) == 0) _blockAppAction(context);
  }

  void showViewBlock(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          body: WillPopScope(
            onWillPop: () async => false,
            child: const Center(
              child: Text("data"),
            ),
          ),
        ),
      ),
    );
  }

  void _blockAppAction(BuildContext context) => showViewBlock(context);
}
