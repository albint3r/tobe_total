import 'package:flutter/material.dart';

class ItemBottomNavBar extends StatelessWidget {
  ItemBottomNavBar({
    Key? key,
    required this.icon,
  }) : super(key: key);

  IconData icon;
  Color iconColor = Colors.white;
  double iconSize = 25;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: iconSize,
      color: iconColor,
    );
  }
}
