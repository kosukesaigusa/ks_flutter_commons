import 'package:flutter/material.dart';

/// Stack で重ねて下のウィジェットを操作不可能にするためのウィジェット
class DisableControllWidget extends StatelessWidget {
  const DisableControllWidget({
    Key? key,
    this.filterColor = Colors.black38,
    this.text,
    this.textColor = Colors.white,
    this.showProgressIndicator = false,
    this.progressIndicatorColor = Colors.white,
  }) : super(key: key);

  final Color filterColor;
  final String? text;
  final Color textColor;
  final bool showProgressIndicator;
  final Color progressIndicatorColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: filterColor,
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (showProgressIndicator)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: CircularProgressIndicator(color: progressIndicatorColor),
            ),
          if (text != null) Text(text!, style: TextStyle(color: textColor)),
        ],
      ),
    );
  }
}
