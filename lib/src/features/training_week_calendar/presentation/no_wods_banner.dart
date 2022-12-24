import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessageNoWOD extends ConsumerWidget {
  // This class display a msg when the user don't have any WOD created yet.
  const MessageNoWOD({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: const Card(
        elevation: 30,
        child: Center(
          child: Text("Currently you don't have any WOD. Create first Training Week.",
          style: TextStyle(
            color: Colors.red
          )),
        ),
      ),
    );
  }
}
