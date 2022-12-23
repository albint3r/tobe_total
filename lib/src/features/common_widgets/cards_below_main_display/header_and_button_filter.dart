import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../headers_screens/header_screens.dart';
import 'icon_next_to_header.dart';

class MenuAndButtonFilterAreaBelowMainDisplay extends ConsumerWidget {
  const MenuAndButtonFilterAreaBelowMainDisplay({
    required String header,
    required IconData icon,
    required VoidCallback callBackOnTap,
    Key? key,
  })  : _header = header,
        _icon = icon,
        _callBackOnTap = callBackOnTap,
        super(key: key);
  final String _header;
  final IconData _icon;
  final VoidCallback _callBackOnTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        H3FormFieldsHeader(header: _header),
        IconNextToHeader(
          icon: _icon,
          callBackOnTap: _callBackOnTap,
        )
      ],
    );
  }
}


