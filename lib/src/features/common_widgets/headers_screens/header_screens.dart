import 'package:flutter/material.dart';

class H1Screens extends StatelessWidget {
  H1Screens({required this.header, Key? key}) : super(key: key);
  String header;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5, left: 5, bottom: 15, top: 25),
      child: Center(
        child: Text(
          header,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    );
  }
}

class H3Screens extends StatelessWidget {
  H3Screens({required this.header, Key? key}) : super(key: key);
  String header;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 20),
      child: Text(
        header,
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }
}

class H6Screens extends StatelessWidget {
  H6Screens({required this.header, Key? key}) : super(key: key);
  String header;

  @override
  Widget build(BuildContext context) {
    return Text(
      header,
      style: Theme.of(context).textTheme.headline6,
    );
  }
}
