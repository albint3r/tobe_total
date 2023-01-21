import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../providers/forms/controllers/validators.dart';
import 'single_text_field.dart';

class WeightField extends ConsumerWidget {
  const WeightField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final validator = ref.watch(formValidatorsProvider);
    return SingleTextField(
      typeValue: 'Weight',
      icon: Icons.monitor_weight_outlined,
      hintValue: 'Example: 68.0 kg',
      callBackFunction: validator.isNotValidDouble,
      errorMsg: "Enter weight in kg as decimal (e.g. '50.5 kg')",
      isNumberType: true,
    );
  }
}