import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/settings_aparience.dart';

final isDarkModeProviderNotifier =
StateNotifierProvider<IsDarkModeNotifier, bool>(
      (ref) => IsDarkModeNotifier(),
);
