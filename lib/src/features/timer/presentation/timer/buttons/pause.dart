import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PauseBtn extends ConsumerWidget {
  const PauseBtn({
    required this.labelBtn,
    required this.callBack,
    Key? key,
  }) : super(key: key);
  final String labelBtn;
  final void Function() callBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // return ClockButtons(labelBtn: labelBtn, callBack: callBack);
    return IconButton(
      onPressed: callBack,
      icon: const Icon(Icons.pause),
      iconSize: 50,
    );
  }
}
