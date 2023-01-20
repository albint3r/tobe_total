import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../common_widgets/clock_timer_buttons/buttons_clock.dart';

class PlayBtn extends ConsumerWidget {
  const PlayBtn({
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
      icon: const Icon(Icons.play_arrow),
      iconSize: 50,
    );
  }
}
