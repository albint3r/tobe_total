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
      hintValue: 'Example: 68 kg',
      callBackFunction: FormValidators.isNotValidInteger,
      errorMsg: 'Pleas enter a valid number (No letters or ,.#)',
      isNumberType: true,
    );
  }
}