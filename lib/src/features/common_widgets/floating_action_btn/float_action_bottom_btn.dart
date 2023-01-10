import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/training_oracle/settings_manager/settings_training_manager.dart';

class CreateNewWeekActionBtn extends ConsumerWidget {
  const CreateNewWeekActionBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      tooltip: 'Create a new Training Week',
      onPressed: () async {
        final trainingWeek = await ref.watch(settingsManagerProvider).initTrainingCreation();
        await trainingWeek.initContext();
        await trainingWeek.initWODS();
        await trainingWeek.initWODSBlocks();
      },
      child: const Icon(Icons.add),
    );
  }
}
