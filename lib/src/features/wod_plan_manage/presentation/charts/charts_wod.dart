import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'bar_chart_wod.dart';

class ChartsWOD extends ConsumerWidget {
  const ChartsWOD({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 200,
      // TODO CHECK A WAY TO FIX THE LENGTH OF THE CHART AREA
      width: MediaQuery.of(context).size.width / 1.05,
      child: const BarChartMuscleSetCounter(),
    );

  }
}

