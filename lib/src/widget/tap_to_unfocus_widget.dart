import 'package:flutter/material.dart';

class TapToUnfocusWidget extends StatelessWidget {
  const TapToUnfocusWidget({required this.child});
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: child,
    );
  }
}
