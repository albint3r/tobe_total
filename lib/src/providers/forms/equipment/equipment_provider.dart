import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../cliente/model/cliente_model_provider.dart';

final noEquipmentProvider = StateProvider<bool>((ref) {
  final client = ref.watch(clientProvider);
  return client.noEquipment;
});
final dumbbellsProvider = StateProvider<bool>((ref) {
  final client = ref.watch(clientProvider);
  return client.dumbbells;
});
final kettlebellsProvider = StateProvider<bool>((ref) {
  final client = ref.watch(clientProvider);
  return client.kettlebells;
});
final benchProvider = StateProvider<bool>((ref) {
  final client = ref.watch(clientProvider);
  return client.bench;
});
final barbellProvider = StateProvider<bool>((ref) {
  final client = ref.watch(clientProvider);
  return client.barbell;
});
final weightMachinesSelectorizedProvider = StateProvider<bool>((ref) {
  final client = ref.watch(clientProvider);
  return client.weightMachinesSelectorized;
});
final resistanceBandsCablesProvider = StateProvider<bool>((ref) {
  final client = ref.watch(clientProvider);
  return client.resistanceBandsCables;
});
final leggingsProvider = StateProvider<bool>((ref) {
  final client = ref.watch(clientProvider);
  return client.leggings;
});
final medicineBallProvider = StateProvider<bool>((ref) {
  final client = ref.watch(clientProvider);
  return client.medicineBall;
});
final stabilityBallProvider = StateProvider<bool>((ref) {
  final client = ref.watch(clientProvider);
  return client.stabilityBall;
});
final ballProvider = StateProvider<bool>((ref) {
  final client = ref.watch(clientProvider);
  return client.ball;
});
final trxProvider = StateProvider<bool>((ref) {
  final client = ref.watch(clientProvider);
  return client.trx;
});
final raisedPlatformBoxProvider = StateProvider<bool>((ref) {
  final client = ref.watch(clientProvider);
  return client.raisedPlatformBox;
});
final boxProvider = StateProvider<bool>((ref) {
  final client = ref.watch(clientProvider);
  return client.box;
});
final ringsProvider = StateProvider<bool>((ref) {
  final client = ref.watch(clientProvider);
  return client.rings;
});
final pullUpBarProvider = StateProvider<bool>((ref) {
  final client = ref.watch(clientProvider);
  return client.pullUpBar;
});
final parallelsBarProvider = StateProvider<bool>((ref) {
  final client = ref.watch(clientProvider);
  return client.parallelsBar;
});
final wallProvider = StateProvider<bool>((ref) {
  final client = ref.watch(clientProvider);
  return client.wall;
});
final poleProvider = StateProvider<bool>((ref) {
  final client = ref.watch(clientProvider);
  return client.pole;
});
final trineoProvider = StateProvider<bool>((ref) {
  final client = ref.watch(clientProvider);
  return client.trineo;
});
final ropeProvider = StateProvider<bool>((ref) {
  final client = ref.watch(clientProvider);
  return client.rope;
});
final wheelProvider = StateProvider<bool>((ref) {
  final client = ref.watch(clientProvider);
  return client.wheel;
});
final assaultBikeProvider = StateProvider<bool>((ref) {
  final client = ref.watch(clientProvider);
  return client.assaultBike;
});