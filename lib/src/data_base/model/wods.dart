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
}
