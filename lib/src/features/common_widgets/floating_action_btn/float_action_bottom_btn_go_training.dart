import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/providers/routes/routes_provider.dart';
import '../../../providers/block/model/block_model_provider.dart';
import '../../../providers/movement_history/model/movement_history_model.dart';
import '../../../providers/proxies/block_proxy.dart';
import '../../../providers/proxies/wod_proxy.dart';
import '../../../providers/wod/model/wod_model_provider.dart';
import '../../../routes/const_url.dart';

class GoToNextTrainingOFTheWeek extends ConsumerWidget {
  const GoToNextTrainingOFTheWeek({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final route = ref.watch(routesProvider);
    final wodModel = ref.watch(wodsModelProvider);
    final blockModel = ref.watch(blocksModelProvider);
    final movementHistoryModel = ref.watch(movementHistoryModelProvider);

    return FloatingActionButton(
      tooltip: 'Go to your next Training of the week',
      onPressed: () async {
        try {
          List<Map<String, Object?>> todayTraining =
              await wodModel.getTodayTraining();
          List<Map<String, Object?>> blocksInWod =
              await blockModel.getBlocksByWodId(todayTraining[0]['id'] as int);
          List<Map<String, Object?>> movesInBlocks = await movementHistoryModel
              .getWodMovements(wodId: todayTraining[0]['id'] as int);
          if (todayTraining.isNotEmpty) {
            // TODO ENCAPSULATE THIS
            // this generate all the data before the Clock is display.
            // This helps in the next points:
            // The timer use StateNotifier, so when it change, refresh everything
            // and this would cause errors.
            // Charge the date before ensure no errors.
            ref.watch(todayTrainingWodProvider.notifier).state =
                todayTraining[0];
            ref.watch(blocksInWodProxyProvider.notifier).state = blocksInWod;
            ref.watch(movementInBlockWodProxyProvider.notifier).state =
                movesInBlocks;
            route.navigateTo(context, ConstantsUrls.trainingTimer);
          } else {
            showAlertDialogNoTrainingsToday(context);
          }
        } catch (e) {
          showAlertDialogNoTrainingsToday(context);
        }
      },
      child: const Icon(Icons.navigate_next),
    );
  }

  Future<dynamic> showAlertDialogNoTrainingsToday(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Sorry, you don't have trainings todaty!"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                      'Rest, relax and stay focus in your progress, you could go to our website to lear more about fitness.'),
                ),
                TextButton(
                  onPressed: () {
                    launchUrl(
                      Uri.parse('http://www.myfitnessgym.com.mx/'),
                    );
                  },
                  child: const Text('http://www.myfitnessgym.com.mx/'),
                )
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            )
          ],
        );
      },
    );
  }
}
