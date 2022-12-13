import 'package:flutter/material.dart';

class FloatBottomBtn extends StatelessWidget {
  const FloatBottomBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      onPressed: () {},
      tooltip: 'Create Training Week',
      child: const SizedBox(
        width: double.infinity,
        child: Text('Go Training',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 9.5,
              fontWeight: FontWeight.bold
            )),
      ),
    );
  }
}
