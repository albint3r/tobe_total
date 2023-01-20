import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class ShowMovesBtn extends ConsumerWidget {
  const ShowMovesBtn({
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
      icon: const Icon(Icons.remove_red_eye_outlined),
      iconSize: 50,
    );
  }
}
