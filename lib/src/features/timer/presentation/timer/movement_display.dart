import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../../providers/timer/model/training_timer.dart';
import '../../../common_widgets/headers_screens/header_screens.dart';

class MovementDisplay extends ConsumerWidget {
  const MovementDisplay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = ref.watch(trainingTimerProvider);
    return Container(
      margin: const EdgeInsets.all(10),
      width: 300,
      child: Card(
        elevation: 5,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              H3FormFieldsHeader(
                header: 'Movement to do',
              ),
              TextInMovementDisplay(
                  child: Text('Name: ${timer.currentMovement?.name ?? ''}')),
              TextInMovementDisplay(
                  child: Text(
                      'Repetitions: ${timer.currentMovement?.reps ?? ''}')),
            ],
          ),
        ),
      ),
    );
  }
}

class TextInMovementDisplay extends ConsumerStatefulWidget {
  const TextInMovementDisplay({
    required this.child,
    Key? key,
  }) : super(key: key);
  final Widget child;

  @override
  ConsumerState createState() => _TextInMovementDisplayState();
}

class _TextInMovementDisplayState extends ConsumerState<TextInMovementDisplay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
      child: widget.child,
    );
  }
}
