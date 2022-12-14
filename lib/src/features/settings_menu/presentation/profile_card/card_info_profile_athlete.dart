import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data_base/model/client.dart';
import '../../../common_widgets/headers_screens/header_screens.dart';

class InfoProfileAthlete extends ConsumerStatefulWidget {
  const InfoProfileAthlete({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _InfoProfileAthleteState();
}

class _InfoProfileAthleteState extends ConsumerState<InfoProfileAthlete> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(futureClientProfileProvider).when(
      data: (dataProfile) {
        return Expanded(
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                H6Screens(header: 'Athlete Info'),
                Text('Name: ${dataProfile['name']} ${dataProfile['last_name']}'),
                Text('Sex: ${dataProfile['sex'] ?? '?'}'),
                Text('Age: ${dataProfile['sex'] ?? '?'}'),
                Text('Objective: ${dataProfile['sex'] ?? '?'}'),
              ],
            ),
          ),
        );
      }, error: (err, stack) => Text('Error: $err'),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
