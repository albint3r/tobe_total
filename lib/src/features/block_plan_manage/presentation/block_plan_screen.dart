import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common_widgets/bottom_nav_bar/presentation/bottom_nav_bar2.dart';


class BlockPlanScreen extends ConsumerWidget {
  const BlockPlanScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      bottomNavigationBar: CurveBottomNavBar(),
      body: Center(child: Text('Block Screen')),
    );
  }
}