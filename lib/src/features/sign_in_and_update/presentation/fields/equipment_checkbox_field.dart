import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/providers/cliente/model/cliente_model_provider.dart';
import '../../../../providers/forms/equipment/equipment_provider.dart';
import '../../../common_widgets/headers_screens/header_screens.dart';

class EquipmentGroupCheckBoxFields extends ConsumerStatefulWidget {
  // this is the list select form of the training days
  const EquipmentGroupCheckBoxFields({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _EquipmentGroupCheckBoxFieldsState();
}

class _EquipmentGroupCheckBoxFieldsState
    extends ConsumerState<EquipmentGroupCheckBoxFields> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width * .90,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            H3FormFieldsHeader(header: 'Select your training equipment:'),
            EquipmentBoxField(
              equipmentName: 'Assault Bike',
              currentProvider: assaultBikeProvider,
            ),
            EquipmentBoxField(
              equipmentName: 'Barbell',
              currentProvider: barbellProvider,
            ),
            EquipmentBoxField(
              equipmentName: 'Bench',
              currentProvider: benchProvider,
            ),
            EquipmentBoxField(
              equipmentName: 'Box',
              currentProvider: boxProvider,
            ),
            EquipmentBoxField(
              equipmentName: 'Ball',
              currentProvider: ballProvider,
            ),
            EquipmentBoxField(
              equipmentName: 'Dumbbells',
              currentProvider: dumbbellsProvider,
            ),
            EquipmentBoxField(
              equipmentName: 'Kettlebells',
              currentProvider: kettlebellsProvider,
            ),
            EquipmentBoxField(
              equipmentName: 'Leggings',
              currentProvider: leggingsProvider,
            ),
            EquipmentBoxField(
              equipmentName: 'Medicine Ball',
              currentProvider: medicineBallProvider,
            ),
            EquipmentBoxField(
              equipmentName: 'No Equipment',
              currentProvider: noEquipmentProvider,
            ),
            EquipmentBoxField(
              equipmentName: 'Parallels Bar',
              currentProvider: parallelsBarProvider,
            ),
            EquipmentBoxField(
              equipmentName: 'Pole',
              currentProvider: poleProvider,
            ),
            EquipmentBoxField(
              equipmentName: 'Pull-Up Bar',
              currentProvider: pullUpBarProvider,
            ),
            EquipmentBoxField(
              equipmentName: 'Raised Platform Box',
              currentProvider: raisedPlatformBoxProvider,
            ),
            EquipmentBoxField(
              equipmentName: 'Resistance Bands Cables',
              currentProvider: resistanceBandsCablesProvider,
            ),
            EquipmentBoxField(
              equipmentName: 'Rings',
              currentProvider: ringsProvider,
            ),
            EquipmentBoxField(
              equipmentName: 'Rope',
              currentProvider: ropeProvider,
            ),
            EquipmentBoxField(
              equipmentName: 'Stability BallProvider',
              currentProvider: stabilityBallProvider,
            ),
            EquipmentBoxField(
              equipmentName: 'Trineo',
              currentProvider: trineoProvider,
            ),
            EquipmentBoxField(
              equipmentName: 'TRX',
              currentProvider: trxProvider,
            ),
            EquipmentBoxField(
              equipmentName: 'Wall',
              currentProvider: wallProvider,
            ),
            EquipmentBoxField(
              equipmentName: 'Weight Machines Selectorized',
              currentProvider: weightMachinesSelectorizedProvider,
            ),
            EquipmentBoxField(
              equipmentName: 'Wheel',
              currentProvider: wheelProvider,
            ),
          ],
        ),
      ),
    );
  }
}

class EquipmentBoxField extends ConsumerStatefulWidget {
  const EquipmentBoxField({
    required this.equipmentName,
    required this.currentProvider,
    Key? key,
  }) : super(key: key);
  final String equipmentName;
  final StateProvider<bool> currentProvider;

  @override
  ConsumerState createState() => _EquipmentBoxFieldState();
}

class _EquipmentBoxFieldState extends ConsumerState<EquipmentBoxField> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      secondary: const Icon(Icons.calendar_month),
      title: Text(widget.equipmentName),
      value: ref.watch(widget.currentProvider),
      onChanged: (val) {
        // To avoid create a provider for each day I decided to create a setState to
        // handel the check mark in the form field
        ref.watch(widget.currentProvider.notifier).state = val!;
        ref.watch(clientProvider).setEquipment(
            widget.equipmentName, ref.watch(widget.currentProvider));
        // Add value to client state
      },
    );
  }
}
