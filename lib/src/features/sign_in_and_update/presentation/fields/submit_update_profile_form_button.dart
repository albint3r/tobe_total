import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../providers/client_provider.dart';
import '../../../../providers/routes_provider.dart';
import '../../../../routes/const_url.dart';

class SubmitUpdateClientButton extends ConsumerWidget {
  const SubmitUpdateClientButton({

    required List selectedFields,
    required GlobalKey<FormState> formKey,
    Key? key,
  })  : _formKey = formKey,
        _selectedFields = selectedFields,
        super(key: key);
  final List _selectedFields;
  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.only(top: 15, bottom: 15),
          child: ElevatedButton(
            onPressed: () async {
              // Validate if all the [FORM] information is correct
              if (_formKey.currentState!.validate()) {
                // If the form is valid, display a snack-bar. In the real world,
                // Save the info in SQLite and chang screen.
                final client = ref.watch(clientProvider);
                //The [client] object have in their attributes all the
                //data textFields form. This is how it send the info.
                client.updateUser(_selectedFields);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Your Update successfully your profile')),
                );
                // Navigate to -> [home]
                ref.watch(routesProvider).navigateTo(context, ConstantsUrls.settingsMenu);
              }
            },
            child: const Text('Save Changes'),
          ),
        ),
      ),
    );
  }
}
