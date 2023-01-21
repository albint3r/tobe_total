import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../providers/forms/controllers/validators.dart';
import 'single_text_field.dart';

class HeightField extends ConsumerWidget {
  const HeightField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final validator = ref.watch(formValidatorsProvider);
    return SingleTextField(
      typeValue: 'Height',
      icon: Icons.height,
      hintValue: 'Example: 170.0 cm',
      // callBackFunction: FormValidators.isNotValidDouble,
      callBackFunction: validator.isNotValidDouble,
      errorMsg: "Enter height in centimeters (e.g. '180 cm')",
      isNumberType: true,
    );
  }
}