import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/providers/timer/model/training_timer.dart';

class SkipBtn extends ConsumerWidget {
  const SkipBtn({
    required this.labelBtn,
    required this.callBack,
    Key? key,
  }) : super(key: key);
  final String labelBtn;
  final void Function() callBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = ref.watch(trainingTimerProvider);
    /// THIS VALIDATE IF THE BUTTON NEED TO SHOW DIALOG WHEN IS CLICKED
    /// OTHERWISE IT WILL DISPLAY A FAKE BUTTON WITH THE ONLY FUNCTION TO SHOW
    /// A TOOL TIP MSG THAT SAY -> [CLICK PLAY TO START TRAINING]
    return isShowDialogIconSelected(timer.currentState)
        ? IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(
                          'Are you sure you want to skip the Block?'),
                      content: const Text(
                          'If you skip the block wont be counted in your training stats. And this will affect your current progress.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            callBack();
                            if (timer.isFinishWorkOut) {
                              timer.saveAndExitTraining(context, ref);
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          child: const Text('Skip Block'),
                        )
                      ],
                    );
                  });
            },
            icon: const Icon(Icons.skip_next),
            iconSize: 50,
          )

        /// TODO THIS IS A FAKE BUTTON TO AVOID SHOW THE DIALOG MSG
        : IconButton(
            onPressed: () {},
            icon: const Icon(Icons.skip_next),
            iconSize: 50,
            tooltip: 'Click Play to Start Training',
          );
  }

  /// This validate if the Show Icon with dialog is selected.
  bool isShowDialogIconSelected(TimerState timerCurrentState) {
    switch (timerCurrentState) {
      case TimerState.unStarted:
        return false;

      case TimerState.waitBlock:
        return false;

      case TimerState.play:
        return true;

      case TimerState.pause:
        return true;

      case TimerState.stop:
        return false;

      case TimerState.rateTraining:
        return false;

      case TimerState.finishWorkOut:
        return false;
    }
  }
}
