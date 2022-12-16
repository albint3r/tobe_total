import 'package:flutter/material.dart';
import 'forms/update_athlete_goal.dart';

class UpdateAthleteGoal extends StatelessWidget {
  const UpdateAthleteGoal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AthleteGoalForm(),
    );
  }
}
