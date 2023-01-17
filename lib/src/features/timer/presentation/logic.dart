import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/features/timer/presentation/trainin_timer.dart';
import '../../../providers/timer/model/training_timer.dart';


class TrainingTimerLogic extends ConsumerStatefulWidget {
  const TrainingTimerLogic({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _TrainingTimerLogicState();
}

class _TrainingTimerLogicState extends ConsumerState<TrainingTimerLogic> {
  @override
  Widget build(BuildContext context) {
    final timer = ref.watch(trainingTimerProvider);
    return const TrainingTimer();
  }


}
