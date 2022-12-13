import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data_base/model/client.dart';

class SingleTextField extends ConsumerWidget {
  SingleTextField({
    required this.typeValue,
    required this.icon,
    required this.hintValue,
    Key? key,
  }) : super(key: key);

  String typeValue;
  String hintValue;
  IconData icon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        decoration: InputDecoration(
          icon: Icon(icon),
          label: Text(typeValue),
          hintText: hintValue
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          final client = ref.watch(clientProvider);
          client.setFieldValueInState(typeValue, value);
          print('Values corrected Validated!');
          return null;
        },
      ),
    );
  }
}
