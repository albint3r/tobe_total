import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/features/timer/presentation/timer/buttons/pause.dart';
import 'package:tobe_total/src/features/timer/presentation/timer/buttons/play.dart';
import 'package:tobe_total/src/features/timer/presentation/timer/buttons/show_moves.dart';
import 'package:tobe_total/src/features/timer/presentation/timer/buttons/skip.dart';
import '../../../../../providers/timer/model/training_timer.dart';
import '../dialogos/movementsToDoDialog.dart';

class ButtonsTimeArea extends ConsumerWidget {
  const ButtonsTimeArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = ref.watch(trainingTimerProvider);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ShowMovesBtn(
              labelBtn: 'Show Moves',
              callBack: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const DialogShowedMove();
                  },
                );
              }),
          PauseBtn(
            labelBtn: 'Pause',
            callBack: timer.pauseTime,
          ),
          PlayBtn(
            labelBtn: 'Play',
            callBack: timer.startTimer,
          ),
          SkipBtn(
            labelBtn: 'Skip',
            callBack: timer.skipBlock,
          ),
        ],
      ),
    );
  }
}
