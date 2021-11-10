import 'dart:io';

class BlockApp {
  BlockApp._();

  static BlockApp get instance => BlockApp._();

  String get _buildApp => Platform.version.split("+").last.trim();

  void block(String build) {
    build.trim();
    // TODO: add validacao de numeracao correta
    // TODO: add exceptions
    if (build.isEmpty) return;
    if (build.compareTo(_buildApp) == 0) _blockAppAction();
  }

  void _blockAppAction() {}
}
