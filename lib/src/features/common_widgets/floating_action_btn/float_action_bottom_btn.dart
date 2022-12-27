import 'package:flutter/material.dart';

class CreateNewWeekActionBtn extends StatelessWidget {
  const CreateNewWeekActionBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: 'Create a new Training Week',
      onPressed: () {
        print('Estoy siendo clikeado');
      },
      child: const Icon(Icons.add),
    );
  }
}
