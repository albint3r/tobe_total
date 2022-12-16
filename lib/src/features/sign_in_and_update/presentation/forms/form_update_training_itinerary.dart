import 'package:flutter/material.dart';
import 'package:tobe_total/src/features/sign_in_and_update/presentation/fields/email_field.dart';
import 'package:tobe_total/src/features/sign_in_and_update/presentation/fields/last_name_field.dart';
import '../../../common_widgets/headers_screens/header_screens.dart';
import '../fields/age_field.dart';
import '../fields/days_checkbox_field.dart';
import '../fields/height_field.dart';
import '../fields/level_field.dart';
import '../fields/name_field.dart';
import '../fields/sex_field.dart';
import '../fields/submit_update_profile_form_button.dart';
import '../fields/time_to_train_field.dart';
import '../fields/weight_field.dart';

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
      child: Column(
        children: [
          H1Screens(header: 'Training Itinerary'),
          const SubTitleHeaderH1(
              subHeader:
                  'Select the time and the days your are training to update the workout generator'),
          const TimeToTrainField(),
          const GroupDaysCheckFields(),
          SubmitUpdateClientButton(formKey: _formKey, selectedFields: const [
            'time_to_train',
            'monday',
            'tuesday',
            'wednesday',
            'thursday',
            'saturday',
            'sunday'
          ]),
        ],
      ),
    );
  }
}
