import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/features/timer/presentation/timer/buttons/pause.dart';
import 'package:tobe_total/src/features/timer/presentation/timer/buttons/play.dart';
import 'package:tobe_total/src/features/timer/presentation/timer/buttons/show_moves.dart';
import 'package:tobe_total/src/features/timer/presentation/timer/buttons/stop.dart';
import '../../../../../providers/timer/model/training_timer.dart';
import '../dialogos/movementsToDoDialog.dart';

class ButtonsTimeArea extends ConsumerWidget {
  const ButtonsTimeArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = ref.watch(trainingTimerProvider);
    return Row(
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

        StopBtn(labelBtn: 'Stop', callBack: timer.stopTimer),
      ],
    );
  }
}
