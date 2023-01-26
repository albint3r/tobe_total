import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../providers/bottom_nav_bar/controllers/index_bottom_nav_bar_controller.dart';
import '../../../../providers/cliente/controllers/client_provider.dart';
import '../../../../providers/cliente/model/cliente_model_provider.dart';
import '../../../../providers/routes/routes_provider.dart';
import '../../../../providers/training_oracle/settings_manager/settings_training_manager.dart';
import '../../../../routes/const_url.dart';

class SubmitUpdateInitStats extends ConsumerWidget {
  const SubmitUpdateInitStats({
    required GlobalKey<FormState> formKey,
    Key? key,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: ElevatedButton(
        onPressed: () async {
          // Validate if all the [FORM] information is correct
          if (_formKey.currentState!.validate()) {
            // If the form is valid, display a snack-bar. In the real world,
            // Save the info in SQLite and chang screen.
            final client = ref.watch(clientProvider);
            //The [client] object have in their attributes all the
            //data textFields form. This is how it send the info.
            client.updateInitStats();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Wait to util training week is created'),
                duration: Duration(seconds: 1),
              ),
            );
            final trainingWeek =
            await ref.watch(settingsManagerProvider).initTrainingCreation();
            await trainingWeek.initContext();
            await trainingWeek.initWODS();
            await trainingWeek.initWODSBlocks();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('You create successfully your account'),
                duration: Duration(seconds: 2),
              ),
            );
            // Change index of the navigation bar to match with the current page
            ref.watch(bottomNavBarControllerProvider).setStateIndexBottomNavStateProvider(1, ref);
            // Navigate to -> [Training Plan]
            ref.watch(routesProvider).navigateTo(context, ConstantsUrls.trainingPlan);
          }
        },
        child: const Text('Update Profile'),
      ),
    );
  }
}