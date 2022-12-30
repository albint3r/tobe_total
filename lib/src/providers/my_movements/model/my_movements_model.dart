import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data_base/model/my_movements.dart';

final myMovementsProvider = Provider<MyMovements>((ref) {
  return MyMovements();
});
