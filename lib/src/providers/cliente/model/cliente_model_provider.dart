import 'package:tobe_total/src/data_base/model/client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final clientProvider = Provider<Client>((ref) {
  return Client();
});