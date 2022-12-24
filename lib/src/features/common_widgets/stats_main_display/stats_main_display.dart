import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainDisplay extends ConsumerWidget {
  // This class create a Container that holds possible charts.
  //  This have the same Size that the calendar.
  const MainDisplay({
    required Widget child,
    Key? key,
  })  : _child = child,
        super(key: key);

  final Widget _child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 340,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: _child,
    );
  }
}



