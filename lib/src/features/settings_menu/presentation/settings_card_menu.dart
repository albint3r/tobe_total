import 'package:flutter/material.dart';

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
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(leading),
        trailing: trailing,
      ),
    );
  }
}
