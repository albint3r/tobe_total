import 'package:flutter/material.dart';
import '../../common_widgets/headers_screens/header_screens.dart';

class SettingsCardMenu extends StatelessWidget {
  SettingsCardMenu({
    required this.title,
    required this.subtitle,
    required this.leading,
    required this.trailing,
    Key? key,
  }) : super(key: key);

  String title;
  String subtitle;
  IconData leading;
  Widget trailing;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 2,
          bottom: 2,
        ),
        child: ListTile(
          // title: Text(title),
          title: H6Screens(
            header: title,
          ),
          subtitle: Text(subtitle),
          leading: Icon(leading),
          trailing: trailing,
        ),
      ),
    );
  }
}
