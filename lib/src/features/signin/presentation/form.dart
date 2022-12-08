// Import
// Dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common_widgets/bottom_nav_bar/presentation.dart';
import '../../common_widgets/floating_action_btn/presentation.dart';
import '../../../theme/controller.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('HeadLine1'),
            Text('HeadLine2'),
            Text('HeadLine3'),
            Text('HeadLine4'),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
      floatingActionButton: const FloatBottomBtn(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
