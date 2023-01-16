import 'package:flutter/material.dart';

Color getColorTimer(double percentageVal) {
  if (percentageVal < .50) {
    return Colors.green;
  } else if (percentageVal >= .50 && percentageVal < .75) {
    return Colors.yellowAccent;
  } else {
    return Colors.redAccent;
  }
}
