// Imports
import 'package:tobe_total/src/data_base/db.dart';

class WODs extends LocalDataBase {
  Future<bool> isWODsExist() async {
    // Check if exist any user in the database
    return await isAny('wods');
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

  Future<List<Map<String, Object?>>> getWeekExpectedTrainingDays(String startDayOfTheWeekDate) async {
    // Return a date between the started day of the week and the end of the week.
    return rawQuery(
        "SELECT * FROM wods WHERE expected_training_day >= '$startDayOfTheWeekDate'");
  }

  Future<List<Map<String, Object?>>> getTotalTrainedTime(String startDayOfTheWeekDate) async {
    // Return a date between the started day of the week and the end of the week.
    return rawQuery(
        "SELECT SUM(time) AS trained_time FROM wods JOIN blocks ON blocks.wod_id = wods.id WHERE expected_training_day > '$startDayOfTheWeekDate'");
  }

  Future<List<Map<String, Object?>>> getLastMuscleTrained() async {
    String query = 'SELECT * FROM wods ORDER BY expected_training_day DESC LIMIT 1';
    return rawQuery(query);
  }


}
