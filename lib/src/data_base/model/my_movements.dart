// Imports
import 'package:tobe_total/src/data_base/db.dart';

class MyMovements extends LocalDataBase {
  Future<bool> isMyMovementsExist() async {
// Check if exist any user in the database
    return await isAny('my_movements');
  }

  Future<bool> notExistID(int moveId) async {
    // Check if the Id already exist in MyMovements
    // Return true if the ID [not exist.]
    String query = 'SELECT * FROM my_movements WHERE id = $moveId';
    final response = await rawQuery(query);
    return response.isEmpty;
  }

  Future<List<Map<String, Object?>>> getAllMoves() async {
// Get the profile of the user.
    return getAll('my_movements');
  }

  Future<List<Map<String, Object?>>> getAllNoLearned() async {
// Get the profile of the user.
    String query = 'SELECT * FROM my_movements WHERE learned = FALSE';
    return rawQuery(query);
  }


  // TODO PUEDE QUE LOS DOS METODOS DE ABAJO SE MUEVAN A
  // FITNESS MOVEMENTS, YA QUE AMBOS LLAMAN A ESA BASE DE DATOS Y NO A ESTA
  Future<List<Map<String, Object?>>> getAllPossibleMovements(
    String selectedQueryBodyArea,
    String selectedQueryDifficulty,
    String selectedQueryEquipment,
  ) async {
// Get the profile of the user.
    String query =
        "SELECT * FROM (SELECT * FROM (SELECT * FROM fitness_moves $selectedQueryBodyArea) $selectedQueryDifficulty) $selectedQueryEquipment";
    return rawQuery(query);
  }

  Future<List<Map<String, Object?>>> getAllPossibleMovementsNotCollidePrev(
      String selectedQueryBodyArea,
      String selectedQueryDifficulty,
      String selectedQueryEquipment,
      String lastMovementPattern) async {
// Get the profile of the user.
    String query =
        "SELECT * FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM fitness_moves $selectedQueryBodyArea) $selectedQueryDifficulty) $selectedQueryEquipment) WHERE NOT movement_pattern = '$lastMovementPattern'";
    return rawQuery(query);
  }
}
