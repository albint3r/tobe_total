import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/features/timer/presentation/timer/blocks_in_wod_counter.dart';
import 'package:tobe_total/src/features/timer/presentation/timer/button_style_timer.dart';
import 'package:tobe_total/src/features/timer/presentation/timer/main_clock.dart';
import 'package:tobe_total/src/features/timer/presentation/timer/movement_display.dart';
import 'package:tobe_total/src/features/timer/presentation/timer/movement_in_block_counter.dart';
import '../../../providers/proxies/movement_proxy.dart';
import '../../../providers/timer/model/training_timer.dart';

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
                // TODO ACTIVIATE THIS METHOD TO EVALUATE ALL THE TRAINING
                // if(timer.currentState == TimerState.rateTraining) {
                //   showDialog(context: context, builder: (context) => AlertDialog(
                //     title: Text('algo bonito'),
                //     content: Text('This is just a test'),
                //     actions: [
                //       TextButton(onPressed: () => Navigator.pop(context), child: Text('Close'))
                //     ],
                //   ));
                // } else  {
                //   timer.startTimer();
                // }
              },
              child: const Text('Play')),
        ),
        ButtonStyleTimer(
          child: ElevatedButton(
              onPressed: () {
                timer.pauseTime();
              },
              child: const Text('Pause')),
        ),
        ButtonStyleTimer(
          child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    if(timer.currentState != TimerState.finishWorkOut) {
                      selectBlockMoveToShow(timer);
                      return AlertDialog(
                        title: Text('Moves in the block'),
                        content: Column(
                          children: selectBlockMoveToShow(timer),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('Close'))
                        ],
                      );

                    } else {
                      return AlertDialog(
                        title: Text('You finish!'),
                        content: Text('Go to evaluate your training'),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('Close'))
                        ],
                      );
                    }
                    // selectBlockMoveToShow(timer);
                    // return AlertDialog(
                    //   title: Text('Moves in the block'),
                    //   content: Column(
                    //     children: selectBlockMoveToShow(timer),
                    //   ),
                    //   actions: [
                    //     TextButton(
                    //         onPressed: () => Navigator.pop(context),
                    //         child: Text('Close'))
                    //   ],
                    // );
                  },
                );
              },
              child: const Text('Show Moves')),
        ),
        ButtonStyleTimer(
          child: ElevatedButton(
              onPressed: () {
                timer.stopTimer();
              },
              child: const Text('Stop')),
        ),
      ],
    );
  }

  List<MoveToShow> selectBlockMoveToShow(TrainingTimerModel timer) {
    var block = timer.selectBlockMoveToShow();
    return [
      for (var move in block.movements.values)
        MoveToShow(
          movement: move,
        )
    ];
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
