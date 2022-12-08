import 'package:flutter/material.dart';

class FloatBottomBtn extends StatelessWidget {
  const FloatBottomBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 10,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: Colors.redAccent,
      onPressed: () {},
      tooltip: 'Create Training Week',
      child: const SizedBox(
        // width: MediaQuery.of(context).size.width /2,
        width: double.infinity,
        child: Text('Start Workout',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 7,
            )),
      ),
    );
  }
}
