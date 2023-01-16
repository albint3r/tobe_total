import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/common_widgets/bottom_nav_bar/presentation/bottom_nav_bar2.dart';
import '../features/block_plan_manage/presentation/block_display.dart';


class BlockPlanScreen extends ConsumerWidget {
  const BlockPlanScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      bottomNavigationBar: CurveBottomNavBar(),
      body: BlockDisplay(),
    );
  }
}