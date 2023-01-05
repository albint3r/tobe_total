import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/block_model_provider.dart';

/// A class that manages the state of a clicked block.
class BlockController {
  void setStateClickedBlockIDProvider(int id, WidgetRef ref) {
    /// Changes the state of the [clickedBlockIDProvider] to the given [id].
    /// This helps to change to the block insights and display all the moves.
    ///
    /// [ref] is a reference to the `WidgetRef` object.
    ref.watch(clickedBlockIDProvider.notifier).state = id;
  }
}

/// A `FutureProvider` that returns a `List` of `Map` objects representing
/// the movements of a block with a particular ID.
///
/// The provider depends on the `blocksModelProvider` and
/// `clickedBlockIDProvider` providers to get the data it needs.
final blockMovesInsideProvider = FutureProvider.autoDispose<List<Map<String, Object?>>>((ref) async {
  final blockModel = ref.watch(blocksModelProvider);
  final clickedBlockId = ref.watch(clickedBlockIDProvider);
  return blockModel.getBlocksMovementsById(clickedBlockId);
});

/// A provider that returns an instance of `BlockController`.
final blockControllerProvider = Provider<BlockController>((ref) {
  return BlockController();
});


