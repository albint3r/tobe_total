import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../providers/cliente/model/cliente_model_provider.dart';
import '../../../../providers/routes/routes_provider.dart';
import '../../../../routes/const_url.dart';

class SubmitUpdateEquipmentButton extends ConsumerWidget {
  const SubmitUpdateEquipmentButton({
    required GlobalKey<FormState> formKey,
    required bool isExpanded,
    Key? key,
  })  : _isExpanded = isExpanded,
        _formKey = formKey,
        super(key: key);
  final GlobalKey<FormState> _formKey;
  final bool _isExpanded;

  Widget selectExpandedButton({required Widget child}) {
    // This select if the widget use a Expanded Container or not
    // Because some form are bigger that the height of the screen
    // is necessary to add a List View, but if the list view is with a Expanded
    // this would cause errors in the app.
    Widget parent;
    Alignment alignment = Alignment.bottomCenter;
    if (_isExpanded) {
      parent = Expanded(
          child: Align(
            alignment: alignment,
            child: child,
          ));
    } else {
      parent = Align(
        alignment: alignment,
        child: child,
      );
    }
    return parent;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return selectExpandedButton(
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
              client.updateUserEquipment();
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
    );
  }
}
