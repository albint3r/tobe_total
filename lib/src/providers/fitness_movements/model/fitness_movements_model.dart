import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../repositories/fitness_movements_repository.dart';

final fitnessMovementsProvider = Provider<FitnessMovements>((ref) {
  return FitnessMovements();
});
