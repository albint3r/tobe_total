// Imports
// Flutter
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/features/progress/presentation/progression_display.dart';

import '../preferences_cache/preferences.dart';
import '../providers/bottom_nav_bar/model/index_bottom_nav_provider.dart';
import '../providers/wod/model/wod_model_provider.dart';
import '../features/common_widgets/bottom_nav_bar/presentation/bottom_nav_bar2.dart';
import '../features/common_widgets/floating_action_btn/float_action_bottom_btn.dart';
import '../features/common_widgets/floating_action_btn/float_action_bottom_btn_go_training.dart';

class Progress extends ConsumerStatefulWidget {
  const Progress({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ProgressState();
}

class _ProgressState extends ConsumerState<Progress> {
  @override
  Widget build(BuildContext context) {
    final existWodOfTheWeek = ref.watch(existWodsOfTheWeekProvider);
    return existWodOfTheWeek.when(
      error: (error, stackTrace) => Text('error $error'),
      loading: () => const CircularProgressIndicator(),
      data: (existWodOfTheWeekData) {
        return Scaffold(
          bottomNavigationBar: const CurveBottomNavBar(),
          body: const ProgressionDisplay(),
          floatingActionButton:
              !existWodOfTheWeekData ? const CreateNewWeekActionBtn() : GoToNextTrainingOFTheWeek(),
        );
      },
    );
  }
}