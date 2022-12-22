import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/features/wod_plan_manage/presentation/metrics_wod_info.dart';
import '../../../providers/wod_plan_provider.dart';
import '../../common_widgets/headers_screens/header_screens.dart';
import '../../common_widgets/stats_main_display/stats_main_display.dart';
import '../../configurate_athlete_profile/presentation/settings_menu_screen.dart';
import '../../training_calendar_manage/presentation/items_icons_wods.dart';
import 'charts/charts_wod.dart';

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
                child: StatsWOD(),
              ),
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
        Widget blockCard = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.all(5),
                    minLeadingWidth: 0,
                    subtitle: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ItemIconWod(
                              title: block['mode'].toUpperCase(),
                              subtitle: 'Mode',
                              icon: Icons.cached,
                            ),
                            ItemIconWod(
                              title: "${block['sets']}",
                              subtitle: 'Total Sets',
                              icon: Icons.fitness_center,
                            ),
                            ItemIconWod(
                              title: "${block['time']}",
                              subtitle: 'Total Time',
                              icon: Icons.timer,
                            ),
                            ItemIconWod(
                                title: "${block['total_movements']}",
                                subtitle: 'Total Exercises',
                                icon: Icons.directions_run)
                          ]),
                    ),
                    trailing: SizedBox(
                      height: double.infinity,
                      child: NextButtonSettingsCard(callBack: () {
                        // TODO IMPLEMENT NEXT OR DISPLAY ANOTHER KIND OF MENU
                        print('Click in  -> ${block['id']}');
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
        blocksList.add(blockCard);
      }
    }
    return blocksList;
  }
}
