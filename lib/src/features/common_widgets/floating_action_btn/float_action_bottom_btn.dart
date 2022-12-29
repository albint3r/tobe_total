import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/training_oracle/training_week_state_machine/training_week_state_machine_provider.dart';

class CreateNewWeekActionBtn extends ConsumerWidget {
  const CreateNewWeekActionBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      tooltip: 'Create a new Training Week',
      onPressed: () async {
        final trainingWeek = await ref.watch(trainingManagerProvider).initTrainingCreation();
        print('-------------trainingWeek---');
        print(trainingWeek);
      },
      child: const Icon(Icons.add),
    );
  }
}
