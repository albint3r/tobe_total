import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/features/settings_menu/presentation/dark_mode_card_switch.dart';
import 'package:tobe_total/src/features/settings_menu/presentation/profile_card/profile_card_menu.dart';
import 'package:tobe_total/src/features/settings_menu/presentation/settings_card_menu.dart';
import '../common_widgets/bottom_nav_bar/presentation/bottom_nav_bar2.dart';
import '../common_widgets/headers_screens/header_screens.dart';

class SettingsMenu extends ConsumerWidget {
  const SettingsMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      bottomNavigationBar: const CurveBottomNavBar(),
      body: ListView(
        children: <Widget>[
          H1Screens(header:'Settings Menu'),
          const CardProfileMenu(),
          SettingsCardMenu(
            title: 'Update Profile',
            subtitle: 'Update the information of your Athlete profile',
            leading: Icons.person,
            trailing: const Icon(Icons.arrow_forward_ios_outlined),
          ),
          const DarkModeCardSwitch()
        ],
      ),
    );
  }
}
