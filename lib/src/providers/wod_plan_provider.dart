import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data_base/model/blocks.dart';


class WODPlanController {

  void setStateWodIdProvider(WidgetRef ref, int wodId) {
    // Change the state of the [wodIdProvider] for the Id of the WOD selected.
    ref.watch(wodIdProvider.notifier).state = wodId;
  }

  void setStateSelectedWodInformation(WidgetRef ref, Map wod) {
    // This set the state of the current WOD information select to display
    // the data in the next screen.
    ref.watch(selectedWodInformationProvider.notifier).state = wod;
  }

}

final blocksModelProvider = StateProvider<Blocks>((ref) {
  // get the WOD Class
  return Blocks();
});

final wodPlanControllerProvider = Provider<WODPlanController>((ref) {
  // Gre the WOd Plan Controller
  return WODPlanController();
});

final selectedWodInformationProvider = StateProvider<Map>((ref) {
  // This help to select the current information of the WOD Card
  return {};
});

final wodIdProvider = StateProvider<int>((ref) {
  // This helps to make the change of screens between the calendar
  // to the wod information
  return -1;
});


final blocksInWodListProvider = FutureProvider.autoDispose<List<Map<String, Object?>>>((ref) async {
  // This return a list of block inside the Wod Selected in calendar.
  // The ID of the wod is provider by the [wodIdProvider].
  final blocks = ref.watch(blocksModelProvider);
  final wodId = ref.watch(wodIdProvider);
  return blocks.getBlocksByWodId(wodId);
});
