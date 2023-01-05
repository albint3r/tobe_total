import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data_base/model/blocks.dart';

/// A `StateProvider` that returns an instance of the `Blocks` class.
final blocksModelProvider = StateProvider<Blocks>((ref) {
  // get the WOD Class
  return Blocks();
});


/// A `StateProvider` that holds the ID of the clicked block.
///
/// The provider is initialized to -1 to avoid errors.
final clickedBlockIDProvider = StateProvider.autoDispose<int>((ref) {
  // This helps to make the change of screens between the Wod
  // to the specific block
  return -1;
});

