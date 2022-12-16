import 'package:flutter/material.dart';
import 'forms/form_update_general_information.dart';

class UpdateGeneralInformation extends StatelessWidget {
  const UpdateGeneralInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GeneralInformationForm(),
    );
  }
}
