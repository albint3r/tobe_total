import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'logic.dart';
import 'package:wakelock/wakelock.dart';



class TrainingTimerDisplay extends ConsumerStatefulWidget {
  const TrainingTimerDisplay({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _TrainingTimerDisplayState();
}

class _TrainingTimerDisplayState extends ConsumerState<TrainingTimerDisplay> {
  @override
  Widget build(BuildContext context) {
    Wakelock.enable();
    return Column(
      children:  const [
        TrainingTimerLogic(),
      ],
    );
  }
}


