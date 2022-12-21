import 'package:flutter_riverpod/flutter_riverpod.dart';

final blockIdProvider = StateProvider<int>((ref) {
  // This helps to make the change of screens between the Wod
  // to the specific block
  return -1;
});

