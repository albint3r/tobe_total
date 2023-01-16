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
    return           Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: CircularPercentIndicator(
        radius: 80.0,
        lineWidth: 15.0,
        percent: timer.seconds / 60,
        center: Text("${60 - timer.seconds}",
            style: const TextStyle(
                fontSize: 50, fontWeight: FontWeight.bold)),
        // progressColor: Colors.green,
        progressColor: getColorTimer(timer.seconds / 60),
      ),
    );
  }
}
