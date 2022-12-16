import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../routes/routes.dart';

final routesProvider = Provider<Routes>((ref) {
  return Routes();
});
