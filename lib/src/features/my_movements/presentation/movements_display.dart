import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common_widgets/headers_screens/header_screens.dart';
import '../../common_widgets/movement_stats/card_movement_stats.dart';

class MyMovementsDisplay extends ConsumerWidget {
  const MyMovementsDisplay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      shrinkWrap: true,
      children: const [
        H1Screens(
          header: 'My Movements',
          isInListView: true,
        ),
        SubTitleHeaderH1(subHeader: 'Learn more about your movements'),
        CardsMovementStats(),
      ],
    );
  }
}
