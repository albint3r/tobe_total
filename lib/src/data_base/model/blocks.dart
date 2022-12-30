// Imports
import 'package:tobe_total/src/data_base/db.dart';

class Blocks extends LocalDataBase {
  /// Checks if there are any Workouts of the Day (WODs) in the database.
  ///
  /// Returns `true` if there are any WODs, `false` otherwise.
  Future<bool> isWODsExist() async {
    // Check if there are any rows in the 'wods' table.
    return await isAny('wods');
  }

  /// Adds a new Workout of the Day (WOD) to the `wods` table.
  ///
  /// [WODId] is the unique identifier for the WOD.
  /// [mode] is the mode of the WOD (e.g. "For Time", "Rounds").
  /// [sets] is the number of sets in the WOD.
  /// [blockDuration] is the duration of each set in the WOD, in seconds.
  /// [totalMoves] is the total number of movements in the WOD.
  Future<void> addNew(int WODId, String mode, int sets, int blockDuration,
      int totalMoves) async {
    return await add('blocks', 'wod_id, mode, sets, time, total_movements',
        "$WODId, '$mode', $sets, $blockDuration, $totalMoves");
  }

  /// Gets all Workouts of the Day (WODs) from the database.
  ///
  /// Returns a list of maps representing the WODs. Each map contains the column
  /// names and values of a row in the `wods` table.
  Future<List<Map<String, Object?>>> getWODs() async {
    // Get all rows from the 'wods' table.
    return getAll('wods');
  }

  /// Gets all blocks for a given Workout of the Day (WOD) from the database.
  ///
  /// [wodId] is the identifier of the WOD.
  ///
  /// Returns a list of maps representing the blocks. Each map contains the column
  /// names and values of a row in the `blocks` table.
  Future<List<Map<String, Object?>>> getBlocksByWodId(int wodId) async {
    // Get all rows from the 'blocks' table that have a matching 'wod_id'.
    return getFiltered('blocks', 'wod_id', '$wodId');
  }

  /// Gets the last block identifier from the database.
  ///
  /// Returns the last block identifier as an `int`.
  Future<int> getLastBlockId() async {
    List<Map<String, Object?>> response = await getLastId();
    return response[0]['last_insert_rowid()'] as int;
  }
}
