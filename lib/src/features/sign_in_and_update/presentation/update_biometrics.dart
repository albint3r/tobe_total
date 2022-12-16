import 'package:flutter/material.dart';
import 'forms/form_update_biometrics.dart';

class UpdateBiometrics extends StatelessWidget {
  const UpdateBiometrics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BiometricsForm(),
    );
  }
}