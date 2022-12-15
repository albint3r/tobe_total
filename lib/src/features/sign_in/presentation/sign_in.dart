// Import
// Dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/features/sign_in/presentation/forms/form_create_profile_athlete.dart';
// Common widgets

class SignIn extends ConsumerStatefulWidget {
  const SignIn({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _SignInState();
}

class _SignInState extends ConsumerState<SignIn> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CreateProfileAthleteForm(),
    );
  }
}

