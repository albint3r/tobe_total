import 'package:flutter/material.dart';
import '../../features/sign_in_and_update/presentation/forms/form_update_init_stats.dart';
import '../../features/sign_in_and_update/presentation/forms/update_athlete_goal.dart';

class UpdateInitStatsScreen extends StatelessWidget {
  const UpdateInitStatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: UpdateInitStatsForm(),
    );
  }
}