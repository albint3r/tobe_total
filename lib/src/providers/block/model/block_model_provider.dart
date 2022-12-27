import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data_base/model/blocks.dart';

final blocksModelProvider = StateProvider<Blocks>((ref) {
  // get the WOD Class
  return Blocks();
});
