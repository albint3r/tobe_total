import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../../providers/timer/model/training_timer.dart';
import '../utils/color_timer.dart';

class MainClock extends ConsumerStatefulWidget {
  const MainClock({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _MainClockState();
}

class _MainClockState extends ConsumerState<MainClock> {
  @override
  Widget build(BuildContext context) {
    final timer = ref.watch(trainingTimerProvider);
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      child: CircularPercentIndicator(
        radius: 100.0,
        lineWidth: 15.0,
        percent: getTimePercent(timer.seconds, timer.currentState),
        // center: Text(getTimeText(timer.seconds, timer.currentState),
        center: Text(
          textAlign: TextAlign.center,
          whatToShowCenter(timer.seconds, timer),
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        // progressColor: Colors.green,
        progressColor:
            getColorTimer(getTimePercent(timer.seconds, timer.currentState)),
      ),
    );
  }

  double getTimePercent(int seconds, TimerState timeState) {
    if (timeState == TimerState.waitBlock) {
      return seconds / 5;
    } else {
      return seconds / 60;
    }
  }


  String whatToShowCenter(int seconds, TrainingTimerModel timer) {
    switch (timer.currentState) {
      case TimerState.unStarted:
        return 'Start';
        break;
      case TimerState.waitBlock:
        return "${5 - seconds}";
        break;
      case TimerState.play:
        return "${60 - seconds}";
        break;
      case TimerState.pause:
        return 'Pause';
        break;
      case TimerState.stop:

        String msg;
        // This Create a new Msg when is the first block to train
        // Creating a more natural msg flow for the user for the next steps.
        if(timer.currentBlockIndex == 0) {
           msg = 'Confirm\nStart';
        } else {
          msg = 'Go\nNext';
        }
        return msg;
        break;
      case TimerState.rateTraining:
        return 'Rate Time';
        break;
      case TimerState.finishWorkOut:
        return 'Finish';
        break;
    }
  }
}
