import 'package:version_blocker_flutter/src/exceptions/base_exception.dart';

class BuildEmptyException extends BaseException {
  BuildEmptyException() : super(_message);
  static const String _message = "build value is empty.";
}
