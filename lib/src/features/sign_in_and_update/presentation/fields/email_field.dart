import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../providers/forms/controllers/validators.dart';
import 'single_text_field.dart';

class EmailField extends ConsumerWidget {
  const EmailField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final validator = ref.watch(formValidatorsProvider);
    return SingleTextField(
      typeValue: 'Email',
      icon: Icons.email,
      hintValue: 'Example: "example@gmail.com"',
      callBackFunction: validator.isNotValidEmail,
      errorMsg: "Enter a valid email address (e.g. 'example@gmail.com')",
      isNumberType: false,
    );
  }
}
