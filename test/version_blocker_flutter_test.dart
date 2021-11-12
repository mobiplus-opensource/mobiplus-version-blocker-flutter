import 'package:flutter_test/flutter_test.dart';

import 'package:version_blocker_flutter/version_blocker_flutter.dart';

Future<void> main() async {
  final blockApp = await BlockApp.init();
  test('must do nothing', () => blockApp.block("1.2.0"));
}
