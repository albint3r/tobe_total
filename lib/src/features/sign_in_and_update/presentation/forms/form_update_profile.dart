import 'package:flutter/material.dart';
import 'package:tobe_total/src/features/sign_in_and_update/presentation/fields/email_field.dart';
import 'package:tobe_total/src/features/sign_in_and_update/presentation/fields/last_name_field.dart';
import '../../../common_widgets/headers_screens/header_screens.dart';
import '../fields/age_field.dart';
import '../fields/height_field.dart';
import '../fields/name_field.dart';
import '../fields/sex_field.dart';
import '../fields/submit_update_profile_form_button.dart';
import '../fields/weight_field.dart';

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
          const AgeField(),
          const WeightField(),
          const HeightField(),
          const SexFormField(),
          SubmitUpdateClientButton(formKey: _formKey),
        ],
      ),
    );
  }
}
