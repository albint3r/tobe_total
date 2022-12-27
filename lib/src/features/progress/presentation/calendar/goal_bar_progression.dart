import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../../providers/wod/controllers/wod_controller_provider.dart';

class GoalBarProgression extends ConsumerWidget {
  const GoalBarProgression({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goalProgress = ref.watch(goalProgressDaysProvider);
    return goalProgress.when(
      error: (error, stackTrace) => Text('Error $error'),
      loading: () => const CircularProgressIndicator(),
      data: (goalProgressData) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              LinearPercentIndicator(
                barRadius: const Radius.circular(15),
                width: MediaQuery.of(context).size.width - 100,
                animation: true,
                lineHeight: 15.0,
                animationDuration: 2000,
                percent: goalProgressData['goalPer'],
                // Convert the result in a percentage way
                center:
                    Text("${(goalProgressData['goalPer'] * 100).toInt()} %"),
                progressColor: Colors.greenAccent,
              ),
              TextGoalIndicator(
                goalProgress: goalProgressData,
              )
            ],
          ),
        );
      },
    );
  }
}

class TextGoalIndicator extends StatelessWidget {
  const TextGoalIndicator({
    required Map goalProgress,
    Key? key,
  })  : _goalProgress = goalProgress,
        super(key: key);
  final Map _goalProgress;

  @override
  Widget build(BuildContext context) {
    String textIndicator =
        '${_goalProgress['currentTrainedDays']}/${_goalProgress['goal']}';
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Center(
        child: Text(
          'Week Goal: $textIndicator'.toUpperCase(),
          style: const TextStyle(fontSize: 10),
        ),
      ),
    );
  }
}
