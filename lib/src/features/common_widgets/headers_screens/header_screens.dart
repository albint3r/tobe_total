import 'package:flutter/material.dart';

class H1Screens extends StatelessWidget {
  H1Screens({required this.header,Key? key}) : super(key: key);
  String header;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Center(
        child: Text(
          header,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    );
  }
}


class H6Screens extends StatelessWidget {
  H6Screens({required this.header,Key? key}) : super(key: key);
  String header;
  @override
  Widget build(BuildContext context) {
    return Text(
      header,
      style: Theme.of(context).textTheme.headline6,
    );
  }
}

class H2Screens extends StatelessWidget {
  H2Screens({required this.header,Key? key}) : super(key: key);
  String header;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        header,
        style: Theme.of(context).textTheme.headline2,
      ),
    );
  }
}


