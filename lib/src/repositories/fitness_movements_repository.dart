// Imports
import '../data/db.dart';

class FitnessMovements extends LocalDataBase {
  /// Check if any fitness movements exist in the local database
  /// Returns a future boolean, true if fitness movements exist, false otherwise
  Future<bool> isFitnessMovementsExist() async {
    // Check if exist any user in the database
    return await isAny('fitness_movements');
  }

  /// Retrieves all fitness movements from the local database
  /// Returns a future list of maps containing the data of the fitness movements
  Future<List<Map<String, Object?>>> getAllMoves() async {
    // Get the profile of the user.
    return getAll('fitness_movements');
  }
}
