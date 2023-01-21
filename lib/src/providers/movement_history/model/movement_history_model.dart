import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../repositories/movement_history_repository.dart';

final movementHistoryModelProvider = Provider<MovementHistory>((ref) {
  return MovementHistory();
});

final caloriesBurnPerMinuteByDifficultyProvider = Provider<Map<String, int>>((ref) {
  // In strength training, there are different levels of intensity that can
  // affect the number of calories burned. Some examples of different levels of intensity are:
  //
  // Light training: This refers to an activity that is performed with
  // moderate weights and a high number of repetitions (more than 12).
  // The goal is to improve muscle endurance and flexibility. The range of
  // calories burned at this level of intensity is 3 to 4 calories per minute.
  //
  // Moderate training: At this level, slightly heavier weights are used and
  // fewer repetitions (8-12) are performed. The goal is to improve muscle
  // strength and size. The range of calories burned at this level of
  // intensity is 4 to 6 calories per minute.
  //
  // Intense training: This refers to an activity that is performed with
  // very heavy weights and a low number of repetitions (less than 8).
  // The goal is to increase muscle mass and strength. The range of
  // calories burned at this level of intensity is 5 to 7 calories per minute.
  //
  // Note that these are just examples and values may vary depending on
  // the person. Activity monitors are the most accurate way to measure
  // calories burned during a specific exercise.
  return {
    'beginner': 4,
    'intermediate': 4,
    'advanced': 12,
    'elit': 7,
  };
});
