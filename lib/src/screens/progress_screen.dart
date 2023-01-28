// Imports
// Flutter
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/features/progress/presentation/progression_display.dart';
import '../features/common_widgets/floating_action_btn/float_action_bottom_btn_create_training_week.dart';
import '../providers/wod/model/wod_model_provider.dart';
import '../features/common_widgets/bottom_nav_bar/presentation/bottom_nav_bar2.dart';
import '../features/common_widgets/floating_action_btn/float_action_bottom_btn_go_training.dart';
import 'package:wakelock/wakelock.dart';

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
    Wakelock.disable();
    final existWodOfTheWeek = ref.watch(existWodsOfTheWeekProvider);
    return existWodOfTheWeek.when(
      error: (error, stackTrace) => Text('error $error'),
      loading: () => const CircularProgressIndicator(),
      data: (existWodOfTheWeekData) {
        return Scaffold(
          bottomNavigationBar: const CurveBottomNavBar(),
          body: const ProgressionDisplay(),
          floatingActionButton:
              !existWodOfTheWeekData ? const CreateNewWeekActionBtn() : const GoToNextTrainingOFTheWeek(),
        );
      },
    );
  }
}
