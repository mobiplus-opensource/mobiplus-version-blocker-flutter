import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:store_redirect/store_redirect.dart';

class BlockScreen extends StatefulWidget {
  const BlockScreen({
    Key? key,
    required this.titleText,
    required this.middleText,
    required this.bottomText,
    required this.buttonText,
    required this.titleTextStyle,
    required this.middleTexteStyle,
    required this.bottomTextStyle,
    required this.buttonTextStyle,
    required this.buttonStyle,
    required this.image,
    required this.backgroundColor,
  }) : super(key: key);

  final Color? backgroundColor;

  final String? titleText;
  final String? middleText;
  final String? bottomText;
  final String? buttonText;

  final TextStyle? titleTextStyle;
  final TextStyle? middleTexteStyle;
  final TextStyle? bottomTextStyle;
  final TextStyle? buttonTextStyle;

  final ButtonStyle? buttonStyle;

  final Widget? image;

  @override
  State<BlockScreen> createState() => BlockScreenStates();
}

class BlockScreenStates extends State<BlockScreen> {
  EdgeInsetsGeometry get _paddingHorizontal => const EdgeInsets.symmetric(horizontal: 30);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: widget.backgroundColor,
        bottomNavigationBar: widget.buttonText == null
            ? null
            : SafeArea(
                top: false,
                child: Padding(
                  padding: _paddingHorizontal,
                  child: ElevatedButton(
                    style: widget.buttonStyle,
                    onPressed: () async {
                      final PackageInfo _info = await PackageInfo.fromPlatform();
                      StoreRedirect.redirect(androidAppId: _info.packageName, iOSAppId: _info.packageName);
                    },
                    child: Text(
                      widget.buttonText!,
                      style: widget.buttonTextStyle,
                    ),
                  ),
                ),
              ),
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.titleText?.isNotEmpty != null) ...[
                const SizedBox(height: 60),
                Padding(
                  padding: _paddingHorizontal,
                  child: Text(widget.titleText!, style: widget.titleTextStyle, textAlign: TextAlign.center),
                ),
              ],
              if (widget.image != null)
                Expanded(
                  child: Center(child: widget.image!),
                ),
              if (widget.middleText?.isNotEmpty != null) ...[
                const SizedBox(height: 30),
                Padding(
                  padding: _paddingHorizontal,
                  child: Text(
                    widget.middleText!,
                    style: widget.middleTexteStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
              const SizedBox(height: 30),
              if (widget.bottomText?.isNotEmpty != null) ...[
                Padding(
                  padding: _paddingHorizontal,
                  child: Text(
                    widget.bottomText!,
                    style: widget.bottomTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
