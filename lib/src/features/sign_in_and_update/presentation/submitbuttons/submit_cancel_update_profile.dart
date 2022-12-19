import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/routes_provider.dart';
import '../../../../routes/const_url.dart';

class SubmitCancelChanges extends ConsumerWidget {
  const SubmitCancelChanges({
    Key? key,
  })  :super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          const Text('or '),
          const SizedBox(height: 5,),
          TextButton(
            onPressed: () async {
              ref.watch(routesProvider).navigateTo(context, ConstantsUrls.settingsMenu);
            },
            child: const Text('Cancel Changes'),
          ),
        ],
      ),
    );
  }
}