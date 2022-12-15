import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/form_validators.dart';
import 'single_text_field.dart';

class NameField extends ConsumerWidget {
  const NameField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleTextField(
      typeValue: 'Name',
      icon: Icons.account_box,
      hintValue: 'Example: "John"',
      callBackFunction: FormValidators.isNotValidName,
      errorMsg: 'Name in Lower Case (min 3, max 20 characters)',
      isNumberType: false,
    );
  }
}