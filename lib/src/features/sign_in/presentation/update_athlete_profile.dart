import 'package:flutter/material.dart';
import 'forms/form_update_profile.dart';

class UpdateAthleteProfile extends StatelessWidget {
  const UpdateAthleteProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: UpdateProfileAthleteForm(),
    );
  }
}
