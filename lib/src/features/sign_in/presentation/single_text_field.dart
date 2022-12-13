import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data_base/model/client.dart';

class SingleTextField extends ConsumerWidget {
  SingleTextField({
    required this.typeValue,
    required this.hintValue,
    required this.icon,
    required this.callBackFunction,
    required this.errorMsg,
    Key? key,
  }) : super(key: key);

  String typeValue;
  String hintValue;
  IconData icon;
  Function(String) callBackFunction = (value) => value.isEmpty;
  String errorMsg;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: TextFormField(
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
          print('Values corrected Validated and added to client object!');
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
