import 'package:flutter/material.dart';
import 'package:tobe_total/src/features/sign_in_and_update/presentation/fields/height_field.dart';
import 'package:tobe_total/src/features/sign_in_and_update/presentation/submitbuttons/submit_new_client_form_button.dart';
import '../../../common_widgets/headers_screens/header_screens.dart';
import '../fields/age_field.dart';
import '../fields/days_checkbox_field.dart';
import '../fields/email_field.dart';
import '../fields/equipment_checkbox_field.dart';
import '../fields/last_name_field.dart';
import '../fields/level_field.dart';
import '../fields/name_field.dart';
import '../fields/time_to_train_field.dart';
import '../fields/weight_field.dart';
import '../submitbuttons/submit_update_init_stats.dart';

class UpdateInitStatsForm extends StatefulWidget {
  const UpdateInitStatsForm({Key? key}) : super(key: key);

  @override
  UpdateInitStatsFormState createState() {
    return UpdateInitStatsFormState();
  }
}

class UpdateInitStatsFormState extends State<UpdateInitStatsForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const H1Screens(
              header: 'Configure your training',
              isInListView: false,
            ),
            const SubTitleHeaderH1(
                subHeader: 'Select the days, time, equipment, level and Goal to create your first training'),
            const AgeField(),
            const WeightField(),
            const HeightField(),
            const TimeToTrainField(),
            const GroupDaysCheckFields(),
            const EquipmentGroupCheckBoxFields(),
            const GroupLevelCheckFields(),
            SubmitUpdateInitStats(formKey: _formKey),
          ],
        ),
      ),
    );
  }
}