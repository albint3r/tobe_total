import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/features/configurate_athlete_profile/presentation/switch_dark_mode_card_menu.dart';
import 'package:tobe_total/src/features/configurate_athlete_profile/presentation/profile_card/card_profile_menu.dart';
import 'package:tobe_total/src/features/configurate_athlete_profile/presentation/item_settings_card_menu.dart';
import '../../../routes/const_url.dart';
import '../../../routes/routes.dart';
import '../../common_widgets/bottom_nav_bar/presentation/bottom_nav_bar2.dart';
import '../../common_widgets/headers_screens/header_screens.dart';

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
          H1Screens(header: 'Settings Menu'),
          const CardProfileMenu(),
          SettingsCardMenu(
            title: 'Update Profile',
            subtitle: 'Update the information of your Athlete profile',
            leading: Icons.person,
            trailing: NextButtonSettingsCard(callBack: () {
              final routes = ref.watch(routesProvider);
              routes.navigateTo(context, ConstantsUrls.updateAthleteProfile);
            }),
          ),
          const DarkModeCardSwitch()
        ],
      ),
    );
  }
}

class NextButtonSettingsCard extends StatelessWidget {
  NextButtonSettingsCard({
    required this.callBack,
    Key? key,
  }) : super(key: key);
  VoidCallback callBack;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callBack,
      child: const Icon(Icons.arrow_forward_ios_outlined),
    );
  }
}
