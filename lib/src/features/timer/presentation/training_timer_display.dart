import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/features/timer/presentation/timer/buttons/close.dart';
import 'package:tobe_total/src/features/timer/presentation/timer/clocks/blocks_in_wod_counter.dart';
import 'package:tobe_total/src/features/timer/presentation/timer/buttons/buttons_timer.dart';
import 'package:tobe_total/src/features/timer/presentation/timer/clocks/main_clock.dart';
import 'package:tobe_total/src/features/timer/presentation/timer/dialogos/rate_block_dialog.dart';
import 'package:tobe_total/src/features/timer/presentation/timer/movement_display.dart';
import 'package:tobe_total/src/features/timer/presentation/timer/clocks/movement_in_block_counter.dart';
import 'package:tobe_total/src/providers/timer/model/training_timer.dart';


class TrainingTimerDisplay extends ConsumerStatefulWidget {
  const TrainingTimerDisplay({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _TrainingTimerState();
}

class _TrainingTimerState extends ConsumerState<TrainingTimerDisplay> {
  @override
  Widget build(BuildContext context) {
    // Enable Smart phone to have the screen ON whe the timer is open.
    final timer = ref.watch(trainingTimerProvider);
    return Container(
      width: double.infinity,
      child: ListView(
        physics: const ClampingScrollPhysics(),
        primary: true,
        shrinkWrap: true,
        children: [
          Row(
            children: const [
              CloseTimerBtn(),
            ],
          ),
          Container(
            //TODO HERE ADD VIDEO FOR CURRENT MOVEMENT BACKGROUND
            child: ListView(
              shrinkWrap: true,
              primary: true,
              physics: const ClampingScrollPhysics(),
              children: [
                const MainClock(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: const [BlocksInWodCounter(), Text('Blocks')],
                    ),
                    Column(
                      children: const [
                        MovementInBlockCounter(),
                        Text('Rounds')
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const ButtonsTimeArea(),
          const MovementDisplay(),
          // This control when the Rate Quiz is display it after the Block is Ended.
          timer.currentState == TimerState.rateTraining
              ? RateBlockDialog(timer: timer)
              : const SizedBox()
        ],
      ),
    );
  }
}
