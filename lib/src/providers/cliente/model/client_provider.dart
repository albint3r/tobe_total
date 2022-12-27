import 'package:tobe_total/src/data_base/model/client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/cliente_model_provider.dart';


final futureClientProfileProvider =
FutureProvider.autoDispose<Map<String, Object?>>((ref) async {
  // Return the User Profile Info
  final Client client = ref.watch(clientProvider);
  List<Map<String, Object?>> response = await client.getProfile();
  Map<String, Object?> clientProfile = response[0];
  return clientProfile;
});