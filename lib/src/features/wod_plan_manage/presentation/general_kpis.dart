import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../providers/wod_plan_provider.dart';
import '../../training_calendar_manage/presentation/wods_card_information.dart';
import 'package:string_ext/string_ext.dart';

class GeneralKPIs extends ConsumerWidget {
  const GeneralKPIs({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wodInfo = ref.watch(selectedWodInformationProvider);
    final date = DateFormat("yyyy-MM-dd")
        .parse(wodInfo['expected_training_day'] as String);
    String? nameDay = weekendNameDays[date.weekday];
    String bodyArea = wodInfo['body_area'] as String;
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ItemIconWodInKPI(
            title: "$nameDay ${date.day}",
            icon: Icons.today,
          ),
          ItemIconWodInKPI(
            title: "${wodInfo['total_blocks']}",
            icon: Icons.grid_view,
          ),
          ItemIconWodInKPI(
            title: "${wodInfo['total_time_work_out']}",
            icon: Icons.timer,
          ),
          ItemIconWodInKPI(
              title: bodyArea.firstToUpper(),
              icon: Icons.accessibility)
        ],
      ),
    );
  }
}

class ItemIconWodInKPI extends ConsumerWidget {
  const ItemIconWodInKPI({
    Key? key,
    required String title,
    required IconData icon,
  })  : _title = title,
        _icon = icon,
        super(key: key);

  final String _title;
  final IconData _icon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5, top: 5),
      child: Column(
        children: [
          Text(_title),
          const SizedBox(
            height: 10,
          ),
          Icon(_icon),
        ],
      ),
    );
  }
}
