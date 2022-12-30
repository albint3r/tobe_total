// Imports
import 'package:tobe_total/src/data_base/db.dart';

class MovementHistory extends LocalDataBase {
  Future<bool> isMovementHistoryExist() async {
// Check if exist any user in the database
    return await isAny('movement_history');
  }

  Future<void> addNew(int fitnessMoveId, int blocksId) async {
    return await add(
      'movement_history',
      'fitness_move_id, blocks_id',
      "$fitnessMoveId, $blocksId",
    );
  }

  Future<List<Map<String, Object?>>> getWODs() async {
// Get the profile of the user.
    return getAll('movement_history');
  }

  Future<List<Map<String, Object?>>> getDifficultyCount() {
    String query =
        'SELECT fm.difficulty AS name,COUNT(fm.difficulty) AS difficulty_count FROM movement_history AS mh JOIN blocks AS b ON b.id = mh.blocks_id JOIN wods AS w ON w.id = b.wod_id JOIN fitness_moves AS fm ON fm.id = mh.fitness_move_id WHERE expected_training_day >= "2022-12-26" GROUP BY fm.difficulty';
    return rawQuery(query);
  }
}
