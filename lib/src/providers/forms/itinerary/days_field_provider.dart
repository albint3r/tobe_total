import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../cliente/model/cliente_model_provider.dart';

final mondayProvider = StateProvider<bool>((ref) {
  final client = ref.watch(clientProvider);
  return client.monday;
});
final tuesdayProvider = StateProvider<bool>((ref) {
  final client = ref.watch(clientProvider);
  return client.tuesday;
});
final wednesdayProvider = StateProvider<bool>((ref) {
  final client = ref.watch(clientProvider);
  return client.wednesday;
});
final thursdayProvider = StateProvider<bool>((ref) {
  final client = ref.watch(clientProvider);
  return client.thursday;
});
final fridayProvider = StateProvider<bool>((ref) {
  final client = ref.watch(clientProvider);
  return client.friday;
});
final saturdayProvider = StateProvider<bool>((ref) {
  final client = ref.watch(clientProvider);
  return client.saturday;
});
final sundayProvider = StateProvider<bool>((ref) {
  final client = ref.watch(clientProvider);
  return client.sunday;
});

