import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data_base/model/wods.dart';
import '../../block/model/block_model_provider.dart';

final wodsModelProvider = StateProvider<WODs>((ref) {
  // get the WOD Class
  return WODs();
});

final startedDayOfTheWeekDateProvider = Provider<String>((ref) {
  // Return the string of the Started day of the week date. This helps
  // to create the days complete of the client in the progress section.
  final DateTime today = DateTime.now();
  // We rest 1  to penalize the days and have the exact start day of the week.
  int startDayOfTheWeek = today.day - (today.weekday - 1);
  return '${today.year}-${today.month}-$startDayOfTheWeek';
});

final selectedWodInformationProvider = StateProvider<Map>((ref) {
  // This help to select the current information of the WOD Card
  return {};
});

final wodIdProvider = StateProvider<int>((ref) {
  // This helps to make the change of screens between the calendar
  // to the wod information
  return -1;
});

