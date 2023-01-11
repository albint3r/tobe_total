// Imports
import '../data/db.dart';

/// A class that manages the `my_movements` table in the database.
class MyMovements extends LocalDataBase {
  /// Checks if the `my_movements` table has any rows.
  Future<bool> isMyMovementsExist() async {
    // Check if exist any user in the database
    return await isAny('my_movements');
  }

  /// Adds a new row to the `my_movements` table with the given [fitnessMoveId].
  Future<void> addNew(int fitnessMoveId) async {
    return await add(
      'my_movements',
      'fitness_move_id',
      "$fitnessMoveId",
    );
  }

  /// Checks if the given [moveId] exists in the `my_movements` table.
  /// Returns true if the ID [not exist].
  Future<bool> notExistID(int moveId) async {
    // Check if the Id already exist in MyMovements
    // Return true if the ID [not exist.]
    String query = 'SELECT * FROM my_movements WHERE id = $moveId';
    final response = await rawQuery(query);
    return response.isEmpty;
  }

  /// Gets all rows from the `my_movements` table.
  Future<List<Map<String, Object?>>> getAllMoves() async {
    return getAll('my_movements');
  }

  /// Gets all rows from the `my_movements` table.
  Future<List<Map<String, Object?>>> getAllMovesStats() async {
    String query = 'SELECT * FROM my_movements AS mm JOIN fitness_moves AS fm ON fm.id = mm.fitness_move_id ORDER BY difficulty, name';
    return rawQuery(query);
  }

  /// Gets all rows from the `my_movements` table where the
  /// `learned` column is `false`.
  Future<List<Map<String, Object?>>> getAllNoLearned() async {
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

  /// Gets all rows from the `fitness_moves` table that meet the
  /// given query parameters and
  /// where the `movement_pattern` column is
  /// not equal to the given [lastMovementPattern].
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
