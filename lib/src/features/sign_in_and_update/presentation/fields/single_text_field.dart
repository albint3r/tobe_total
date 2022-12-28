import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../providers/cliente/controllers/client_provider.dart';
import '../../../../providers/cliente/model/cliente_model_provider.dart';

class SingleTextField extends ConsumerWidget {
  SingleTextField({
    required this.typeValue,
    required this.hintValue,
    required this.icon,
    required this.callBackFunction,
    required this.errorMsg,
    required this.isNumberType,
    Key? key,
  }) : super(key: key);

  String typeValue;
  String hintValue;
  IconData icon;
  Function(String) callBackFunction = (value) => value.isEmpty;
  String errorMsg;
  bool isNumberType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(top: 2, bottom: 2,left: 15, right: 15, ),
      padding: const EdgeInsets.all(2),
      child: TextFormField(
        // if the user select number type it will display another keyboard
        keyboardType: isNumberType ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
            icon: Icon(icon), label: Text(typeValue), hintText: hintValue),
        validator: (value) {
          if (notNullOrEmpty(value) || callBackFunction(value!)) {
            return errorMsg;
          }
          final client = ref.watch(clientProvider);
          // this helps to classify the field into the form
          // to add the information later in SQLite
          client.setFieldValueInState(typeValue, value);
          print('The name ->[$typeValue] value ->[$value] was correctly [updated] in SQLite');
          return null;
        },
      ),
    );
  }

  bool notNullOrEmpty(String? fieldValue) {
    // Check if the value is not null or emtpy
    return (fieldValue == null || fieldValue.isEmpty);
  }
}
