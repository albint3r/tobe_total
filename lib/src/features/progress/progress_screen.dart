// Imports
// Flutter
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/features/progress/presentation/progression_display.dart';

import '../../preferences_cache/preferences.dart';
import '../../providers/index_bottom_nav_provider.dart';
import '../common_widgets/bottom_nav_bar/presentation/bottom_nav_bar2.dart';

class Progress extends ConsumerStatefulWidget {
  const Progress({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ProgressState();
}

class _ProgressState extends ConsumerState<Progress> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: CurveBottomNavBar(),
      body: ProgressionDisplay(),
    );
  }
}

