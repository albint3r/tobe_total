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
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                    'Confirm Training Week Creation'),
                content: const Text(
                    "Are you sure all your training profile configuration are correct? Remember, you can't deleted automatically the Training Week, only manual.  "),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      final trainingWeek =
                          await ref.watch(settingsManagerProvider).initTrainingCreation();
                      await trainingWeek.initContext();
                      await trainingWeek.initWODS();
                      await trainingWeek.initWODSBlocks();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Your training was created'),
                          elevation: 5,
                        ),
                      );
                    },
                    child: const Text("Yes, I'm sure!"),
                  ),
                ],
              );
            });
      },
      child: const Icon(Icons.add),
    );
  }
}
