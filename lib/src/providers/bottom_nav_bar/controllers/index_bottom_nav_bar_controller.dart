import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/index_bottom_nav_provider.dart';


class BottomNavBarController {

  void setStateIndexBottomNavStateProvider(int index, WidgetRef ref) {
    ref.watch(indexBottomNavStateProvider.notifier).state = index;
  }

}


final bottomNavBarControllerProvider = Provider<BottomNavBarController>((ref) {
  return BottomNavBarController();
});