import 'package:flutter/material.dart';
import 'package:tobe_total/src/features/sign_in/presentation/fields/submit_new_client_form_button.dart';
import '../../../common_widgets/headers_screens/header_screens.dart';
import '../fields/email_field.dart';
import '../fields/last_name_field.dart';
import '../fields/name_field.dart';

class CreateProfileAthleteForm extends StatefulWidget {
  const CreateProfileAthleteForm({Key? key}) : super(key: key);

  @override
  CreateProfileAthleteFormState createState() {
    return CreateProfileAthleteFormState();
  }
}

class CreateProfileAthleteFormState extends State<CreateProfileAthleteForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          H1Screens(header: 'Create your profile'),
          const NameField(),
          const LastNameField(),
          const EmailField(),
          SubmitCreateClientButton(formKey: _formKey),
        ],
      ),
    );
  }
}
