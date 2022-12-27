import 'package:flutter/material.dart';
import '../../../common_widgets/headers_screens/header_screens.dart';
import '../fields/days_checkbox_field.dart';
import '../submitbuttons/submit_cancel_update_profile.dart';
import '../submitbuttons/submit_update_profile_form_button.dart';
import '../fields/time_to_train_field.dart';

class TrainingItineraryForm extends StatefulWidget {
  const TrainingItineraryForm({Key? key}) : super(key: key);

  @override
  TrainingItineraryFormState createState() {
    return TrainingItineraryFormState();
  }
}

class TrainingItineraryFormState extends State<TrainingItineraryForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          const H1Screens(
            header: 'Training Itinerary',
            isInListView: true,
          ),
          const SubTitleHeaderH1(
              subHeader:
                  'Select the time and the days your are training to update the workout generator'),
          const TimeToTrainField(),
          Container(
              margin: const EdgeInsets.only(left: 15, right: 15),
              child: const GroupDaysCheckFields()),
          SubmitUpdateClientButton(
              formKey: _formKey,
              selectedFields: const [
                'time_to_train',
                'monday',
                'tuesday',
                'wednesday',
                'thursday',
                'friday',
                'saturday',
                'sunday'
              ],
              isExpanded: false),
          const SubmitCancelChanges()
        ],
      ),
    );
  }
}
