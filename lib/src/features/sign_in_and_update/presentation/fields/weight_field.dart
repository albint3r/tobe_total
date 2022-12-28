import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/form_validators.dart';
import 'single_text_field.dart';

class WeightField extends ConsumerWidget {
  const WeightField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleTextField(
      typeValue: 'Weight',
      icon: Icons.monitor_weight_outlined,
      hintValue: 'Example: 68.0 kg',
      callBackFunction: FormValidators.isNotValidDouble,
      errorMsg: 'Pleas enter a number with a decimal and a number after the decimal.',
      isNumberType: true,
    );
  }
}