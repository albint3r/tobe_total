import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/calendar_provider.dart';
import '../../common_widgets/headers_screens/header_screens.dart';
import '../../configurate_athlete_profile/presentation/settings_menu_screen.dart';
import 'items_icons_wods.dart';

const Map<int, String> weekendNameDays = {
  1: 'Monday',
  2: 'Tuesday',
  3: 'Wednesday',
  4: 'Thursday',
  5: 'Friday',
  6: 'Saturday',
  7: 'Sunday',
};

class WODsInformation extends ConsumerWidget {
  const WODsInformation({
    Key? key,
    required this.selectedWodsDay,
  }) : super(key: key);

  final List selectedWodsDay;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
      width: MediaQuery.of(context).size.width * .90,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          H3FormFieldsHeader(header: 'WODs information:'),
          ...getWODsInformation(ref)
        ],
      ),
    );
  }

  List<Widget> getWODsInformation(WidgetRef ref) {
    List<Widget> wodsCards = [];
    if (selectedWodsDay.isNotEmpty) {
      for (Map wod in selectedWodsDay) {
        String? nameDay =
            weekendNameDays[ref.watch(selectedDayProvider)?.weekday];
        Widget wodCard = Card(
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
                          title: "$nameDay",
                          subtitle: 'Date',
                          icon: Icons.today,
                        ),
                        ItemIconWod(
                          title: "${wod['body_area']}",
                          subtitle: 'Body Area',
                          // If upper body select ^ icon.
                          icon: wod['body_area'] == 'upper'
                              ? Icons.expand_less
                              : Icons.expand_more,
                        ),
                        ItemIconWod(
                          title: "${wod['total_blocks']}",
                          subtitle: 'Total Blocks',
                          icon: Icons.grid_view,
                        ),
                        ItemIconWod(
                          title: "${wod['total_time_work_out']}",
                          subtitle: 'Total Time',
                          icon: Icons.timer,
                        )
                      ]),
                ),
                trailing: Container(
                  height: double.infinity,
                  child: NextButtonSettingsCard(callBack: () {
                    //TODO IMPLEMENT ROUTE TO NEXT TRAINING
                  }),
                ),
              ),
            ],
          ),
        );
        wodsCards.add(wodCard);
      }
    }
    return wodsCards;
  }
}
