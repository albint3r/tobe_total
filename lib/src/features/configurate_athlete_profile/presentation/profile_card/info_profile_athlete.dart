import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:string_ext/string_ext.dart';
import '../../../../providers/client_provider.dart';
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
        String firstName = dataProfile['name'] as String;
        String lastName = dataProfile['last_name'] as String;
        return Expanded(
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                H6Screens(header: 'Athlete Info'),
                Text('Name:  ${firstName.firstToUpper()} ${lastName.firstToUpper()}'),
                Text('Weight:  ${dataProfile['weight'] ?? '?'}'),
                Text('Height:  ${dataProfile['height'] ?? '?'}'),
                Text('Age:  ${dataProfile['age'] ?? '?'}'),
                Text('Objective:  ${dataProfile['goal'] ?? '?'}'),
              ],
            ),
          ),
        );
      }, error: (err, stack) => Text('Error: $err'),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
