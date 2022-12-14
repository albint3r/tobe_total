import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/features/settings_menu/presentation/settings_card_menu.dart';

import '../../../theme/settings_aparience.dart';


class DarkModeCardSwitch extends ConsumerWidget {
  const DarkModeCardSwitch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = ref.watch(isDarkModeProviderNotifier);
    return SettingsCardMenu(
      title: isDarkMode ? 'Light Mode': 'Dark Mode',
      subtitle: 'Activate and deactivate the Dark Mode',
      leading: isDarkMode ? Icons.light_mode: Icons.dark_mode,
      trailing: Switch(
        value: isDarkMode,
        onChanged: (value) {
          ref.watch(isDarkModeProviderNotifier.notifier).toggle();
        },
      ),
    )
    ;
  }
}
