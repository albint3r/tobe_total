// Imports
// Flutter
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data_base/db.dart';

final counterProvider = StateProvider<int>((ref) {
  return 0;
});


final dbTobeTotal =
    FutureProvider.autoDispose<List<Map<String, Object?>>>((ref) async {
  var db = await ref.watch(dbRepositoryProvider);
  return [db[0]];
});

final dbRepositoryProvider = Provider((ref) async {
  return await LocalDataBase.getMyMovements();
},);

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final counter = ref.watch(counterProvider);
    final dbx = ref.watch(dbTobeTotal);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$counter'),
            dbx.when(
              data: (data) {
                return Text('${dbx}');
              },
              error: (error, stackTrace) => Text('Error: $error'),
              loading: () => const CircularProgressIndicator(),
            )
          ],
        ),
      ),
      bottomNavigationBar: FloatingActionButton(
        child: const Text('add'),
        onPressed: () {
          ref.watch(counterProvider.notifier).state += 5;
        },
      ),
    );
  }
}

