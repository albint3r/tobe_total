import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../repositories/my_movements_repository.dart';

final myMovementsProvider = Provider<MyMovements>((ref) {
  return MyMovements();
});
