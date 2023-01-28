import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../providers/proxies/movement_proxy.dart';
import '../../../../../providers/timer/model/training_timer.dart';

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
        title: const Text('Block to do information:'),
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
          timer: timer,
        )
    ];
  }
}

class MoveToShow extends ConsumerWidget {
  const MoveToShow({
    required this.movement,
    required this.timer,
    Key? key,
  }) : super(key: key);
  final ProxyMovement movement;
  final TrainingTimerModel timer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      // This paint the border of the color green if is the current
      // movement to do
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
              color: isDoingMove() ? Colors.greenAccent : Colors.white,
              width: 2)),
      elevation: 10,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.symmetric(vertical: 5),
        width: 225,
        height: 115,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(movement.name.toString().toUpperCase()),
            const SizedBox(
              height: 10,
            ),
            Text('Repetition: ${movement.reps}'),
            Text('Weight: ${movement.weight ?? '0'}'),
            Text('Prota Muscle: ${movement.muscleProta}'),
            Text('Move Pattern: ${movement.movementPattern}'),
            Text('Difficulty: ${movement.difficulty}'),
            Text('Dynamic: ${movement.dynamic == 1 ? 'Yes' : 'No'}'),
          ],
        ),
      ),
    );
  }

  /// This return True if the timer is play and is the name of the
  /// current movement is the same of the movement in the card
  bool isDoingMove() {
    if (timer.currentState == TimerState.play &&
        timer.currentMovement?.name == movement.name) {
      return true;
    }
    return false;
  }
}
