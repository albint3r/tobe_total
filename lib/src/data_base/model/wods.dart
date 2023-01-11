// Imports
import 'package:tobe_total/src/data_base/db.dart';

class WODs extends LocalDataBase {
  /// Checks if there are any WODs in the database.
  ///
  /// @return A `Future` that completes with a boolean indicating whether there are any WODs in the database.
  Future<bool> isWODsExist() async {
    // Check if there are any WODs in the database
    return await isAny('wods');
  }

  /// Adds a new Workout of the Day (WOD) to the `wods` table.
  ///
  /// [expectedTrainingDate] is the expected date for training.
  /// [day] is the day of the week for the training.
  /// [bodyArea] is the body area that the WOD will focus on.
  /// [totalBlocks] is the total number of blocks in the WOD.
  /// [totalTimeWorkOut] is the total time of the WOD, in seconds.
  Future<void> addNew(DateTime expectedTrainingDate, int day, String bodyArea,
      int totalBlocks, int totalTimeWorkOut, bool isExpired) async {
    return await add(
        'wods',
        'expected_training_day, day, body_area, total_blocks, total_time_work_out, expired',
        "'${expectedTrainingDate.toString().substring(0,10)}', $day, '$bodyArea', $totalBlocks, $totalTimeWorkOut, $isExpired");
  }

  /// Gets the last Workout of the Day (WOD) identifier from the database.
  ///
  /// Returns the last WOD identifier as an `int`.
  Future<int> getLastWODId() async {
    List<Map<String, Object?>> response = await getLastId();
    return response[0]['last_insert_rowid()'] as int;
  }

  /// Updates the total number of blocks in a specific Workout of the Day (WOD)
  /// after creating moves in the local database.
  ///
  /// This method performs a SQLite query that updates the
  /// `total_blocks` column in the `wods` table for the row with the
  /// specified WOD ID.
  ///
  /// @param [totalBlocks] The new total number of blocks for the WOD.
  /// @param [WODId] The ID of the WOD to update.
  /// @return A `Future` that completes with the result of the update operation.
  Future<void> updateBlocksInWodAfterCreateMoves(int totalBlocks,int WODId) async {
    String query = 'UPDATE wods SET total_blocks = $totalBlocks WHERE id= $WODId';
    await rawQuery(query);
    print('[updateBlocksInWodAfterCreateMoves]-> values of $WODId');
  }

  /// Retrieves all Workouts of the Day (WODs) from the local database.
  ///
  /// @return A `Future` that completes with a list of maps representing
  /// the WODs, where each map contains the column names and values as
  /// keys and values, respectively.
  Future<List<Map<String, Object?>>> getWODs() async {
    return getAll('wods');
  }

  /// Retrieves all movements in a specific Workout of the Day (WOD)
  /// from the local database.
  ///
  /// This method performs a SQLite query that joins the `movement_history`,
  /// `blocks`, `wods`, and `fitness_moves` tables and filters the results
  /// by the WOD ID. It selects the IDs and certain columns from all four
  /// tables, as well as all columns from the `fitness_moves` table.
  ///
  /// @param wodId The ID of the WOD to retrieve the movements for.
  /// @return A `Future` that completes with a list of maps representing
  /// the movements in the WOD, where each map contains the column names
  /// and values as keys and values, respectively.
  Future<List<Map<String, Object?>>> getAllMovementsInWod(int wodId) async {
    return rawQuery(
        'SELECT fm.id AS fm_id, w.id AS w_id, b.id AS b_id, b.mode, b.sets, fm.* FROM movement_history AS mh JOIN blocks AS b ON b.id = mh.blocks_id JOIN wods AS w ON w.id = b.wod_id JOIN fitness_moves AS fm ON fm.id = mh.fitness_move_id WHERE wod_id = $wodId');
  }

  /// Retrieves all Workouts of the Day (WODs) that are expected to be
  /// trained during a specific week from the local database.
  ///
  /// This method performs a SQLite query that filters the `wods` table
  /// by the `expected_training_day` column, selecting all rows where the
  /// `expected_training_day` is greater than or equal to the specified
  /// start date of the week.
  ///
  /// @param [startDayOfTheWeekDate] The start date of the week,
  /// in the format 'YYYY-MM-DD'.
  /// @return A `Future` that completes with a list of maps representing
  /// the WODs, where each map contains the column names and values as keys
  /// and values, respectively.
  Future<List<Map<String, Object?>>> getWeekExpectedTrainingDays(
      String startDayOfTheWeekDate) async {
    return rawQuery(
        "SELECT * FROM wods WHERE expected_training_day >= '$startDayOfTheWeekDate'");
  }

  /// Retrieves the total trained time for all Workouts of the Day (WODs)
  /// that were expected to be trained during a specific week
  /// from the local database.
  ///
  /// This method performs a SQLite query that joins the `wods` and `blocks`
  /// tables and filters the results by the `expected_training_day` column,
  /// selecting all rows where the `expected_training_day` is greater than
  /// the specified start date of the week. It then calculates the sum of
  /// the `time` column from the `blocks` table and returns it
  /// as the `trained_time` column.
  ///
  /// @param [startDayOfTheWeekDate] The start date of the week,
  /// in the format 'YYYY-MM-DD'.
  /// @return A `Future` that completes with a list of maps
  /// representing the trained time, where each map contains the
  /// column names and values as keys and values, respectively.
  Future<List<Map<String, Object?>>> getTotalTrainedTime(
      String startDayOfTheWeekDate) async {
    return rawQuery(
        "SELECT SUM(time) AS trained_time FROM wods JOIN blocks ON blocks.wod_id = wods.id WHERE expected_training_day > '$startDayOfTheWeekDate'");
  }

  /// Retrieves the Last Muscle Trained from the local database.
  ///
  /// This method performs a SQLite query that selects all columns from the
  /// `wods` table and sorts the results by the `expected_training_day`
  /// column in descending order. It then retrieves the first row of
  /// the sorted results.
  ///
  /// @return A `Future` that completes with a list of maps
  /// representing the last trained WOD, where each map contains the
  /// column names and values as keys and values, respectively.
  Future<List<Map<String, Object?>>> getLastMuscleTrained() async {
    String query =
        'SELECT * FROM wods ORDER BY expected_training_day DESC LIMIT 1';
    return rawQuery(query);
  }
}
