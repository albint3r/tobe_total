import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/calendar_provider.dart';
import '../../../providers/routes_provider.dart';
import '../../../providers/wod_plan_provider.dart';
import '../../../routes/const_url.dart';
import '../../common_widgets/headers_screens/header_screens.dart';
import '../../configurate_athlete_profile/presentation/settings_menu_screen.dart';
import 'items_icons_wods.dart';
import 'package:intl/intl.dart';

const Map<int, String> weekendNameDays = {
  1: 'Monday',
  2: 'Tuesday',
  3: 'Wednesday',
  4: 'Thursday',
  5: 'Friday',
  6: 'Saturday',
  7: 'Sunday',
};

class WODsCardInformation extends ConsumerWidget {
  const WODsCardInformation({
    Key? key,
    required this.selectedWodsDay,
  }) : super(key: key);

  final List selectedWodsDay;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDay = ref.watch(selectedDayProvider);
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width * .90,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            H3FormFieldsHeader(header: 'WODs information:'),
            Container(
              margin: const EdgeInsets.only(right: 5),
              // If a day is select it will display another icon in the menu.
              child: GestureDetector(
                child: Icon(selectedDay == null
                    ? Icons.list
                    : Icons.filter_list_rounded),
                onTap: () {
                  ref.watch(calendarControllerProvider).unselectDayCalendar(ref);
                  print('Display list of WODS');
                },
              ),
            )
          ]),
          ...getWODsInformation(context, ref)
        ],
      ),
    );
  }

  List<Widget> getWODsInformation(BuildContext context, WidgetRef ref) {
    List<Widget> wodsCards = [];
    if (selectedWodsDay.isNotEmpty) {
      for (Map wod in selectedWodsDay) {
        // Convert Date in DateFormat
        final date = DateFormat("yyyy-MM-dd")
            .parse(wod['expected_training_day'] as String);
        String? nameDay = weekendNameDays[date.weekday];
        Widget wodCard = CardWODInWeekTraining(nameDay: nameDay, date: date, wod: wod);
        wodsCards.add(wodCard);
      }
    }
    return wodsCards;
  }
}

class CardWODInWeekTraining extends ConsumerWidget {
  const CardWODInWeekTraining({
    Key? key,
    required this.nameDay,
    required this.date,
    required this.wod,
  }) : super(key: key);

  final String? nameDay;
  final DateTime date;
  final Map wod;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
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
                          title: "$nameDay ${date.day}",
                          subtitle: 'Date',
                          icon: Icons.today,
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
                        ),
                        ItemIconWod(
                          title: "${wod['body_area']}",
                          subtitle: 'Body Area',
                          icon: Icons.accessibility
                        )
                      ]),
                ),
                trailing: SizedBox(
                  height: double.infinity,
                  child: NextButtonSettingsCard(callBack: () {
                    ref.watch(wodPlanControllerProvider).setStateSelectedWodInformation(ref, wod);
                    ref.watch(wodPlanControllerProvider).setStateWodIdProvider(ref, wod['id']);
                    ref.watch(routesProvider).navigateTo(context, ConstantsUrls.wodPlan);
                    print('Navigate to wod -> ${ref.watch(wodIdProvider)}');
                  }),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
