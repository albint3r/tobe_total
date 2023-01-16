import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/features/timer/presentation/timer/blocks_in_wod_counter.dart';
import 'package:tobe_total/src/features/timer/presentation/timer/button_style_timer.dart';
import 'package:tobe_total/src/features/timer/presentation/timer/main_clock.dart';
import 'package:tobe_total/src/features/timer/presentation/timer/movement_display.dart';
import 'package:tobe_total/src/features/timer/presentation/timer/movement_in_block_counter.dart';
import '../../../providers/timer/model/training_timer.dart';
import '../../common_widgets/headers_screens/header_screens.dart';

class TrainingTimer extends ConsumerStatefulWidget {
  const TrainingTimer({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _TrainingTimerState();
}

class _TrainingTimerState extends ConsumerState<TrainingTimer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              const MainClock(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  BlocksInWodCounter(),
                  MovementInBlockCounter(),
                ],
              ),
            ],
          ),
          const MovementDisplay(),
          const ButtonsTimeArea()
        ],
      ),
    );
  }
}

class ButtonsTimeArea extends ConsumerWidget {
  const ButtonsTimeArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = ref.watch(trainingTimerProvider);
    return Column(
      children: [
        ButtonStyleTimer(
          child: ElevatedButton(
              onPressed: () {
                timer.startTimer();
              },
              child: const Text('play')),
        ),
        ButtonStyleTimer(
          child: ElevatedButton(
              onPressed: () {
                timer.stopTimer();
              },
              child: const Text('stop')),
        ),
        ButtonStyleTimer(
          child: ElevatedButton(
              onPressed: () {
                timer.pauseTime();
              },
              child: const Text('pause Time')),
        )
      ],
    );
  }
}
