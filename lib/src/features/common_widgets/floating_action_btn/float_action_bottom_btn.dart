import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/cliente/model/cliente_model_provider.dart';
import '../../../providers/training_oracle/training_week_state_machine/training_week_state_machine_provider.dart';

class CreateNewWeekActionBtn extends ConsumerWidget {
  const CreateNewWeekActionBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      tooltip: 'Create a new Training Week',
      onPressed: () {
        ref.watch(clientProvider);
        ref.watch(trainingWeekStateMachineProvider).getExpectedWodDuration();
        print(ref.watch(trainingWeekStateMachineProvider).getBlocksCombinationsDuration([10,15,20], 20));

      },
      child: const Icon(Icons.add),
    );
  }
}
