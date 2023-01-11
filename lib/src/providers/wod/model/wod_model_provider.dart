import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../repositories/wods_repository_repository.dart';
import '../controllers/wod_controller_provider.dart';


final wodsModelProvider = StateProvider<WODs>((ref) {
  // get the WOD Class
  return WODs();
});

final startedDayOfTheWeekDateProvider = Provider<String>((ref) {
  // Return the string of the Started day of the week date. This helps
  // to create the days complete of the client in the progress section.
  final DateTime today = DateTime.now();
  final DateTime startDayOfTheWeek = ref.watch(dateTimeManageControllerProvider).findFirstDateOfTheWeek(today);
  // We rest 1  to penalize the days and have the exact start day of the week.
  return startDayOfTheWeek.toString().substring(0,10);
});


/// A [FutureProvider] that automatically disposes along with its subtree,
/// which provides a boolean value indicating if there are any scheduled training
/// for a specific week.
final existWodsOfTheWeekProvider = FutureProvider.autoDispose<bool>((ref) async {
  /// Get the current value of the "startDayOfTheWeekDateProvider" provider.
  String startDayOfTheWeekDate = ref.watch(startedDayOfTheWeekDateProvider);
  /// Get the "wodsModel" object associated with the "wodsModelProvider" provider.
  final wodsModel = ref.watch(wodsModelProvider);
  /// Get the expected training days for the specific week using the
  /// start day of the week date.
  List<Map> wodsOfTheWeek =  await wodsModel.getWeekExpectedTrainingDays(startDayOfTheWeekDate);
  /// Return true if there are any expected training days, otherwise false.
  return wodsOfTheWeek.isNotEmpty;
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

