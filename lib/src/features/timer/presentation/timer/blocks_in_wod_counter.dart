import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../providers/timer/model/training_timer.dart';
import 'color_timer.dart';

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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: CircularPercentIndicator(
        radius: 40.0,
        lineWidth: 5.0,
        percent: timer.currentBlockIndex == null
            ? 0
            : timer.currentBlockIndex! / timer.totalBlocksInWod!,
        center: Text(
            "${timer.currentBlockIndex ?? 1}/${timer.totalBlocksInWod}",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        // progressColor: Colors.green,
        progressColor: getColorTimer(timer.currentBlockIndex == null
            ? 0
            : timer.currentBlockIndex! / timer.totalBlocksInWod!),
      ),
    );
  }
}
