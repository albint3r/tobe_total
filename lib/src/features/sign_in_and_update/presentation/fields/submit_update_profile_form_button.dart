import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data_base/model/client.dart';
import '../../../../routes/const_url.dart';
import '../../../../routes/routes.dart';

class SubmitUpdateClientButton extends ConsumerWidget {
  const SubmitUpdateClientButton({
    required GlobalKey<FormState> formKey,
    Key? key,
  }) : _formKey = formKey, super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () async {
        // Validate if all the [FORM] information is correct
        if (_formKey.currentState!.validate()) {
          // If the form is valid, display a snack-bar. In the real world,
          // Save the info in SQLite and chang screen.
          final client = ref.watch(clientProvider);
          //The [client] object have in their attributes all the
          //data textFields form. This is how it send the info.
          client.updateUser();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content:
                Text('You create successfully your account')),
          );
          // Navigate to -> [home]
          ref.watch(routesProvider).navigateTo(context, ConstantsUrls.progress);
        }
      },
      child: const Text('Update Profile'),
    );
  }
}