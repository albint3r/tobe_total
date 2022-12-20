import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../common_widgets/bottom_nav_bar/presentation/bottom_nav_bar2.dart';
import 'calendar_display.dart';

class TrainingPlanScreen extends ConsumerWidget {
  const TrainingPlanScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      bottomNavigationBar: CurveBottomNavBar(),
      body: CalendarDisplay(),
    );
  }
}
