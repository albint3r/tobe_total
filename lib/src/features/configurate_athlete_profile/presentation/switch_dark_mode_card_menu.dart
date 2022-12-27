import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/features/configurate_athlete_profile/presentation/item_settings_card_menu.dart';

import '../../../providers/theme/is_dark_mode_provider.dart';
import '../../../theme/settings_aparience.dart';


class DarkModeCardSwitch extends ConsumerWidget {
  const DarkModeCardSwitch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Change the Value in is the dark Mode
    bool isDarkMode = ref.watch(isDarkModeProviderNotifier);
    return SettingsCardMenu(
      title: isDarkMode ? 'Light Mode': 'Dark Mode',
      subtitle: 'Activate and deactivate the Dark Mode',
      leading: isDarkMode ? Icons.light_mode: Icons.dark_mode,
      trailing: Switch(
        value: isDarkMode,
        onChanged: (value) {
          // Switch the value [true or false] in the dark mode
          ref.watch(isDarkModeProviderNotifier.notifier).toggle();
        },
      ),
    )
    ;
  }
}
