import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../providers/forms/controllers/validators.dart';
import 'single_text_field.dart';

class LastNameField extends ConsumerWidget {
  const LastNameField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final validator = ref.watch(formValidatorsProvider);
    return SingleTextField(
      typeValue: 'Last Name',
      icon: Icons.account_box,
      hintValue: 'Example: "Doe"',
      callBackFunction: validator.isNotValidName,
      errorMsg: 'Name in Lower Case (min 3, max 20 characters)',
      isNumberType: false,
    );
  }
}