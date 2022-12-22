import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'charts/charts_wod.dart';
import 'general_kpis.dart';

class StatsWOD extends ConsumerWidget {
  const StatsWOD({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: const [
        GeneralKPIs(),
        ChartsWOD(),
      ],
    );
  }
}
