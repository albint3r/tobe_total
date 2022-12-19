import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/form_validators.dart';
import 'single_text_field.dart';

class EmailField extends ConsumerWidget {
  const EmailField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleTextField(
      typeValue: 'Email',
      icon: Icons.email,
      hintValue: 'Example: "example@gmail.com"',
      callBackFunction: FormValidators.isNotValidEmail,
      errorMsg: 'Pleas enter a valid Email',
      isNumberType: false,
    );
  }
}