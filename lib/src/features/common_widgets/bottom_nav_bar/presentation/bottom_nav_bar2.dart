import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../preferences_cache/preferences.dart';
import '../../../../routes/const_url.dart';
import '../../../../routes/routes.dart';
import '../controller/index_bottom_nav_provider.dart';
import 'item_bottom_nav_bar.dart';

class CurveBottomNavBar extends ConsumerStatefulWidget {
  const CurveBottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CurveBottomNavBarState();
}

class _CurveBottomNavBarState extends ConsumerState<CurveBottomNavBar> {

  late Color backgroundColor;
  late Color buttonBackgroundColor;
  late Color color;

  void setColorsSelectedTheme(bool isDark) {
    //Depending of the Selected Theme it would be the colors of the bottom bar
    if (isDark) {
      // Dark mode
      backgroundColor = const Color.fromRGBO(31, 31, 31, 1);
      buttonBackgroundColor = Colors.red;
      color = Colors.black54;
    } else {
      // light mode
      backgroundColor = Colors.white;
      buttonBackgroundColor = Colors.red;
      color = Colors.black54;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(appPreferencesProvider).getBoolPreference('darkMode');
    setColorsSelectedTheme(isDark);
    return CurvedNavigationBar(
      // Index Provider
      index: ref.watch(indexBottomNavStateProvider),
      height: 60.0,
      color: color,
      backgroundColor: backgroundColor,
      buttonBackgroundColor: buttonBackgroundColor,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 500),
      onTap: (i) {
        // Change index
        // TODO CREATE A METHOD TO ADD THE INDEX -> i
        final routes = ref.watch(routesProvider);
        ref.watch(indexBottomNavStateProvider.notifier).state = i;
        routes.navigateTo(context, routes.getScreenOfIndex(i));

      },
      items: <Widget>[
        ItemBottomNavBar(
          icon: Icons.stacked_bar_chart,
        ),
        ItemBottomNavBar(
          icon: Icons.paste_outlined,
        ),
        ItemBottomNavBar(
          icon: Icons.fitness_center,
        ),
        ItemBottomNavBar(
          icon: Icons.settings,
        )
      ],
    );
  }
}
