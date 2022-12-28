import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/providers/cliente/controllers/client_provider.dart';
import '../../../../providers/cliente/model/cliente_model_provider.dart';
import '../../../../providers/forms/athlete_level/level_provider.dart';
import '../../../common_widgets/headers_screens/header_screens.dart';

class GroupLevelCheckFields extends ConsumerStatefulWidget {
  const GroupLevelCheckFields({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _GroupLevelCheckFieldsState();
}

class _GroupLevelCheckFieldsState extends ConsumerState<GroupLevelCheckFields> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          H3FormFieldsHeader(header: 'Select your fitness level:'),
          LevelCheckBoxField(
            levelName: 'Beginner',
            enumLevel: Level.beginner,
            levelSpecification: '0 to 5 Months',
          ),
          LevelCheckBoxField(
            levelName: 'Intermediate',
            enumLevel: Level.intermediate,
            levelSpecification: 'More than 5 Months to 1 year',
          ),
          LevelCheckBoxField(
            levelName: 'Advance',
            enumLevel: Level.advance,
            levelSpecification: 'More than 1 year to 3 year',
          ),
          LevelCheckBoxField(
            levelName: 'Elite',
            enumLevel: Level.elite,
            levelSpecification: 'More than 3 year',
          ),
        ],
      ),
    );
  }
}

class LevelCheckBoxField extends ConsumerStatefulWidget {
  LevelCheckBoxField({
    required this.levelName,
    required this.levelSpecification,
    required this.enumLevel,
    Key? key,
  }) : super(key: key);
  String levelName;
  String levelSpecification;
  final enumLevel;

  @override
  ConsumerState createState() => _LevelCheckBoxFieldState();
}

class _LevelCheckBoxFieldState extends ConsumerState<LevelCheckBoxField> {
  @override
  Widget build(BuildContext context) {
    return RadioListTile<Level>(
      controlAffinity: ListTileControlAffinity.trailing,
      title: Text(widget.levelName),
      subtitle: Text(widget.levelSpecification),
      value: widget.enumLevel,
      onChanged: (levelValue) {
        // Get the Level Manager to update the state in the
        final levelManager = ref.watch(levelManagerProvider);
        levelManager.selectLevelOnForm(ref, levelValue!);
        // Extract the index. Because in SQLite the information is a INTEGER CATEGORY
        final int indexLevel = levelManager.getIndexLevel(levelValue);
        // Set the value in the Client Object to later update all the information.
        ref.watch(clientProvider).setLevelFieldInState(indexLevel);
      },
      // This control the state of the form
      groupValue: ref.watch(levelProvider),
    );
  }
}
