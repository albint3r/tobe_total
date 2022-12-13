import 'package:flutter/material.dart';

BottomNavigationBarItem barItem(IconData icon, String label) {
  // Create a Navigation Item fot the Bottom Menu Bar.
  return BottomNavigationBarItem(
    icon: Icon(icon),
    label: label,
  );
}