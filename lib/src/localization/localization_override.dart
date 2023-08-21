import 'package:flutter/material.dart';

class LocalizationOverride extends StatelessWidget {
  final Widget Function(BuildContext) builder;
  const LocalizationOverride({required this.builder, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement this feature
    return builder(context);
  }
}
