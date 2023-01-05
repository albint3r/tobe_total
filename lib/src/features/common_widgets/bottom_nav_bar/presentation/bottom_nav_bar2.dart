import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../providers/block/controllers/block_controller_provider.dart';
import '../../../../providers/block/model/block_model_provider.dart';
import '../../../../providers/bottom_nav_bar/controllers/index_bottom_nav_bar_controller.dart';
import '../../../../providers/my_movements/controllers/my_movements_controller.dart';
import '../../../../providers/theme/is_dark_mode_provider.dart';
import '../../../../providers/routes/routes_provider.dart';
import '../../../../providers/bottom_nav_bar/model/index_bottom_nav_provider.dart';
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
      color = Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    // final isDark = ref.watch(appPreferencesProvider).getBoolPreference('darkMode');
    final isDark = ref.watch(isDarkModeProviderNotifier);
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
        // Create the route and all the controllers to change the states.
        final routes = ref.watch(routesProvider);
        final bottomNavController = ref.watch(bottomNavBarControllerProvider);
        final myMovementController = ref.watch(myMovementControllerProvider);
        final blockController = ref.watch(blockControllerProvider);
        // Select witch screen index your are going to go
        bottomNavController.setStateIndexBottomNavStateProvider(i, ref);
        // Reset the state of the filter [myMovements] and Block ID
        // This helps to avoid bugs, when the app is displaying only
        // the moves inside the block and also when the user filter the moves
        // and want to go back to see all the moves.
        myMovementController.setStateQueryMyMovementFilteredProvider('', ref);
        blockController.setStateClickedBlockIDProvider(-1, ref);
        // After all this, the routes object parse the index, to a string
        // direction that can use to go to the next screen.
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
