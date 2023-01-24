import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../providers/cliente/model/cliente_model_provider.dart';
import '../../../../providers/forms/goal/goal_provider.dart';
import '../../../common_widgets/headers_screens/header_screens.dart';

class GroupGoalCheckFields extends ConsumerStatefulWidget {
  const GroupGoalCheckFields({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _GroupGoalCheckFieldsState();
}

class _GroupGoalCheckFieldsState extends ConsumerState<GroupGoalCheckFields> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width * .90,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            H3FormFieldsHeader(header: 'Select your fitness Goal:'),
            GoalCheckBoxField(
              goalName: 'Resistance',
              enumGoals: Goals.resistance,
              goalSpecification: 'Get More resistance and Endurance',
            ),
            GoalCheckBoxField(
              goalName: 'Maintenance',
              enumGoals: Goals.maintenance,
              goalSpecification: 'Maintain your gains and Weight',
            ),
            GoalCheckBoxField(
              goalName: 'Strength',
              enumGoals: Goals.strength,
              goalSpecification: 'Get More Strength and Muscle',
            ),
          ],
        ),
      ),
    );
  }
}

class GoalCheckBoxField extends ConsumerStatefulWidget {
  GoalCheckBoxField({
    required this.goalName,
    required this.goalSpecification,
    required this.enumGoals,
    Key? key,
  }) : super(key: key);
  String goalName;
  String goalSpecification;
  final enumGoals;

  @override
  ConsumerState createState() => _GoalCheckBoxFieldState();
}

class _GoalCheckBoxFieldState extends ConsumerState<GoalCheckBoxField> {
  @override
  Widget build(BuildContext context) {
    return RadioListTile<Goals>(
      controlAffinity: ListTileControlAffinity.trailing,
      title: Text(widget.goalName),
      subtitle: Text(widget.goalSpecification),
      value: widget.enumGoals,
      onChanged: (goalValue) {
        // Get the Level Manager to update the state in the
        final goalManager = ref.watch(goalManagerProvider);
        goalManager.selectGoalOnForm(ref, goalValue!);
        // Extract the index. Because in SQLite the information is a INTEGER CATEGORY
        final int indexGoal = goalManager.getIndexGoal(goalValue);
        // Set the value in the Client Object to later update all the information.
        ref.watch(clientProvider).setGoalFieldInState(indexGoal);
      },
      // This control the state of the form
      groupValue: ref.watch(goalProvider),
    );
  }
}
