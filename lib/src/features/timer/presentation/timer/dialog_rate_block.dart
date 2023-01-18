import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../providers/timer/model/training_timer.dart';
import '../../../common_widgets/headers_screens/header_screens.dart';
import '../../../sign_in_and_update/presentation/fields/rate_training.dart';

class RateBlocksDialog extends ConsumerStatefulWidget {
  const RateBlocksDialog({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _RateBlocksDialogState();
}

class _RateBlocksDialogState extends ConsumerState<RateBlocksDialog> {
  @override
  Widget build(BuildContext context) {
    final timer = ref.watch(trainingTimerProvider);
    if (timer.currentState != TimerState.rateTraining) {
      return const Text('');
    }
    print('------------------');
    print(timer.proxyWod.currentBlockProcessing);
    print(timer.proxyWod.currentBlockProcessing);
    print(timer.proxyWod.currentBlockProcessing!.movements[66]);
    return Card(
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            H3FormFieldsHeader(header: 'Aqui el titulo',),
            RateTrainingCheckFields(move: timer.proxyWod.currentBlockProcessing!.movements[66]!,),
            TextButton(onPressed: () {
              print('timer.stopTimer()-----------------------');
              timer.stopTimer();
            }, child: Text('Close'))
          ],
        ),
      ),
    );
  }
}
