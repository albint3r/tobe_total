import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Level { beginner, intermediate, advance, elite }

class LevelManager {
  selectLevelOnForm(WidgetRef ref, Level levelValue) {
    ref.watch(levelProvider.notifier).state = levelValue;
  }

  int getIndexLevel(Level level) {
    switch (level) {
      case Level.beginner:
        return 0;

      case Level.intermediate:
        return 1;

      case Level.advance:
        return 2;

      case Level.elite:
        return 3;
    }
  }

  Level getLevelFromIndex(int index) {
    switch (index) {
      case 0:
        return Level.beginner;
      case 1:
        return Level.intermediate;
      case 2:
        return Level.advance;
      case 3:
        return Level.elite;
    }
    return Level.beginner;
  }
}

final levelProvider = StateProvider<Level>((ref) {
  return Level.beginner;
});

final levelManagerProvider = Provider<LevelManager>((ref) {
  return LevelManager();
});
