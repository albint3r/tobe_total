import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SingleIconDayIndicator extends ConsumerWidget {
  const SingleIconDayIndicator({
    required bool isExpired,
    required bool isComplete,
    required bool isNull,
    Key? key,
  })  : _isExpired = isExpired,
        _isComplete = isComplete,
        _isNull = isNull,
        super(key: key);
  final bool _isExpired;
  final bool _isComplete;
  final bool _isNull;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      // The reason the operation below is to calculate the length of the calendar
      // above. The calendar by default have a left: 50 and right: 50 margin
      // getting a total of 100. And there are 7 days in the calendar, so
      // that's the reason of the division.
      width: (MediaQuery.of(context).size.width - 100) / 7,
      // width: 260,
      child: CircleAvatar(
        radius: 12,
        child: Icon(
          getWodIconStatus,
          size: 15,
        ),
      ),
    );
  }

  IconData get getWodIconStatus {
    // Depending on the status of the WOD it would add the specific icon.
    // If the Day is not in the calendar, wont create penalization to the client
    if (_isNull) {
      return Icons.radio_button_unchecked;
    }
    //Is expired and is Complete?
    if (_isExpired & _isComplete) {
      // If is expired but is complete, this would be [complete]
      return Icons.check;
      // If is expired and is [NOT COMPLETE]
    } else if (!_isExpired & _isComplete) {
      return Icons.check;
    } else if (_isExpired & !_isComplete) {
      // If is expired and the client wont made the training this will be
      // incomplete.
      return Icons.close;
      // Is not expired and is Not complete
    } else if (!_isExpired & !_isComplete) {
      // This return a waiting training. Because the training is not expired
      // but is not complete.
      return Icons.adjust;
    } else {
      return Icons.radio_button_unchecked;
    }
  }
}
