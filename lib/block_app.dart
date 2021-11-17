import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:version_blocker_flutter/exceptions/exceptions_imports.dart';

class BlockApp {
  BlockApp._();

  static late final PackageInfo _info;
  static final BlockApp _instance = BlockApp._();

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

  static Future<BlockApp> instance({required BuildContext context}) async {
    _context = context;
    _info = await PackageInfo.fromPlatform();
    return _instance;
  }

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
}
