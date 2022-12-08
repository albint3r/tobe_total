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
      unselectedFontSize: 10,
      currentIndex: ref.watch(indexBottomNavStateProvider),
      onTap: (int i) {
        // Modify the index of the current icon selected.
        ref.watch(indexBottomNavStateProvider.notifier).state = i;
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black,
      selectedItemColor: Colors.redAccent,
      selectedFontSize: 12,
      unselectedItemColor: Colors.white,
      iconSize: 25,
      elevation: 5,
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
    icon: Icon(icon, color: Colors.red),
    label: label,
    backgroundColor: Colors.white,
  );
}

