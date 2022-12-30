// Imports
import 'package:tobe_total/src/data_base/db.dart';

class FitnessMovements extends LocalDataBase {
  Future<bool> isFitnessMovementsExist() async {
    // Check if exist any user in the database
    return await isAny('fitness_movements');
  }

  Future<List<Map<String, Object?>>> getAllMoves() async {
    // Get the profile of the user.
    return getAll('fitness_movements');
  }

  Future<List<Map<String, Object?>>> getPossibleMoves() async {
    // Get the profile of the user.
    String query = '';
    return rawQuery(query);
  }
}
