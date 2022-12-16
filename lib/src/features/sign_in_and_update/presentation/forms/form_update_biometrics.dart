import 'package:flutter/material.dart';
import '../../../common_widgets/headers_screens/header_screens.dart';
import '../fields/age_field.dart';
import '../fields/height_field.dart';
import '../fields/sex_field.dart';
import '../fields/submit_update_profile_form_button.dart';
import '../fields/weight_field.dart';

class BiometricsForm extends StatefulWidget {
  const BiometricsForm({Key? key}) : super(key: key);

  @override
  BiometricsFormState createState() {
    return BiometricsFormState();
  }
}

class BiometricsFormState extends State<BiometricsForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          H1Screens(header: 'Biometrics Information'),
          const SubTitleHeaderH1(subHeader: 'Update your Biometrics to get better trainings and stats'),
          const AgeField(),
          const WeightField(),
          const HeightField(),
          const SexFormField(),
          SubmitUpdateClientButton(
              formKey: _formKey,
              selectedFields: const ['age', 'weight', 'height', 'sex']),
        ],
      ),
    );
  }
}
