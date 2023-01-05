import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/features/my_movements/presentation/search_filter.dart';
import '../../common_widgets/headers_screens/header_screens.dart';
import '../../common_widgets/movement_stats/card_movement_stats.dart';

class MyMovementsDisplay extends ConsumerStatefulWidget {
  const MyMovementsDisplay({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _MyMovementsDisplayState();
}

class _MyMovementsDisplayState extends ConsumerState<MyMovementsDisplay> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: const [
        H1Screens(
          header: 'My Movements',
          isInListView: true,
        ),
        SubTitleHeaderH1(subHeader: 'Learn more about your movements'),
        SearchFilter(),
        CardsMovementStats(),
      ],
    );
  }
}
