import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../providers/timer/model/training_timer.dart';
import '../../../../common_widgets/clock_timer_buttons/buttons_clock.dart';
import '../../training_timer_display.dart';

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
    return ClockButtons(labelBtn: labelBtn, callBack: callBack);
  }
}

class DialogShowedMove extends ConsumerWidget {
  const DialogShowedMove({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = ref.watch(trainingTimerProvider);
    if (timer.currentState != TimerState.finishWorkOut) {
      selectBlockMoveToShow(timer);
      return AlertDialog(
        title: const Text('Moves in the block'),
        content: Column(
          children: selectBlockMoveToShow(timer),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'))
        ],
      );
    } else {
      return AlertDialog(
        title: const Text('You finish!'),
        content: const Text('Go to evaluate your training'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'))
        ],
      );
    }
  }

  List<MoveToShow> selectBlockMoveToShow(TrainingTimerModel timer) {
    var block = timer.selectBlockMoveToShow();
    return [
      for (var move in block.movements.values)
        MoveToShow(
          movement: move,
        )
    ];
  }
}
