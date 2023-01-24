import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/configurate_athlete_profile/presentation/configuration_profile_display.dart';
import '../features/common_widgets/bottom_nav_bar/presentation/bottom_nav_bar2.dart';


class SettingsMenu extends ConsumerWidget {
  const SettingsMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      bottomNavigationBar: CurveBottomNavBar(),
      body: SettingsMenuDisplay(),
    );
  }
}



