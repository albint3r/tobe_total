// Imports
import 'package:tobe_total/src/providers/proxies/movement_proxy.dart';

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
    print('query------------- $query');
    return rawQuery(query);
  }

  Future<List<Map<String, Object?>>> getWodMovements(
      {required int wodId}) {
    String query =
        'SELECT mh. create_date ,mh.id, mh.fitness_move_id, mh.blocks_id, mh.reps, mh.rest_time, mh.weight, mh.created_manual, mh.edited, mh.did_exercise, mh.did_all_train_work, mh.why_cant_do_all_work, mh.can_do_more, fm.name, fm.yt_url, fm.muscle_prota, fm.body_area, fm.difficulty, fm.movement_pattern, fm.dynamic FROM movement_history as mh JOIN fitness_moves as fm ON mh.fitness_move_id = fm.id JOIN blocks as b ON b.id = mh.blocks_id    WHERE wod_id = $wodId';
    return rawQuery(query);
  }

  Future<List<Map<String, Object?>>> updateRateMovement(
      {required ProxyMovement move}) {
    String query = 'UPDATE movement_history SET did_exercise = ${move.didExercise ?? 'FALSE'}, did_all_train_work = ${move.didAllReps ?? 'FALSE'}, can_do_more = ${move.canDoMore ?? 'FALSE'} WHERE id = ${move.id};';
    return rawQuery(query);
  }

  Future<List<Map<String, Object?>>> getTrainedMovementsOfTheCurrentWeek(String startDayOfTheWeek) async {
    String query = 'SELECT * FROM movement_history AS mh JOIN blocks AS b ON b.id = mh.blocks_id JOIN wods AS w ON w.id = b.wod_id JOIN fitness_moves AS fm ON fm.id = mh.fitness_move_id WHERE w.expected_training_day >= "$startDayOfTheWeek" AND w.did_wod';
    return rawQuery(query);
  }


}
