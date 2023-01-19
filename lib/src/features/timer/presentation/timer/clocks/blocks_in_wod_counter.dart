import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../../providers/timer/model/training_timer.dart';
import '../utils/color_timer.dart';

class BlocksInWodCounter extends ConsumerStatefulWidget {
  const BlocksInWodCounter({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _BlocksInWodCounterState();
}

class _BlocksInWodCounterState extends ConsumerState<BlocksInWodCounter> {
  @override
  Widget build(BuildContext context) {
    final timer = ref.watch(trainingTimerProvider);
    print('[timer.currentBlockIndex]-----------------------');
    print(timer.currentBlockIndex);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: CircularPercentIndicator(
        radius: 40.0,
        lineWidth: 7.0,
        percent: timer.currentBlockIndex == null
            ? 0
            : timer.currentBlockIndex! / timer.totalBlocksInWod!,
        center: Text(whatToShowCenter(timer),
             style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        progressColor: getColorTimer(timer.currentBlockIndex == null
            ? 0
            : timer.currentBlockIndex! / timer.totalBlocksInWod!),
      ),
    );
  }

  String whatToShowCenter(TrainingTimerModel timer) {
    switch (timer.currentState) {
      case TimerState.unStarted:
        return '${timer.currentBlockIndex ?? 0}/${timer.totalBlocksInWod}';
        break;
      case TimerState.waitBlock:
        return '${timer.currentBlockIndex ?? 0}/${timer.totalBlocksInWod}';
        break;
      case TimerState.play:
        return "${timer.currentBlockIndex ?? 0}/${timer.totalBlocksInWod}";
        break;
      case TimerState.pause:
        return '${timer.currentBlockIndex ?? 0}/${timer.totalBlocksInWod}';
        break;
      case TimerState.stop:
        return '${timer.currentBlockIndex ?? 0}/${timer.totalBlocksInWod}';
        break;
      case TimerState.rateTraining:
        return '${timer.currentBlockIndex ?? 0}/${timer.totalBlocksInWod}';
        break;
      case TimerState.finishWorkOut:
        return '${timer.currentBlockIndex ?? 0}/${timer.totalBlocksInWod}';
        break;
    }
  }

}
