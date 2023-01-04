import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:string_ext/string_ext.dart';

/// A widget that displays a progress bar with a label and a score.
class KPIBarMoveStat extends ConsumerWidget {
  /// Creates a new instance of [KPIBarMoveStat].
  const KPIBarMoveStat({
    required this.label,
    required this.textInsideBar,
    required this.score,
    Key? key,
  }) : super(key: key);
  /// The label to display.
  final String label;
  /// The text to display inside the progress bar.
  final String textInsideBar;
  /// The score to display as a percentage in the progress bar.
  final double score;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
        margin: const EdgeInsets.only(top: 15, left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearPercentIndicator(
              barRadius: const Radius.circular(20),
              width: constraints.maxWidth * .60,
              animation: true,
              lineHeight: 12.0,
              animationDuration: 2000,
              percent: score,
              // Convert the result in a percentage way
              center: Text(
                textInsideBar.firstToUpper(),
                style: const TextStyle(fontSize: 9),
              ),
              progressColor: getColorBar(),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Text(label),
            )
          ],
        ),
      );
    });
  }

  /// Selects the color to use inside the progress bar based on the [score].
  ColorSwatch<int> getColorBar() {
    if (score <= .25) {
      return Colors.greenAccent;
    } else if (score > .25 && score <= .50) {
      return Colors.yellowAccent;
    } else if (score > .50 && score <= .75) {
      return Colors.deepOrangeAccent;
    } else {
      return Colors.red;
    }
  }
}
