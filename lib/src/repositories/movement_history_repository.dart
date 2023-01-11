// Imports
import '../data/db.dart';

class MovementHistory extends LocalDataBase {
  /// Check if any Movement History exist in the local database
  /// Returns a future boolean, true if Movement History exist,
  /// false otherwise
  Future<bool> isMovementHistoryExist() async {
    return await isAny('movement_history');
  }

  /// Adds a new entry to the 'movement_history' table with the specified
  /// 'fitnessMoveId' and 'blocksId' values.
  ///
  /// Returns a [Future] that completes when the operation is finished.
  Future<void> addNew(int fitnessMoveId, int blocksId) async {
    return await add(
      'movement_history',
      'fitness_move_id, blocks_id',
      "$fitnessMoveId, $blocksId",
    );
  }

  // Retrieves all WODs from the 'movement_history' table in the local database.
  ///
  /// Returns a Future List of maps containing the data of the WODs
  Future<List<Map<String, Object?>>> getWODs() async {
    return getAll('movement_history');
  }

  /// Get the count of difficulty
  ///
  /// [startDayOfTheWeek] is the initial day of the week,
  /// This is the day where the data of the difficulty will be pulled
  Future<List<Map<String, Object?>>> getDifficultyCount(
      {required String startDayOfTheWeek}) {
    String query =
        'SELECT fm.difficulty AS name,COUNT(fm.difficulty) AS difficulty_count FROM movement_history AS mh JOIN blocks AS b ON b.id = mh.blocks_id JOIN wods AS w ON w.id = b.wod_id JOIN fitness_moves AS fm ON fm.id = mh.fitness_move_id WHERE expected_training_day >= "$startDayOfTheWeek" GROUP BY fm.difficulty';
    return rawQuery(query);
  }
}
