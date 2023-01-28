import 'package:flutter/material.dart';
import 'package:string_ext/string_ext.dart';
import '../headers_screens/header_screens.dart';

class TitleSingleCardMoveStat extends StatelessWidget {
  const TitleSingleCardMoveStat({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return SizedBox(
        width: constraints.maxWidth * .55,
        child: H3FormFieldsHeader(
          header: name,
        ),
      );
    });
  }
}

/// A widget that displays an icon followed by the [nameMove] text.
class IconTextMuscleProtaMoveStat extends StatelessWidget {
  /// Creates a new instance of the [IconTextMuscleProtaMoveStat] widget.
  ///
  /// The [nameMove] parameter must not be null.
  const IconTextMuscleProtaMoveStat({
    required this.nameMove,
    Key? key,
  }) : super(key: key);
  final String nameMove;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      child: Row(
        children: [
          const Icon(Icons.directions_run),
          Text(nameMove.firstToUpper()),
        ],
      ),
    );
  }
}
