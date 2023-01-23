import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/training_week/controllers/training_week_controller.dart';
import '../../../providers/training_week/model/calendar_provider.dart';
import '../../../providers/routes/routes_provider.dart';
import '../../../providers/wod/controllers/wod_controller_provider.dart';
import '../../../providers/wod/model/wod_model_provider.dart';
import '../../../routes/const_url.dart';
import '../../common_widgets/cards_below_main_display/cards_in_parent.dart';
import '../../common_widgets/cards_below_main_display/icon_trio_item.dart';
import '../../common_widgets/cards_below_main_display/next_screen_button.dart';
import '../../common_widgets/cards_below_main_display/single_card_item.dart';
import 'package:intl/intl.dart';

class WODsCardInformation extends ConsumerWidget {
  const WODsCardInformation({
    Key? key,
    required this.selectedWodsDay,
    required this.isSelectedUniqueDay,
  }) : super(key: key);

  final List selectedWodsDay;
  final bool isSelectedUniqueDay;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDay = ref.watch(selectedDayProvider);
    final wodsModel = ref.watch(wodsModelProvider);

    return CardInParent(
      header: 'Training Week Information:',
      icon: selectedDay == null ? Icons.list : Icons.filter_list_rounded,
      callBackOnTap: () async {
        ref.watch(calendarControllerProvider).unselectDayCalendar(ref);
        print('Display list of WODS');
      },
      listWidgets: getWODsInformation(context, ref),
    );
  }

  List<Widget> getWODsInformation(BuildContext context, WidgetRef ref) {
    List<Widget> wodsCards = [];
    final timeManagerController = ref.watch(dateTimeManageControllerProvider);
    DateTime startDayOfTheWeek = timeManagerController.findFirstDateOfTheWeek(DateTime.parse(DateTime.now().toString().substring(0,10)));
    if (selectedWodsDay.isNotEmpty) {
      for (Map wod in selectedWodsDay) {
        // Convert Date in DateFormat
        final date = DateFormat("yyyy-MM-dd")
            .parse(wod['expected_training_day'] as String);
        final calendarDayConversionMap =
            ref.watch(calendarMapConversionProvider);
        String? nameDay = calendarDayConversionMap[date.weekday];
        // THIS IF CONDITION MANAGE THE DISPLAY WODS OF THE WEEK SELECTION
        // IF THE USER IS SHOWING ALL THEIR TRAININGS OF THE WEEK, IT WILL BE FALSE,
        // That's the reason why the [startDayOfTheWeek] the time was reset
        // to ensure the day of today is the same. Also, if the user
        // select only one day the [isSelectedUniqueDay] would be true
        // this mean, it will show the day selected.
        if(startDayOfTheWeek.compareTo(date) == 0 || startDayOfTheWeek.compareTo(date) < 0 || isSelectedUniqueDay) {
          Widget wodCard = SingleCardItem(
            iconsTrioItemsList: [
              IconTrioItems(
                title: "$nameDay ${date.day}",
                subtitle: 'Date',
                icon: Icons.today,
              ),
              IconTrioItems(
                title: "${wod['total_blocks']}",
                subtitle: 'Total Blocks',
                icon: Icons.grid_view,
              ),
              IconTrioItems(
                title: "${wod['total_time_work_out']}",
                subtitle: 'Total Time',
                icon: Icons.timer,
              ),
              IconTrioItems(
                  title: "${wod['body_area']}",
                  subtitle: 'Body Area',
                  icon: Icons.accessibility)
            ],
            buttonNextScreen: NextScreenButton(
              callBack: () {
                ref
                    .watch(wodPlanControllerProvider)
                    .setStateSelectedWodInformation(ref, wod);
                ref
                    .watch(wodPlanControllerProvider)
                    .setStateWodIdProvider(ref, wod['id']);
                ref
                    .watch(routesProvider)
                    .navigateTo(context, ConstantsUrls.wodPlan);
                print('Navigate to wod -> ${ref.watch(wodIdProvider)}');
              },
            ),
          );
          wodsCards.add(wodCard);
        }
        // Widget wodCard = SingleCardItem(
        //   iconsTrioItemsList: [
        //     IconTrioItems(
        //       title: "$nameDay ${date.day}",
        //       subtitle: 'Date',
        //       icon: Icons.today,
        //     ),
        //     IconTrioItems(
        //       title: "${wod['total_blocks']}",
        //       subtitle: 'Total Blocks',
        //       icon: Icons.grid_view,
        //     ),
        //     IconTrioItems(
        //       title: "${wod['total_time_work_out']}",
        //       subtitle: 'Total Time',
        //       icon: Icons.timer,
        //     ),
        //     IconTrioItems(
        //         title: "${wod['body_area']}",
        //         subtitle: 'Body Area',
        //         icon: Icons.accessibility)
        //   ],
        //   buttonNextScreen: NextScreenButton(
        //     callBack: () {
        //       ref
        //           .watch(wodPlanControllerProvider)
        //           .setStateSelectedWodInformation(ref, wod);
        //       ref
        //           .watch(wodPlanControllerProvider)
        //           .setStateWodIdProvider(ref, wod['id']);
        //       ref
        //           .watch(routesProvider)
        //           .navigateTo(context, ConstantsUrls.wodPlan);
        //       print('Navigate to wod -> ${ref.watch(wodIdProvider)}');
        //     },
        //   ),
        // );
        // wodsCards.add(wodCard);
      }
    }
    return wodsCards;
  }
}
