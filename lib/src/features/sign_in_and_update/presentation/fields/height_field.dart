import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/form_validators.dart';
import 'single_text_field.dart';

class HeightField extends ConsumerWidget {
  const HeightField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleTextField(
      typeValue: 'Height',
      icon: Icons.height,
      hintValue: 'Example: 170.0 cm',
      callBackFunction: FormValidators.isNotValidDouble,
      errorMsg: 'Pleas enter a number with a decimal and a number after the decimal.',
      isNumberType: true,
    );
  }
}