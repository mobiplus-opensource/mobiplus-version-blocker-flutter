import 'package:version_blocker_flutter/exceptions/base_exception.dart';

class BuildWrongFormat extends BaseException {
  BuildWrongFormat() : super(_message);
  static const String _message = "incorrect build value format.";
}
