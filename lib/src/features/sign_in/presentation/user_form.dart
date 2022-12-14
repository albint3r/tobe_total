import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/features/sign_in/presentation/single_text_field.dart';
import '../../../preferences_cache/preferences.dart';
import '../../../data_base/model/client.dart';
import '../../../routes/const_url.dart';
import '../../../routes/routes.dart';

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  bool isNotValidEmail(String? fieldValue) {
    // Return true if the user don't have a correct email
    if (fieldValue != null) {
      final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
      return  !emailRegExp.hasMatch(fieldValue);
    }
    return false;
  }

  bool isNotValidName(String? fieldValue) {
    // Check if the name is validated
    if (fieldValue != null) {
      final nameRegExp = RegExp(r"[A-Z][a-z0-9_]{3,20}");
      return !nameRegExp.hasMatch(fieldValue);
    }
    return false;
  }

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
            hintValue: 'Example: "John"',
            callBackFunction:isNotValidName,
            errorMsg: 'Name in Lower Case (min 3, max 20 characters)',
          ),
          SingleTextField(
            typeValue: 'Last Name',
            icon: Icons.account_box,
            hintValue: 'Example: "Doe"',
            callBackFunction:isNotValidName,
            errorMsg: 'Name in Lower Case (min 3, max 20 characters)',
          ),
          SingleTextField(
            typeValue: 'Email',
            icon: Icons.email,
            hintValue: 'Example: "example@gmail.com"',
            callBackFunction: isNotValidEmail,
            errorMsg: 'Pleas enter a valid Email',
          ),
          // Add a consumer to provide the State
          Consumer(
            builder: (_, WidgetRef ref, __) {
              return ElevatedButton(
                onPressed: () async {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snack-bar. In the real world,
                    // you'd often call a server or save the information in a database.
                    final client = ref.watch(clientProvider);
                    client.createNewUser();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                              Text('You create successfully your account')),
                    );
                    // Navigate to -> [home]
                    ref.watch(routesProvider).navigateTo(context, ConstantsUrls.progress);
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
