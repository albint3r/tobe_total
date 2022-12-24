import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data_base/model/blocks.dart';


// TODO MOVE THIS TO ANOTHER FILE WITH ALL THE MODELS OF THE DB
final blocksModelProvider = StateProvider<Blocks>((ref) {
  // get the WOD Class
  return Blocks();
});

final blockIdProvider = StateProvider<int>((ref) {
  // This helps to make the change of screens between the Wod
  // to the specific block
  return -1;
});

