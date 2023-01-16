import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ButtonStyleTimer extends StatelessWidget {
  const ButtonStyleTimer({
    required this.child,
    Key? key,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(child: child, margin: const EdgeInsets.symmetric(vertical: 5),);
  }
}