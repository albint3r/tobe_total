import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/training_oracle/settings_manager/settings_training_manager.dart';

class GoToNextTrainingOFTheWeek extends ConsumerWidget {
  const GoToNextTrainingOFTheWeek({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      tooltip: 'Go to your next Training of the week',
      onPressed: () async {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:
        Text('Go to your next training'), elevation: 5,
        ));
      },
      child: const Icon(Icons.navigate_next),
    );
  }
}