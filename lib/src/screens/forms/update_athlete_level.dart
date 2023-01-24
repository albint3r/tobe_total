import 'package:flutter/material.dart';
import '../../features/sign_in_and_update/presentation/forms/form_level.dart';

class UpdateAthleteLevel extends StatelessWidget {
  const UpdateAthleteLevel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AthleteLevelForm(),
    );
  }
}
