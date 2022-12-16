import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/form_validators.dart';
import 'single_text_field.dart';

class TimeToTrainField extends ConsumerWidget {
  const TimeToTrainField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleTextField(
      typeValue: 'Time to train',
      icon: Icons.timelapse,
      hintValue: 'Example: 90 min',
      callBackFunction: FormValidators.isNotValidInteger,
      errorMsg: 'Pleas enter a valid number (No letters or ,.#)',
      isNumberType: true,
    );
  }
}