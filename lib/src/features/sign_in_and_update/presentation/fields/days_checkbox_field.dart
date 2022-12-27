import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../providers/cliente/controllers/cliente_model_provider.dart';
import '../../../../providers/forms/itinerary/days_field_provider.dart';
import '../../../common_widgets/headers_screens/header_screens.dart';

class GroupDaysCheckFields extends ConsumerStatefulWidget {
  // this is the list select form of the training days
  const GroupDaysCheckFields({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _GroupDaysCheckFieldsState();
}

class _GroupDaysCheckFieldsState extends ConsumerState<GroupDaysCheckFields> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width * .90,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            H3FormFieldsHeader(header: 'Select training days:'),
            DayCheckBoxField(
              dayName: 'Monday',
              currentProvider: mondayProvider,
            ),
            DayCheckBoxField(
              dayName: 'Tuesday',
              currentProvider: tuesdayProvider,
            ),
            DayCheckBoxField(
              dayName: 'Wednesday',
              currentProvider: wednesdayProvider,
            ),
            DayCheckBoxField(
              dayName: 'Thursday',
              currentProvider: thursdayProvider,
            ),
            DayCheckBoxField(
              dayName: 'Friday',
              currentProvider: fridayProvider,
            ),
            DayCheckBoxField(
              dayName: 'Saturday',
              currentProvider: saturdayProvider,
            ),
            DayCheckBoxField(
              dayName: 'Sunday',
              currentProvider: sundayProvider,
            ),
          ],
        ),
      ),
    );
  }
}

class DayCheckBoxField extends ConsumerStatefulWidget {
  DayCheckBoxField({
    required this.dayName,
    required this.currentProvider,
    Key? key,
  }) : super(key: key);
  String dayName;
  StateProvider<bool> currentProvider;

  @override
  ConsumerState createState() => _DayCheckBoxFieldState();
}

class _DayCheckBoxFieldState extends ConsumerState<DayCheckBoxField> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      secondary: const Icon(Icons.calendar_month),
      title: Text(widget.dayName),
      value: ref.watch(widget.currentProvider),
      onChanged: (val) {
        // To avoid create a provider for each day I decided to create a setState to
        // handel the check mark in the form field
        ref.watch(widget.currentProvider.notifier).state = val!;
        // Add value to client state
        ref.watch(clientProvider).setTrainingDaysInState(widget.dayName, val);
      },
    );
  }
}

// class MondayCheckBoxField extends ConsumerStatefulWidget {
//   const MondayCheckBoxField({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   ConsumerState createState() => _MondayCheckBoxFieldState();
// }
//
// class _MondayCheckBoxFieldState extends ConsumerState<MondayCheckBoxField> {
//   @override
//   Widget build(BuildContext context) {
//     return CheckboxListTile(
//       secondary: const Icon(Icons.calendar_month),
//       title: const Text('Monday'),
//       value: ref.watch(mondayProvider),
//       onChanged: (val) {
//         // To avoid create a provider for each day I decided to create a setState to
//         // handel the check mark in the form field
//         ref.watch(mondayProvider.notifier).state = val!;
//         // Add value to client state
//         ref.watch(clientProvider).setTrainingDaysInState('Monday', val);
//       },
//     );
//   }
// }
//
// class TuesdayCheckBoxField extends ConsumerStatefulWidget {
//   const TuesdayCheckBoxField({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   ConsumerState createState() => _TuesdayCheckBoxFieldState();
// }
//
// class _TuesdayCheckBoxFieldState extends ConsumerState<TuesdayCheckBoxField> {
//   @override
//   Widget build(BuildContext context) {
//     return CheckboxListTile(
//       secondary: const Icon(Icons.calendar_month),
//       title: const Text('Tuesday'),
//       value: ref.watch(tuesdayProvider),
//       onChanged: (val) {
//         // To avoid create a provider for each day I decided to create a setState to
//         // handel the check mark in the form field
//         ref.watch(tuesdayProvider.notifier).state = val!;
//         // Add value to client state
//         ref.watch(clientProvider).setTrainingDaysInState('Tuesday', val);
//       },
//     );
//   }
// }
