import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'button_style_timer.dart';


class ClockButtons extends ConsumerWidget {
  const ClockButtons({
    required this.labelBtn,
    required this.callBack,
    Key? key,
  }) : super(key: key);
  final String labelBtn;
  final void Function() callBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ButtonStyleTimer(
      child: ElevatedButton(
        onPressed: () {
          callBack();
        },
        child: Text(labelBtn),
      ),
    );
  }
}
