import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/features/wod_plan_manage/presentation/metrics_wod_info.dart';
import '../../../providers/wod_plan_provider.dart';
import '../../common_widgets/headers_screens/header_screens.dart';
import '../../common_widgets/stats_main_display/stats_main_display.dart';
import 'card_blocks_in_wod.dart';


class WODDisplay extends ConsumerWidget {
  const WODDisplay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(blocksInWodListProvider).when(
        error: (err, stack) => Text('Error: $err'),
        loading: () => const CircularProgressIndicator(),
        data: (blockInData) {
          return ListView(
            children: [
              H1Screens(
                header: 'WOD Information #${ref.watch(wodIdProvider)}',
                isInListView: true,
              ),
              const SubTitleHeaderH1(
                  subHeader: 'Manage the Blocks of the WOD information.'),
              const StatsMainDisplay(
                // this are teh Chart displayed in the Dashboard
                child: StatsWOD(),
              ),
              // TODO CREATE A WIDGET TO THIS KIND OF HEADERS IN THE APP.
              // The problem right now is We don't have a purpose for that button,
              // but could be cool add some animations or filtering to make better de UX.
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                H3FormFieldsHeader(header: 'Blocks Information:'),
              ]),
              // This method crate all the blocks in the WOD.
              ...getStatsOfAllBlocksInWod(blockInData),
            ],
          );
        });
  }

  List<Widget> getStatsOfAllBlocksInWod(
      List<Map<String, Object?>> blockInData) {
    List<Widget> blocksList = [];
    if (blockInData.isNotEmpty) {
      for (Map block in blockInData) {
        // Create a single Block to concatenate with all the block
        // to create the UI.
        Widget blockCard = CardBlockInWOD(block: block);
        blocksList.add(blockCard);
      }
    }
    return blocksList;
  }
}


