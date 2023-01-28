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
              imgName: 'assault_bike',
              currentProvider: assaultBikeProvider,
            ),
            EquipmentBoxField(
              equipmentName: 'Barbell',
              imgName: 'barbell',
              currentProvider: barbellProvider,
            ),
            EquipmentBoxField(
              equipmentName: 'Bench',
              imgName: 'bench',
              currentProvider: benchProvider,
            ),
            EquipmentBoxField(
              equipmentName: 'Box',
              imgName: 'box',
              currentProvider: boxProvider,
            ),
            EquipmentBoxField(
              equipmentName: 'Dumbbells',
              imgName: 'dumbbells',
              currentProvider: dumbbellsProvider,
            ),
            EquipmentBoxField(
              equipmentName: 'Kettlebells',
              imgName: 'kettlebells',
              currentProvider: kettlebellsProvider,
            ),
            EquipmentBoxField(
              equipmentName: 'Leggings',
              imgName: 'leggings',
              currentProvider: leggingsProvider,
            ),
            EquipmentBoxField(
              equipmentName: 'Medicine Ball',
              imgName: 'medicine_ball',
              currentProvider: medicineBallProvider,
            ),
            EquipmentBoxField(
              equipmentName: 'Parallels Bar',
              imgName: 'parallels_bar',
              currentProvider: parallelsBarProvider,
            ),
            EquipmentBoxField(
              equipmentName: 'Pole',
              imgName: 'pole',
              currentProvider: poleProvider,
            ),
            EquipmentBoxField(
              equipmentName: 'Pull-Up Bar',
              imgName: 'pull_up_bar',
              currentProvider: pullUpBarProvider,
            ),
            EquipmentBoxField(
              equipmentName: 'Raised Platform Box',
              imgName: 'raised_platform_box',
              currentProvider: raisedPlatformBoxProvider,
            ),
            EquipmentBoxField(
              equipmentName: 'Resistance Bands Cables',
              imgName: 'resistance_bands_cables',
              currentProvider: resistanceBandsCablesProvider,
            ),
            EquipmentBoxField(
              equipmentName: 'Rings',
              imgName: 'rings',
              currentProvider: ringsProvider,
            ),
            EquipmentBoxField(
              equipmentName: 'Rope',
              imgName: 'rope',
              currentProvider: ropeProvider,
            ),
            EquipmentBoxField(
              equipmentName: 'Stability BallProvider',
              imgName: 'stability_ball',
              currentProvider: stabilityBallProvider,
            ),
            EquipmentBoxField(
              equipmentName: 'Trineo',
              imgName: 'trineo',
              currentProvider: trineoProvider,
            ),
            EquipmentBoxField(
              equipmentName: 'TRX',
              imgName: 'trx',
              currentProvider: trxProvider,
            ),
            EquipmentBoxField(
              equipmentName: 'Wall',
              imgName: 'wall',
              currentProvider: wallProvider,
            ),
            EquipmentBoxField(
              equipmentName: 'Weight Machines Selectorized',
              imgName: 'weight_machines_selectorized',
              currentProvider: weightMachinesSelectorizedProvider,
            ),
            EquipmentBoxField(
              equipmentName: 'Wheel',
              imgName: 'wheel',
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
    required this.imgName,
    required this.currentProvider,
    Key? key,
  }) : super(key: key);
  final String equipmentName;
  final String imgName;
  final StateProvider<bool> currentProvider;


  @override
  ConsumerState createState() => _EquipmentBoxFieldState();
}

class _EquipmentBoxFieldState extends ConsumerState<EquipmentBoxField> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      secondary: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            image: DecorationImage(
              image: AssetImage("assets/img/${widget.imgName}.png"),
              fit: BoxFit.contain,
            )),
      ),
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
