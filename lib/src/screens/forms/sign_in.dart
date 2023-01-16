// Import
// Dart
import 'package:flutter/material.dart';
import 'package:tobe_total/src/features/sign_in_and_update/presentation/forms/form_sign_in.dart';
// Common widgets

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SignInForm(),
    );
  }
}
