import 'package:flutter/material.dart';
import '../../../common_widgets/headers_screens/header_screens.dart';
import '../fields/equipment_checkbox_field.dart';
import '../submitbuttons/submit_cancel_update_profile.dart';
import '../submitbuttons/submit_equipment.dart';
import '../submitbuttons/submit_update_profile_form_button.dart';

class EquipmentForm extends StatefulWidget {
  const EquipmentForm({Key? key}) : super(key: key);

  @override
  EquipmentFormState createState() {
    return EquipmentFormState();
  }
}

class EquipmentFormState extends State<EquipmentForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          const H1Screens(
            header: 'Equipment',
            isInListView: true,
          ),
          const SubTitleHeaderH1(
              subHeader:
              'Select the time and the days your are training to update the workout generator'),
          Container(
              margin: const EdgeInsets.only(left: 15, right: 15),
              child: const EquipmentGroupCheckBoxFields()),
          SubmitUpdateEquipmentButton(
              formKey: _formKey,
              isExpanded: false),
          const SubmitCancelChanges()
        ],
      ),
    );
  }
}