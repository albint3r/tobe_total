import 'package:flutter/material.dart';
import 'package:tobe_total/src/features/sign_in_and_update/presentation/fields/email_field.dart';
import 'package:tobe_total/src/features/sign_in_and_update/presentation/fields/last_name_field.dart';
import '../../../common_widgets/headers_screens/header_screens.dart';
import '../fields/name_field.dart';
import '../fields/sex_field.dart';
import '../fields/submit_update_profile_form_button.dart';



class UpdateProfileAthleteForm extends StatefulWidget {
  const UpdateProfileAthleteForm({Key? key}) : super(key: key);

  @override
  UpdateProfileAthleteFormState createState() {
    return UpdateProfileAthleteFormState();
  }
}

class UpdateProfileAthleteFormState extends State<UpdateProfileAthleteForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          H1Screens(header: 'Update your profile'),
          const NameField(),
          const LastNameField(),
          const EmailField(),
          const SexFormField(),
          SubmitUpdateClientButton(formKey: _formKey),
        ],
      ),
    );
  }
}


