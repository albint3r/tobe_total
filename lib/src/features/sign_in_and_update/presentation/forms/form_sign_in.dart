import 'package:flutter/material.dart';
import 'package:tobe_total/src/features/sign_in_and_update/presentation/submitbuttons/submit_new_client_form_button.dart';
import '../../../common_widgets/headers_screens/header_screens.dart';
import '../fields/email_field.dart';
import '../fields/last_name_field.dart';
import '../fields/name_field.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  SignInFormState createState() {
    return SignInFormState();
  }
}

class SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const H1Screens(
            header: 'Create your profile',
            isInListView: false,
          ),
          const SubTitleHeaderH1(
              subHeader: 'Add your information to star using the app'),
          const NameField(),
          const LastNameField(),
          const EmailField(),
          SubmitCreateClientButton(formKey: _formKey),
        ],
      ),
    );
  }
}
