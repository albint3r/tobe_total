import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'header_and_button_filter.dart';

class CardInParent extends ConsumerWidget {
  const CardInParent({
    required String header,
    required IconData icon,
    required VoidCallback callBackOnTap,
    required List<Widget> listWidgets,
    Key? key,
  })  : _listWidgets = listWidgets,
        _callBackOnTap = callBackOnTap,
        _icon = icon,
        _header = header,
        super(key: key);
  final String _header;
  final IconData _icon;
  final VoidCallback _callBackOnTap;
  final List<Widget> _listWidgets;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width * .90,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // This is the Header with the Icon to the Right
          // This hold all the row.
          MenuAndButtonFilterAreaBelowMainDisplay(
            header: _header,
            icon: _icon,
            callBackOnTap: _callBackOnTap,
          ),
          ..._listWidgets
        ],
      ),
    );
  }
}
