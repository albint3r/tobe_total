// Import
// Dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/features/sign_in/presentation/my_custom_form.dart';
// Common widgets
import '../../common_widgets/bottom_nav_bar/presentation/bottom_nav_bar.dart';
import '../../common_widgets/floating_action_btn/float_action_bottom_btn.dart';
// Project Modules
import '../../../theme/settings_aparience.dart';

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
    bool isDarkMode = ref.watch(isDarkModeProviderNotifier);

    return Scaffold(
      body: const MyCustomForm(),
      bottomNavigationBar: const BottomNavBar(),
      floatingActionButton: const FloatBottomBtn(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // TODO remove later this app bar from here
      appBar: AppBar(
        title: const Text('Tobe Total'),
        actions: [
          Switch(
            value: isDarkMode,
            onChanged: (value) {
              ref.watch(isDarkModeProviderNotifier.notifier).toggle();
            },
          )
        ],
      ),
    );
  }
}

