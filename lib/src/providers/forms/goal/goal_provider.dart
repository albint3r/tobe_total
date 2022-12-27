import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Goals { resistance, maintenance, strength }

class GoalManager {
  selectGoalOnForm(WidgetRef ref, Goals goal) {
    // Update State of the goalProvider.
    ref.watch(goalProvider.notifier).state = goal;
  }

  int getIndexGoal(Goals goal) {
    switch (goal) {
      case Goals.resistance:
        return 0;

      case Goals.maintenance:
        return 1;

      case Goals.strength:
        return 2;
    }
  }

  Goals getGoalFromIndex(int index) {
    switch (index) {
      case 0:
        return Goals.resistance;
      case 1:
        return Goals.maintenance;
      case 2:
        return Goals.strength;
    }
    return Goals.resistance;
  }
}

final goalProvider = StateProvider<Goals>((ref) {
  return Goals.resistance;
});

final goalManagerProvider = Provider<GoalManager>((ref) {
  return GoalManager();
});
