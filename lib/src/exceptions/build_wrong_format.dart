import 'package:version_blocker_flutter/src/exceptions/base_exception.dart';

class BuildWrongFormat extends BaseException {
  BuildWrongFormat() : super(_message);
  static const String _message = "incorrect build value format.";
}
