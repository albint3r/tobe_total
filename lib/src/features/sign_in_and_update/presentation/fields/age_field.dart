import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../providers/forms/controllers/validators.dart';
import 'single_text_field.dart';

class AgeField extends ConsumerWidget {
  const AgeField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final validator = ref.watch(formValidatorsProvider);
    return SingleTextField(
      typeValue: 'Age',
      icon: Icons.date_range,
      hintValue: 'Example: 37',
      callBackFunction: validator.isNotValidInteger,
      errorMsg: 'Pleas enter a valid number (No letters or ,.#)',
      isNumberType: true,
    );
  }
}