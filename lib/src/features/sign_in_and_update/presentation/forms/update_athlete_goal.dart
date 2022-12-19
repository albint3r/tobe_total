import 'package:flutter/material.dart';
import '../../../common_widgets/headers_screens/header_screens.dart';
import '../fields/goal_field.dart';
import '../submitbuttons/submit_cancel_update_profile.dart';
import '../submitbuttons/submit_update_profile_form_button.dart';

class AthleteGoalForm extends StatefulWidget {
  const AthleteGoalForm({Key? key}) : super(key: key);

  @override
  AthleteGoalFormState createState() {
    return AthleteGoalFormState();
  }
}

class AthleteGoalFormState extends State<AthleteGoalForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const H1Screens(header: 'Athlete Goal', isInListView: false,),
          const SubTitleHeaderH1(
              subHeader:
                  'Your Goal is our goal, add your objective to update your next workout'),
          const GroupGoalCheckFields(),
          SubmitUpdateClientButton(
              formKey: _formKey, selectedFields: const ['goal'], isExpanded: true),
          const SubmitCancelChanges()
        ],
      ),
    );
  }
}
