import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common_widgets/headers_screens/header_screens.dart';
import 'charts/charts_wod.dart';
import 'general_kpis.dart';

class StatsWOD extends ConsumerWidget {
  // This class manage the order of the column of the element in the KPI section
  const StatsWOD({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const GeneralKPIs(),
        H3FormFieldsHeader(header: 'Total Sets by Muscle',),
        const ChartsWOD(),
      ],
    );
  }
}
