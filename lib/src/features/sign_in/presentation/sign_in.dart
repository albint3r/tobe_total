// Import
// Dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Common widgets
import '../../../data_base/client.dart';
import '../../common_widgets/bottom_nav_bar/presentation.dart';
import '../../common_widgets/floating_action_btn/presentation.dart';
// Project Modules
import 'package:tobe_total/src/features/sign_in/presentation/single_text_field.dart';
import '../../../theme/controller.dart';

class SignIn extends ConsumerStatefulWidget {
  const SignIn({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _SignInState();
}

class _SignInState extends ConsumerState<SignIn> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = ref.watch(isDarkModeProviderNotifier);

    return Scaffold(
      body: const MyCustomForm(),
      bottomNavigationBar: const BottomNavBar(),
      floatingActionButton: const FloatBottomBtn(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // TODO remove later this app bar from here
      appBar: AppBar(
        title: const Text('Tobe Total'),
        actions: [
          Switch(
            value: isDarkMode,
            onChanged: (value) {
              ref.watch(isDarkModeProviderNotifier.notifier).toggle();
            },
          )
        ],
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text('Pleas Create an account',
          style: Theme.of(context).textTheme.headline1,),
          SingleTextField(typeValue: 'Name', icon: Icons.account_box,
              hintValue : 'Example: "John Doe"'),
          SingleTextField(typeValue: 'Email', icon: Icons.email,
              hintValue : 'Example: "example@gmail.com"'),
          // Add a consumer to provide the State
          Consumer(
            builder: (_, WidgetRef ref, __) {
              return ElevatedButton(
                onPressed: () async {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    final client = ref.watch(clientProvider);
                    client.createNewUser();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('You create successfully your account')),
                    );
                  }
                },
                child: const Text('Submit'),
              );
            },
          ),
        ],
      ),
    );
  }
}


