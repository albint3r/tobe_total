import 'package:flutter/material.dart';

class ItemIconWod extends StatelessWidget {
  const ItemIconWod({
    Key? key,
    required String title,
    required String subtitle,
    required IconData icon,
  })  : _title = title,
        _subTitle = subtitle,
        _icon = icon,
        super(key: key);

  final String _title;
  final String _subTitle;
  final IconData _icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(_title),
        const SizedBox(
          height: 10,
        ),
        Icon(_icon),
        Center(
          child: Text(_subTitle),
        )
      ],
    );
  }
}
