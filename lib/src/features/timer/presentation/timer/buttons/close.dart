import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../providers/routes/routes_provider.dart';
import '../../../../../routes/const_url.dart';

class CloseTimerBtn extends ConsumerWidget {
  const CloseTimerBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final route = ref.watch(routesProvider);
    return IconButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Are you sure you want to leave?'),
                content: const Text(
                    'If you leave without finalize your training all the progress would be lost.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('cancel'),
                  ),
                  TextButton(onPressed: () {
                    route.navigateTo(context, ConstantsUrls.progress);
                  }, child: const Text('Exit'))

                ],
              );
            });
      },
      icon: const Icon(Icons.close),
      iconSize: 50,
    );
  }
}
