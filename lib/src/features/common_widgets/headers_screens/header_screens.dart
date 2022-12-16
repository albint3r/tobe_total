import 'package:flutter/material.dart';

class H1Screens extends StatelessWidget {
  // This is the Main Header in all the Screens
  H1Screens({required this.header, Key? key}) : super(key: key);
  String header;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5, left: 5, bottom: 0, top: 30),
      child: Center(
        child: Text(
          header,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    );
  }
}

class H3FormFieldsHeader extends StatelessWidget {
  // This is for the titles of the Cards and Fields
  H3FormFieldsHeader({required this.header, Key? key}) : super(key: key);
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

class SubTitleHeaderH1 extends StatelessWidget {
  // This helps the Header h1 to complete the information of the screen.
  const SubTitleHeaderH1({
    Key? key,
    required String subHeader,
  })  : _subHeader = subHeader,
        super(key: key);
  final String _subHeader;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      width: MediaQuery.of(context).size.width / 2,
      child: Text(
        _subHeader,
        maxLines: 2,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }
}
