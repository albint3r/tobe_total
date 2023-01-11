import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../repositories/movement_history_repository.dart';


final movementHistoryModelProvider = Provider<MovementHistory>((ref) {
  return MovementHistory();
});
