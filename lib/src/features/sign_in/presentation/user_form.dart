import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/features/sign_in/presentation/single_text_field.dart';
import '../../../preferences/preferences.dart';
import '../../../data_base/model/client.dart';
import '../../../routes/routes.dart';
import '../../homepage/home_page.dart';

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
          Text(
            'Pleas Create an account',
            style: Theme.of(context).textTheme.headline1,
          ),
          SingleTextField(
              typeValue: 'Name',
              icon: Icons.account_box,
              hintValue: 'Example: "John Doe"'),
          SingleTextField(
              typeValue: 'Email',
              icon: Icons.email,
              hintValue: 'Example: "example@gmail.com"'),
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
                      const SnackBar(
                          content:
                              Text('You create successfully your account')),
                    );
                    // Navigate to -> [home]
                    ref.watch(routesProvider).navigateTo(context, 'home');
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
