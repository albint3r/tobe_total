import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatsMainDisplay extends ConsumerWidget {
  const StatsMainDisplay({
    required Widget child,
    Key? key,
  })  : _child = child,
        super(key: key);

  final Widget _child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 10,
      child: Container(
        height: 220,
        margin: const EdgeInsets.only(left: 5, right: 5),
        child: _child,
      ),
    );
  }
}