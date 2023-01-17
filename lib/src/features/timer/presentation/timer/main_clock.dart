import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../providers/timer/model/training_timer.dart';
import 'color_timer.dart';

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
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: CircularPercentIndicator(
        radius: 80.0,
        lineWidth: 15.0,
        percent: getTimePercent(timer.seconds, timer.currentState),
        center: Text(getTimeText(timer.seconds, timer.currentState),
            style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
        // progressColor: Colors.green,
        progressColor: getColorTimer(getTimePercent(timer.seconds, timer.currentState)),
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

  String getTimeText(int seconds, TimerState timeState) {
    if (timeState == TimerState.waitBlock) {
      return "${5 - seconds}";
    } else {
      return "${60 - seconds}";
    }
  }
}

class StartedTimer extends ConsumerStatefulWidget {
  const StartedTimer({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _StartedTimerState();
}

class _StartedTimerState extends ConsumerState<StartedTimer> {
  @override
  Widget build(BuildContext context) {
    final timer = ref.watch(trainingTimerProvider);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: CircularPercentIndicator(
        radius: 80.0,
        lineWidth: 15.0,
        percent: timer.seconds / 5,
        center: Text("${5 - timer.seconds}",
            style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
        // progressColor: Colors.green,
        progressColor: getColorTimer(timer.seconds / 5),
      ),
    );
  }
}
