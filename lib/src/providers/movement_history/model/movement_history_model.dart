import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data_base/model/movement_history.dart';


final movementHistoryModelProvider = Provider<MovementHistory>((ref) {
  return MovementHistory();
});
