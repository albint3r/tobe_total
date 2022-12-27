import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/movement_history_model.dart';

final difficultyCountProvider =
    FutureProvider<Map<dynamic, dynamic>>((ref) async {
  // Create a dict with the total of the difficulty count
  // and a list of the results
  final movementHistoryModel = ref.watch(movementHistoryModelProvider);
  final difficultyCount = await movementHistoryModel.getDifficultyCount();
  Map result = {'total': 0, 'difficulties': {}};
  for (Map data in difficultyCount) {
    result['total'] = result['total'] + data['difficulty_count'];
  }
  result['difficulties'] = difficultyCount;
  return result;
});
