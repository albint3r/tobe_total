import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/features/my_movements/presentation/movements_display.dart';
import '../common_widgets/bottom_nav_bar/presentation/bottom_nav_bar2.dart';

// The [MyMovementsScreen] class is a widget class that is used to display a
// movements screen in the application. This screen consists of a bottom
// navigation bar and a widget that displays the movements.
//
// The class extends from ConsumerWidget and overrides the build method
// to return a Scaffold with a bottom navigation bar and a movements display
// widget. This screen is used to display the user's
// movements in the application.

class MyMovementsScreen extends ConsumerWidget {
  const MyMovementsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      bottomNavigationBar: CurveBottomNavBar(),
      body: MyMovementsDisplay(),
    );
  }
}