import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../providers/timer/model/training_timer.dart';
import '../../../../sign_in_and_update/presentation/fields/rate_training.dart';

class RateBlockDialog extends ConsumerStatefulWidget {
  const RateBlockDialog({
    required this.timer,
    Key? key,
  }) : super(key: key);
  final TrainingTimerModel timer;

  @override
  ConsumerState createState() => _RateBlockDialogState();
}

class _RateBlockDialogState extends ConsumerState<RateBlockDialog> {
  @override
  void initState() {
    super.initState();
    _showDialog();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  _showDialog() async {
    await Future.delayed(const Duration(milliseconds: 50));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Evaluate the Trained Block'),
          content: Column(
            children: const [GroupRateTrainingFields()],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  widget.timer.setDidBlock();
                  widget.timer.stopTimer();
                  // Check if close pop up or navigate to progress
                  if (widget.timer.isFinishWorkOut) {
                    widget.timer.saveAndExitTraining(context, ref);
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: const Text('Save Results'))
          ],
        );
      },
    );
  }
}
