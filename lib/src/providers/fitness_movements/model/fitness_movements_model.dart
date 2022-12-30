import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data_base/model/fitness_movements.dart';

final fitnessMovementsProvider = Provider<FitnessMovements>((ref) {
  return FitnessMovements();
});
