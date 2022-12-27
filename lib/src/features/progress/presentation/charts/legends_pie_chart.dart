import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:string_ext/string_ext.dart';
import '../../../../providers/pie_chart_provider.dart';

class LegendsChart extends ConsumerWidget {
  const LegendsChart({
    required int index,
    required String label,
    required Map<String, Color> palletColors,
    Key? key,
  })  : _index = index,
        _label = label,
        _palletColors = palletColors,
        super(key: key);
  final int _index;
  final String _label;
  final Map<String, Color> _palletColors;


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indexChart = ref.watch(pieChartIndexProvider);

    return Column(
      children: [
        Container(
          height: 5,
          width: 15,
          color: _palletColors[_label],
        ),
        Text(
          _label.firstToUpper(),
          style: TextStyle(fontSize: 7,
              fontWeight: _index == indexChart ? FontWeight.bold : FontWeight.normal),
        )
      ],
    );
  }
}
