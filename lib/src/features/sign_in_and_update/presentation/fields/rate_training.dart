import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/providers/proxies/movement_proxy.dart';
import '../../../../providers/timer/model/training_timer.dart';
import '../../../common_widgets/headers_screens/header_screens.dart';

class GroupRateTrainingFields extends ConsumerWidget {
  const GroupRateTrainingFields({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = ref.watch(trainingTimerProvider);
    return Column(
      children: getMovesToRate(timer.selectBlockMoveToShow().movements),
    );
  }

  List<RateTrainingField> getMovesToRate(Map<int, ProxyMovement> movesToShow) {
    return [
      for (var move in movesToShow.entries)
        RateTrainingField(
          move: move.value,
        )
    ];
  }
}

class RateTrainingField extends ConsumerStatefulWidget {
  const RateTrainingField({
    required this.move,
    Key? key,
  }) : super(key: key);
  final ProxyMovement move;

  @override
  ConsumerState createState() => _RateTrainingFieldState();
}

class _RateTrainingFieldState extends ConsumerState<RateTrainingField> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 300,
        child: Column(
          children: [
            TitleFieldRateMove(moveTitle: '${widget.move.name}'),
            FieldToMoveUpdate(
              move: widget.move,
              rateLabel: 'You did the Move?',
              callBack: widget.move.updateDidMove,
            ),
            FieldToMoveUpdate(
              move: widget.move,
              rateLabel: 'You did all Reps Assign?',
              callBack: widget.move.updateDidAllReps,
            ),
            FieldToMoveUpdate(
              move: widget.move,
              rateLabel: 'You can do more Reps?',
              callBack: widget.move.updateCanDoMoreReps,
            ),
          ],
        ),
      ),
    );
  }
}

class FieldToMoveUpdate extends StatefulWidget {
  const FieldToMoveUpdate({
    required this.move,
    required this.rateLabel,
    required this.callBack,
    Key? key,
  }) : super(key: key);
  final ProxyMovement move;
  final String rateLabel;
  final void Function(bool) callBack;

  @override
  State<FieldToMoveUpdate> createState() => _FieldToMoveUpdateState();
}

class _FieldToMoveUpdateState extends State<FieldToMoveUpdate> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(widget.rateLabel),
          ),
          Radio<bool>(
            visualDensity:
                const VisualDensity(vertical: VisualDensity.minimumDensity),
            value: false,
            groupValue: isSelected,
            onChanged: (value) {
              setState(() {
                isSelected = value!;
                widget.callBack(isSelected);
              });
            },
          ),
          Radio<bool>(
            visualDensity:
                const VisualDensity(vertical: VisualDensity.minimumDensity),
            value: true,
            groupValue: isSelected,
            onChanged: (value) {
              setState(() {
                isSelected = value!;
                widget.callBack(isSelected);
              });
            },
          )
        ],
      ),
    );
  }
}

class TitleFieldRateMove extends ConsumerWidget {
  const TitleFieldRateMove({
    required this.moveTitle,
    Key? key,
  }) : super(key: key);
  final String moveTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            margin: const EdgeInsets.only(right: 5),
            child: H3FormFieldsHeader(header: moveTitle),
          ),
        ),
        const Text('No'),
        const Padding(
          padding: EdgeInsets.only(left: 22, right: 18),
          child: Text('Yes'),
        )
      ],
    );
  }
}
