import 'package:flutter/material.dart';
import '../../../common_widgets/headers_screens/header_screens.dart';
import '../fields/goal_field.dart';
import '../fields/level_field.dart';
import '../submitbuttons/submit_cancel_update_profile.dart';
import '../submitbuttons/submit_update_profile_form_button.dart';

class AthleteLevelForm extends StatefulWidget {
  const AthleteLevelForm({Key? key}) : super(key: key);

  @override
  AthleteLevelFormState createState() {
    return AthleteLevelFormState();
  }
}

class AthleteLevelFormState extends State<AthleteLevelForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const H1Screens(header: 'Update Athlete Level', isInListView: false,),
          const SubTitleHeaderH1(
              subHeader:
              'Depending on your level it would be selected your movements'),
          const GroupLevelCheckFields(),
          SubmitUpdateClientButton(
              formKey: _formKey, selectedFields: const ['level'], isExpanded: true),
          const SubmitCancelChanges()
        ],
      ),
    );
  }
}
