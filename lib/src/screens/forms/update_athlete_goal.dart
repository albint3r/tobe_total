import 'package:flutter/material.dart';
import '../../features/sign_in_and_update/presentation/forms/update_athlete_goal.dart';

class UpdateAthleteGoal extends StatelessWidget {
  const UpdateAthleteGoal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AthleteGoalForm(),
    );
  }
}
