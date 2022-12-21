import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:tobe_total/src/features/wod_plan_manage/presentation/wod_display.dart';
import '../../common_widgets/bottom_nav_bar/presentation/bottom_nav_bar2.dart';


class WODPlanScreen extends ConsumerWidget {
  const WODPlanScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return const Scaffold(
      bottomNavigationBar: CurveBottomNavBar(),
      body: WODDisplay(),
    );
  }
}


