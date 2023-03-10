import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../providers/forms/controllers/validators.dart';
import 'single_text_field.dart';

class TimeToTrainField extends ConsumerWidget {
  const TimeToTrainField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final validator = ref.watch(formValidatorsProvider);
    return SingleTextField(
      typeValue: 'Time to train',
      icon: Icons.timelapse,
      hintValue: 'Example: 90 min',
      callBackFunction: validator.isNotMultipleOfFive,
      errorMsg: "Enter training time in minutes, multiple of 5 (e.g. 5,10,15,20).",
      isNumberType: true,
    );
  }
}