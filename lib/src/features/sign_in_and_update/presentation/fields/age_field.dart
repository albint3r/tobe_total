import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/form_validators.dart';
import 'single_text_field.dart';

class AgeField extends ConsumerWidget {
  const AgeField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleTextField(
      typeValue: 'Age',
      icon: Icons.date_range,
      hintValue: 'Example: 37',
      callBackFunction: FormValidators.isNotValidInteger,
      errorMsg: 'Pleas enter a valid number (No letters or ,.#)',
      isNumberType: true,
    );
  }
}