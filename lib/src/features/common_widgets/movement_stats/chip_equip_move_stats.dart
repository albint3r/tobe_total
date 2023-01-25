import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:string_ext/string_ext.dart';

import '../../../providers/my_movements/controllers/my_movements_controller.dart';


/// A widget that displays a chip with the first letter of the [nameEquipment]
/// as the avatar and the full [nameEquipment] as the label.
class ChipEquipmentMoveStats extends ConsumerWidget {
  /// Creates a new instance of the [ChipEquipmentMoveStats] widget.
  ///
  /// The [nameEquipment] parameter must not be null.
  const ChipEquipmentMoveStats({
    required this.noEquipment,
    required this.dumbbells,
    required this.kettlebells,
    required this.bench,
    required this.barbell,
    required this.weightMachinesSelectorized,
    required this.resistanceBandsCables,
    required this.leggings,
    required this.medicineBall,
    required this.stabilityBall,
    required this.ball,
    required this.trx,
    required this.raisedPlatformBox,
    required this.box,
    required this.rings,
    required this.pullUpBar,
    required this.parallelsBar,
    required this.wall,
    required this.pole,
    required this.trineo,
    required this.rope,
    required this.wheel,
    required this.assaultBike,
    Key? key,
  }) : super(key: key);
  final int noEquipment;
  final int dumbbells;
  final int kettlebells;
  final int bench;
  final int barbell;
  final int weightMachinesSelectorized;
  final int resistanceBandsCables;
  final int leggings;
  final int medicineBall;
  final int stabilityBall;
  final int ball;
  final int trx;
  final int raisedPlatformBox;
  final int box;
  final int rings;
  final int pullUpBar;
  final int parallelsBar;
  final int wall;
  final int pole;
  final int trineo;
  final int rope;
  final int wheel;
  final int assaultBike;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          width: constraints.maxWidth * .70,
          margin: const EdgeInsets.only(left: 20, top: 15),
          child: Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: generateChipsEquipment(),
          ),
        );
      },
    );
  }

  List<SingleChipEquipment> generateChipsEquipment() {
    List<SingleChipEquipment> finalResults = [];
    Map<String, int> allEquipment = {
      'noEquipment': noEquipment,
      'dumbbells': dumbbells,
      'kettlebells': kettlebells,
      'bench': bench,
      'barbell': barbell,
      'weightMachinesSelectorized': weightMachinesSelectorized,
      'resistanceBandsCables': resistanceBandsCables,
      'leggings': leggings,
      'medicineBall': medicineBall,
      'stabilityBall': stabilityBall,
      'ball': ball,
      'trx': trx,
      'raisedPlatformBox': raisedPlatformBox,
      'box': box,
      'rings': rings,
      'pullUpBar': pullUpBar,
      'parallelsBar': parallelsBar,
      'wall': wall,
      'pole': pole,
      'trineo': trineo,
      'rope': rope,
      'wheel': wheel,
      'assaultBike': assaultBike,
    };
    for (var equip in allEquipment.entries) {
      if (equip.value == 1) {
        final chipEquipment = SingleChipEquipment(
          nameEquipment: equip.key,
        );
        finalResults.add(chipEquipment);
      }
    }
    return finalResults;
  }
}

class SingleChipEquipment extends ConsumerWidget {
  const SingleChipEquipment({
    required this.nameEquipment,
    Key? key,
  }) : super(key: key);
  final String nameEquipment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final equipmentTranslate = ref.watch(equipmentTranslateProvider);
    return Container(
      margin: const EdgeInsets.only(right: 0),
      child: Transform(
        // Change the Size of the chip
        transform: Matrix4.identity()..scale(0.6),
        child: Chip(
          avatar: CircleAvatar(
            child: Text(
              nameEquipment.substring(0, 1).firstToUpper(),
            ),
          ),
          label: Text(equipmentTranslate[nameEquipment]!),
        ),
      ),
    );
  }
}
