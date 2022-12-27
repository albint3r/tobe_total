import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/features/configurate_athlete_profile/presentation/switch_dark_mode_card_menu.dart';
import 'package:tobe_total/src/features/configurate_athlete_profile/presentation/profile_card/card_profile_menu.dart';
import 'package:tobe_total/src/features/configurate_athlete_profile/presentation/item_settings_card_menu.dart';
import '../../../providers/routes/routes_provider.dart';
import '../../../routes/const_url.dart';
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
          const H1Screens(
            header: 'Settings Menu',
            isInListView: true,
          ),
          const SubTitleHeaderH1(
              subHeader:
                  'Update all your Stats to create more accurate workouts'),
          const CardProfileMenu(),
          SettingsCardMenu(
            title: 'Update General Information',
            subtitle: 'Update the information of your Athlete profile',
            leading: Icons.person,
            trailing: NextButtonSettingsCard(callBack: () {
              final routes = ref.watch(routesProvider);
              routes.navigateTo(
                  context, ConstantsUrls.updateGeneralInformation);
            }),
          ),
          SettingsCardMenu(
            title: 'Update Biometrics',
            subtitle: 'Update the information of your Athlete profile',
            leading: Icons.area_chart_outlined,
            trailing: NextButtonSettingsCard(callBack: () {
              final routes = ref.watch(routesProvider);
              routes.navigateTo(context, ConstantsUrls.updateBiometrics);
            }),
          ),
          SettingsCardMenu(
            title: 'Update Training Itinerary',
            subtitle: 'Update the information of your Athlete profile',
            leading: Icons.calendar_month,
            trailing: NextButtonSettingsCard(callBack: () {
              final routes = ref.watch(routesProvider);
              routes.navigateTo(context, ConstantsUrls.updateTrainingItinerary);
            }),
          ),
          SettingsCardMenu(
            title: 'Update Athlete Goal',
            subtitle: 'Update the information of your Athlete profile',
            leading: Icons.task,
            trailing: NextButtonSettingsCard(callBack: () {
              final routes = ref.watch(routesProvider);
              routes.navigateTo(context, ConstantsUrls.updateAthleteGoal);
            }),
          ),
          const DarkModeCardSwitch()
        ],
      ),
    );
  }
}


// TODO DELETE THIS METHOD THE SOON AS POSIBLE
// USE THE CARD_BELOW_MAIN_DISPLAY TO CREATE THE AREA OF THE UI.
class NextButtonSettingsCard extends StatelessWidget {
  const NextButtonSettingsCard({
    required VoidCallback callBack,
    Key? key,
  })  : _callBack = callBack,
        super(key: key);
  final VoidCallback _callBack;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _callBack,
      child: const Icon(Icons.arrow_forward_ios_outlined),
    );
  }
}
