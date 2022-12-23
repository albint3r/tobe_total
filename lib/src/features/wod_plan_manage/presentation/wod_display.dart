import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/features/common_widgets/cards_below_main_display/cards_in_parent.dart';
import 'package:tobe_total/src/features/wod_plan_manage/presentation/stats_wod.dart';
import '../../../providers/wod_plan_provider.dart';
import '../../common_widgets/cards_below_main_display/icon_trio_item.dart';
import '../../common_widgets/cards_below_main_display/next_screen_button.dart';
import '../../common_widgets/cards_below_main_display/single_card_item.dart';
import '../../common_widgets/headers_screens/header_screens.dart';
import '../../common_widgets/stats_main_display/stats_main_display.dart';

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
              const ParentStatsWOD(),
              // This display the cards below the chart  or calendar
              // this come before his parent.
              CardInParent(
                  header: 'Blocks Information:',
                  icon: Icons.list,
                  callBackOnTap: () {
                    //TODO ADD A CALLBACK
                    print('Not Implemented');
                  },
                  listWidgets: getStatsOfAllBlocksInWod(blockInData))
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
        // Widget blockCard = CardBlockInWOD(block: block);
        Widget blockCard = SingleCardItem(
          iconsTrioItemsList: [
            IconTrioItems(
              title: block['mode'].toUpperCase(),
              subtitle: 'Mode',
              icon: Icons.cached,
            ),
            IconTrioItems(
              title: "${block['sets']}",
              subtitle: 'Total Sets',
              icon: Icons.fitness_center,
            ),
            IconTrioItems(
              title: "${block['time']}",
              subtitle: 'Total Time',
              icon: Icons.timer,
            ),
            IconTrioItems(
                title: "${block['total_movements']}",
                subtitle: 'Total Exercises',
                icon: Icons.directions_run)
          ],
          buttonNextScreen: NextScreenButton(
            callBack: () {
              // TODO IMPLEMENT NEXT OR DISPLAY ANOTHER KIND OF MENU
              print('NOT IMPLEMENTED BUTTON');
              print('Click in  -> ${block['id']}');
            },
          ),
        );
        blocksList.add(blockCard);
      }
    }
    return blocksList;
  }
}
