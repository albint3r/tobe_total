import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/providers/routes/routes_provider.dart';
import 'package:tobe_total/src/providers/wod/model/wod_model_provider.dart';

import '../../../providers/training_oracle/settings_manager/settings_training_manager.dart';
import '../../../routes/const_url.dart';

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
                    "Are you sure all your training profile configuration are correct? Remember, you can't deleted automatically the Training Week, only manual."),
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
                      final wodModel = ref.watch(wodsModelProvider);
                      // check if is the first  training week to create
                      if(await wodModel.isWODsExist()) {
                        final trainingWeek =
                            await ref.watch(settingsManagerProvider).initTrainingCreation();
                        await trainingWeek.initContext();
                        await trainingWeek.initWODS();
                        await trainingWeek.initWODSBlocks();
                        final routes = ref.watch(routesProvider);
                        // TODO SOLVE THIS ERROR
                        // o safely refer to a widget's ancestor in its
                        // dispose() method, save a reference to the ancestor
                        // by calling dependOnInheritedWidgetOfExactType() in
                        // the widget's didChangeDependencies() method
                        routes.navigateTo(context, ConstantsUrls.updateLevel);
                      } else {
                        final routes = ref.watch(routesProvider);
                        routes.navigateTo(context, ConstantsUrls.updateLevel);
                      }

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
