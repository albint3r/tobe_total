import 'package:tobe_total/src/repositories/client_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/cliente_model_provider.dart';


final futureClientProfileProvider =
FutureProvider.autoDispose<Map<String, Object?>>((ref) async {
  // Return the User Profile Info
  final Client client = ref.watch(clientProvider);
  List<Map<String, Object?>> response = await client.getProfile();
  Map<String, Object?> clientProfile = response[0];
  return clientProfile;
});


final clientTotalTrainingTimeProvider = FutureProvider<int>((ref) async {
  // This return the Training time of the client.
  final Client client = ref.watch(clientProvider);
  List<Map<String, Object?>> response = await client.getTotaTrainingTime();
  Map<String, int> clientTrainingTime = response[0] as Map<String, int>;
  // If the value is Null it will return 0
  return clientTrainingTime['time_to_training'] ?? 0;
});

