import 'package:flutter/material.dart';
import 'dart:io';

class H1Screens extends StatelessWidget {
  // This is the Main Header in all the Screens
  const H1Screens({
    required String header,
    required bool isInListView,
    Key? key,
  })  : _header = header,
        _isInListView = isInListView,
        super(key: key);
  final String _header;
  final bool _isInListView;

  Widget addMarginIfNotListView({required Widget child}) {
    // Add a specific [margin] in the [H1] when the Text is inside a [column] or a [listview]
    Widget parent;
    // We added the Android and IOS because in the Windows device have error with the margin.
    if (_isInListView) {
      parent = Container(
        margin: const EdgeInsets.only(right: 5, left: 5, bottom: 0, top: 30),
        child: child,
      );
      // Windows have their margin expected in H1
    } else if (Platform.isWindows) {
      parent = Container(
        margin: const EdgeInsets.only(right: 5, left: 5, bottom: 0, top: 30),
        child: child,
      );
    } else {
      parent = Container(
        margin: const EdgeInsets.only(top: 32),
        child: Container(
          margin: const EdgeInsets.only(right: 5, left: 5, bottom: 0, top: 30),
          child: child,
        ),
      );
    }
    return parent;
  }

  @override
  Widget build(BuildContext context) {
    return addMarginIfNotListView(
        child: Center(
      child: Text(
        _header,
        style: Theme.of(context).textTheme.headline1,
      ),
    ));
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
        overflow: TextOverflow.ellipsis, maxLines: 1,
      ),
    );
  }
}

class H4KPIHeader extends StatelessWidget {
  // This is for the titles of the Cards and Fields
  H4KPIHeader({required this.header, Key? key}) : super(key: key);
  String header;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Text(
        header,
        style: Theme.of(context).textTheme.headline4,
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
