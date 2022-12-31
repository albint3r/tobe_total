// Imports
import 'package:tobe_total/src/data_base/db.dart';

class WODs extends LocalDataBase {
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
  Future<void> addNew(
      DateTime expectedTrainingDate,
      int day,
      String bodyArea,
      int totalBlocks,
      int totalTimeWorkOut) async {
    return await add(
        'wods',
        'expected_training_day, day, body_area, total_blocks, total_time_work_out',
        "'${expectedTrainingDate.year}-${expectedTrainingDate.month}-${expectedTrainingDate.day}', $day, '$bodyArea', $totalBlocks, $totalTimeWorkOut");
  }


  /// Gets the last Workout of the Day (WOD) identifier from the database.
  ///
  /// Returns the last WOD identifier as an `int`.
  Future<int> getLastWODId() async {
    List<Map<String, Object?>> response = await getLastId();
    return response[0]['last_insert_rowid()'] as int;
  }

  Future<List<Map<String, Object?>>> getWODs() async {
    // Get the profile of the user.
    return getAll('wods');
  }

  Future<List<Map<String, Object?>>> getAllMovementsInWod(int wodId) async {
    // Get the profile of the user.
    return rawQuery(
        'SELECT fm.id AS fm_id, w.id AS w_id, b.id AS b_id, b.mode, b.sets, fm.* FROM movement_history AS mh JOIN blocks AS b ON b.id = mh.blocks_id JOIN wods AS w ON w.id = b.wod_id JOIN fitness_moves AS fm ON fm.id = mh.fitness_move_id WHERE wod_id = $wodId');
  }

  Future<List<Map<String, Object?>>> getWeekExpectedTrainingDays(
      String startDayOfTheWeekDate) async {
    // Return a date between the started day of the week and the end of the week.
    return rawQuery(
        "SELECT * FROM wods WHERE expected_training_day >= '$startDayOfTheWeekDate'");
  }

  Future<List<Map<String, Object?>>> getTotalTrainedTime(
      String startDayOfTheWeekDate) async {
    // Return a date between the started day of the week and the end of the week.
    return rawQuery(
        "SELECT SUM(time) AS trained_time FROM wods JOIN blocks ON blocks.wod_id = wods.id WHERE expected_training_day > '$startDayOfTheWeekDate'");
  }

  Future<List<Map<String, Object?>>> getLastMuscleTrained() async {
    String query =
        'SELECT * FROM wods ORDER BY expected_training_day DESC LIMIT 1';
    return rawQuery(query);
  }
}
