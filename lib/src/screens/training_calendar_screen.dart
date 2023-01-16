import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../features/common_widgets/bottom_nav_bar/presentation/bottom_nav_bar2.dart';
import '../features/training_week_calendar/presentation/calendar_display.dart';

class TrainingCalendarScreen extends ConsumerWidget {
  const TrainingCalendarScreen({
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
