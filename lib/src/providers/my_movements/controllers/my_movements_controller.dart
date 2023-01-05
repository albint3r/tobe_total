import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/my_movements_model.dart';

/// A provider that asynchronously retrieves all rows from the
/// `my_movements` table.
final allMyMovementsProvider =
    FutureProvider.autoDispose<List<Map<String, Object?>>>((ref) async {
  final myMovementsModel = ref.watch(myMovementsProvider);
  return myMovementsModel.getAllMovesStats();
});

final myMovementControllerProvider = Provider<MyMovementControllers>((ref) {
  return MyMovementControllers();
});

/// A state provider that stores a string value.
final queryMyMovementFilteredProvider =
StateProvider.autoDispose<List<String>>((ref) {
  /// Returns an initial value for the state, in this case an empty string.
  return [''];
});

/// [MyMovementControllers] is a class that provides two methods to generate
/// progress values based on either a difficulty level or a learning level.
///
/// The [difficulty] level is a string that can be one of 'beginner',
/// 'intermediate', 'advanced', or 'elit', and the progress value is
/// a double between 0 and 1, where 0 represents no progress and 1 represents
/// maximum progress.
///
/// The [learning] level is an integer that represents a student's
/// current level of learning, and the progress value is also a
/// double between 0 and 1, where 0 represents no progress and 1
/// represents maximum progress. If the learning level is greater
/// than 10, the maximum progress value of 1 is returned.

class MyMovementControllers {
  /// Generates a search result for a list of moves.
  ///
  /// The search result is a map that maps the names of the moves to the maps
  /// representing the moves. The names and maps are obtained from the
  /// [allMyMovements] list.
  ///
  /// Returns the search result as a map.
  Map<String, Map> generateMyMoveSearch(List<Map> allMyMovements) {
    Map<String, Map> finalResult = {};
    for (Map move in allMyMovements) {
      finalResult[move['name']] = move;
    }
    return finalResult;
  }

  /// Sets the state of the `queryMyMovementFilteredProvider` state provider.
  ///
  /// The [moveQuery] parameter is the new value for the state. The [ref]
  /// parameter is a reference to a widget that can be used to access the
  /// state provider.
  void setStateQueryMyMovementFilteredProvider(
      String moveQuery, WidgetRef ref) {
    ref.watch(queryMyMovementFilteredProvider.notifier).state = [moveQuery];
  }

  /// Generates a difficulty progress value based on the provided
  /// difficulty level.
  ///
  /// [difficulty] A string representing the difficulty level.
  /// Can be 'beginner',
  /// 'intermediate', 'advanced', or 'elit'.
  /// Returns a double between 0 and 1 representing the progress for the provided
  /// difficulty level.
  double generateDifficultyProgress(String difficulty) {
    Map<String, double> difficultyConversion = {
      'beginner': .25,
      'intermediate': .50,
      'advanced': .75,
      'elit': 1,
    };
    return difficultyConversion[difficulty]!;
  }

  // Generates a learning level progress value based on the provided learning level.
  ///
  /// [level] An integer representing the current learning level.
  /// Returns a double between 0 and 1 representing the progress for the provided
  /// learning level. If the learning level is greater than 10, the maximum progress
  /// value of 1 is returned.
  double generateLearningLevelProgress(int learnedLevel) {
    if (learnedLevel > 10) {
      return 1;
    }
    return learnedLevel / 10;
  }
}

final equipmentTranslateProvider = Provider<Map<String, String>>((ref) {
  // Declaration of the equipment translation map
  return {
    'noEquipment': 'No Equipment',
    'dumbbells': 'Dumbbells',
    'kettlebells': 'Kettlebells',
    'bench': 'Bench',
    'barbell': 'Barbell',
    'weightMachinesSelectorized': 'Weight Machines Selectorized',
    'resistanceBandsCables': 'Resistance Bands Cables',
    'leggings': 'Leggings',
    'medicineBall': 'Medicine Ball',
    'stabilityBall': 'Stability Ball',
    'ball': 'Ball',
    'trx': 'TRX',
    'raisedPlatformBox': 'Raised Platform Box',
    'box': 'Box',
    'rings': 'Rings',
    'pullUpBar': 'Pull Up Bar',
    'parallelsBar': 'Parallels Bar',
    'wall': 'Wall',
    'pole': 'Pole',
    'trineo': 'Trineo',
    'rope': 'Rope',
    'wheel': 'Wheel',
    'assaultBike': 'Assault Bike',
  };
});

