import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../providers/proxies/movement_proxy.dart';
import '../../../../../providers/timer/model/training_timer.dart';
import '../../training_timer_display.dart';

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

class MoveToShow extends ConsumerWidget {
  const MoveToShow({
    required this.movement,
    Key? key,
  }) : super(key: key);
  final ProxyMovement movement;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text('${movement.name}');
  }
}
