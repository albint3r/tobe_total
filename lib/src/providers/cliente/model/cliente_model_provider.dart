import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../repositories/client_repository.dart';

final clientProvider = Provider<Client>((ref) {
  return Client();
});