import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../repositories/movement_history_repository.dart';

final movementHistoryModelProvider = Provider<MovementHistory>((ref) {
  return MovementHistory();
});

final caloriesBurnPerMinuteByDifficultyProvider = Provider<Map<String, int>>((ref) {

  return {
    'beginner': 4,
    'intermediate': 4,
    'advanced': 12,
    'elit': 7,
  };
});
