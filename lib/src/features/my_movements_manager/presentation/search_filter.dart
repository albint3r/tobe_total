import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/features/my_movements_manager/presentation/search_logic.dart';

import '../../common_widgets/headers_screens/header_screens.dart';

class SearchFilter extends ConsumerStatefulWidget {
  const SearchFilter({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _SearchFilterState();
}

class _SearchFilterState extends ConsumerState<SearchFilter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
          border: Border.fromBorderSide(
            BorderSide(color: Color.fromRGBO(229, 225, 225, 1.0)),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          H6Screens(header: 'Search Movement'),
          Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            child: Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [
                    Color.fromRGBO(162, 66, 66, 1.0),
                    Colors.redAccent,
                  ], begin: Alignment.bottomLeft, end: Alignment.topRight)),
              child: const CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 20,
                child: IconButtonSearchLogic(),
              ),
            ),
          )
        ],
      ),
    );
  }
}


