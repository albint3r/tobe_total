import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/providers/routes/routes_provider.dart';
import '../../../providers/block/model/block_model_provider.dart';
import '../../../providers/movement_history/model/movement_history_model.dart';
import '../../../providers/proxies/block_proxy.dart';
import '../../../providers/proxies/wod_proxy.dart';
import '../../../providers/wod/model/wod_model_provider.dart';
import '../../../repositories/movement_history_repository.dart';
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
        List<Map<String, Object?>> todayTraining = await wodModel.getTodayTraining();
        List<Map<String, Object?>> blocksInWod = await blockModel.getBlocksByWodId(todayTraining[0]['id'] as int);
        List<Map<String, Object?>> movesInBlocks = await movementHistoryModel.getWodMovements(wodId: todayTraining[0]['id'] as int);
        if (todayTraining.isNotEmpty) {
          // TODO ENCAPSULATE THIS
          // this generate all the data before the Clock is display.
          // This helps in the next points:
          // The timer use StateNotifier, so when it change, refresh everything
          // and this would cause errors.
          // Charge the date before ensure no errors.
          ref.watch(todayTrainingWodProvider.notifier).state = todayTraining[0];
          ref.watch(blocksInWodProxyProvider.notifier).state = blocksInWod;
          ref.watch(movementInBlockWodProxyProvider.notifier).state = movesInBlocks;
          route.navigateTo(context, ConstantsUrls.trainingTimer);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("You don't have trainings today"),
            elevation: 5,
          ));
        }
      },
      child: const Icon(Icons.navigate_next),
    );
  }
}
