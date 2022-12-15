import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Sex { male, female }

final sexProvider = StateProvider<Sex>((ref) {
  return Sex.male;
});

