import 'package:flutter_riverpod/flutter_riverpod.dart';


final indexBottomNavStateProvider = StateProvider((ref) {
  // Control the Behave of the Bottom Nav Bar. It help to high light the
  // button when its selected.
  // Use an Index = 0 -> to do that.
  return 0;
});