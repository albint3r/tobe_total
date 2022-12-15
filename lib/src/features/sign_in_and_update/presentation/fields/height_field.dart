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
      hintValue: 'Example: 170 cm',
      callBackFunction: FormValidators.isNotValidInteger,
      errorMsg: 'Pleas enter a valid number (No letters or ,.#)',
      isNumberType: true,
    );
  }
}