import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/timer/presentation/training_timer_display.dart';
import 'package:wakelock/wakelock.dart';

class TrainingTimerScreen extends ConsumerStatefulWidget {
  const TrainingTimerScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _TrainingTimerScreenState();
}

class _TrainingTimerScreenState extends ConsumerState<TrainingTimerScreen> {
  @override
  Widget build(BuildContext context) {
    Wakelock.enable();
    return const Scaffold(
      body: TrainingTimerDisplay(),
    );
  }
}


