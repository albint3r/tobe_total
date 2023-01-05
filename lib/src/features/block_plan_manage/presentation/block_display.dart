import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/block/model/block_model_provider.dart';
import '../../common_widgets/headers_screens/header_screens.dart';
import '../../common_widgets/movement_stats/card_movement_stats.dart';

class BlockDisplay extends ConsumerStatefulWidget {
  const BlockDisplay({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _BlockDisplayState();
}

class _BlockDisplayState extends ConsumerState<BlockDisplay> {
  @override
  Widget build(BuildContext context) {
    final blockId = ref.watch(clickedBlockIDProvider);
    return ListView(
      shrinkWrap: true,
      children: [
        H1Screens(
          header: 'Block #$blockId Information',
          isInListView: true,
        ),
        const SubTitleHeaderH1(subHeader: 'This are the moves for the block'),
        const CardsMovementStats(),
      ],
    );
  }
}
