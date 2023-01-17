import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../providers/timer/model/training_timer.dart';
import 'color_timer.dart';

class MovementInBlockCounter extends ConsumerStatefulWidget {
  const MovementInBlockCounter({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _MovementInBlockCounterState();
}

class _MovementInBlockCounterState
    extends ConsumerState<MovementInBlockCounter> {
  @override
  Widget build(BuildContext context) {
    final timer = ref.watch(trainingTimerProvider);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: CircularPercentIndicator(
        radius: 40.0,
        lineWidth: 5.0,
        percent: timer.currentRoundsBlock == null
            ? 0
            : 1 - timer.currentRoundsBlock! / timer.currentBlockTotalMovements!,
        center: Text("${timer.currentRoundsBlock ?? '0'}",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        progressColor: getColorTimer(timer.currentRoundsBlock == null
            ? 0
            : 1 - timer.currentRoundsBlock! / timer.currentBlockTotalMovements!),
      ),
    );
  }
}
