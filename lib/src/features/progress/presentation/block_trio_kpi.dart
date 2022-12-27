import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/wod_plan_provider.dart';
import '../../common_widgets/headers_screens/header_screens.dart';

class BlockTrioKPI extends ConsumerWidget {
  const BlockTrioKPI({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalTrainedTime = ref.watch(totalTrainedTimeProvider);
    final goalProgress = ref.watch(goalProgressDaysProvider);
    return goalProgress.when(
      error: (error, stackTrace) => Text('Error $error'),
      loading: () => const CircularProgressIndicator(),
      data: (goalProgressData) {
        return totalTrainedTime.when(
            error: (error, stackTrace) => Text('Error $error'),
            loading: () => const CircularProgressIndicator(),
            data: (data) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SingleBlockKPI(
                    header: '$data',
                    subHeader: 'No Implement',
                  ),
                  SingleBlockKPI(
                    header: '$data mins',
                    subHeader: 'Trained time',
                  ),
                  SingleBlockKPI(
                    header: '${goalProgressData['currentTrainedDays']}',
                    subHeader: 'Trained Days',
                  ),
                ],
              );
            });
      },
    );
  }
}

class SingleBlockKPI extends StatelessWidget {
  const SingleBlockKPI({
    required String header,
    required String subHeader,
    Key? key,
  })  : _header = header,
        _subHeader = subHeader,
        super(key: key);
  final String _header;
  final String _subHeader;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(5),
        width: (MediaQuery.of(context).size.width - 100) / 3,
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            H4KPIHeader(
              header: _header,
            ),
            Text(_subHeader.toUpperCase()),
          ],
        ),
      ),
    );
  }
}
