import 'package:flutter_test/flutter_test.dart';

import 'package:version_blocker_flutter/version_blocker_flutter.dart';

void main() {
  test('must do nothing', () => BlockApp.instance.block("1.2.0"));
}
