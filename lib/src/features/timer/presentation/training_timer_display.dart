import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/features/timer/presentation/timer/clocks/blocks_in_wod_counter.dart';
import 'package:tobe_total/src/features/timer/presentation/timer/buttons/buttons_timer.dart';
import 'package:tobe_total/src/features/timer/presentation/timer/clocks/main_clock.dart';
import 'package:tobe_total/src/features/timer/presentation/timer/movement_display.dart';
import 'package:tobe_total/src/features/timer/presentation/timer/clocks/movement_in_block_counter.dart';
import '../../../providers/proxies/movement_proxy.dart';
import 'package:wakelock/wakelock.dart';

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
    Wakelock.enable();
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Container( //TODO HERE ADD VIDEO FOR CURRENT MOVEMENT BACKGROUND
            child: ListView(
              shrinkWrap: true,
              children: [
                const MainClock(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: const [
                        BlocksInWodCounter(),
                        Text('Blocks')
                      ],
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
          const MovementDisplay(),
          const ButtonsTimeArea()
        ],
      ),
    );
  }
}


class MoveToShow extends ConsumerWidget {
  const MoveToShow({
    required this.movement,
    Key? key,
  }) : super(key: key);
  final ProxyMovement movement;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text('${movement.name}');
  }
}
