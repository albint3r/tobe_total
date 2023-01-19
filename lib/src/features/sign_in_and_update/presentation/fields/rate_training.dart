import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/providers/proxies/movement_proxy.dart';

class RateTrainingCheckFields extends ConsumerWidget {
  RateTrainingCheckFields({
    required this.move,
    Key? key,
  }) : super(key: key);
  final ProxyMovement move;
  bool isSelected = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Card(
        child: Row(
          children: [
            Text(move.name ?? 'No Name'),
            Container(
              width: 100,
              child: RadioListTile(
                value: isSelected,
                groupValue: isSelected,
                onChanged: (value) {
                  print('Changing----------------');
                },
              ),
            ),
            Container(
              width: 100,
              child: RadioListTile(
                value: !isSelected,
                groupValue: isSelected,
                onChanged: (value) {
                  print('Changing----------------');
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
