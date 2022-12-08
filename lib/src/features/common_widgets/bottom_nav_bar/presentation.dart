// Import
// Dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'controller.dart';

class BottomNavBar extends ConsumerStatefulWidget {
  const BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends ConsumerState<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: ref.watch(indexBottomNavStateProvider),
      onTap: (int i) {
        // Modify the index of the current icon selected.
        // TODO THE WIDGET DON'T NEED TO MAKE THE CHANGE OF THE STATE
        ref.watch(indexBottomNavStateProvider.notifier).state = i;
      },
      items: [
        barItem(Icons.stacked_bar_chart, 'Progress'),
        barItem(Icons.paste_outlined, 'Training Plan'),
        barItem(Icons.fitness_center, 'achieves'),
        barItem(Icons.settings, 'Settings'),
      ],
    );
  }
}

BottomNavigationBarItem barItem(IconData icon, String label) {
  // Create a Navigation Item fot the Bottom Menu Bar.
  return BottomNavigationBarItem(
    icon: Icon(icon),
    label: label,
  );
}

