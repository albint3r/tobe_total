import 'package:flutter/material.dart';
import '../../features/sign_in_and_update/presentation/forms/form_update_equipment.dart';

class UpdateAthletEquipment extends StatelessWidget {
  const UpdateAthletEquipment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: EquipmentForm(),
    );
  }
}