import 'package:flutter/material.dart';
import '../../features/sign_in_and_update/presentation/forms/form_update_biometrics.dart';

class UpdateBiometrics extends StatelessWidget {
  const UpdateBiometrics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BiometricsForm(),
    );
  }
}
