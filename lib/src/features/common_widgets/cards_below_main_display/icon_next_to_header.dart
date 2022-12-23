import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IconNextToHeader extends ConsumerWidget {
  const IconNextToHeader({
    required IconData icon,
    required VoidCallback callBackOnTap,
    Key? key,
  })  : _icon = icon,
        _callBackOnTap = callBackOnTap,
        super(key: key);
  final IconData _icon;
  final VoidCallback _callBackOnTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      child: GestureDetector(
        onTap: _callBackOnTap,
        child: Icon(_icon),
      ),
    );
  }
}