import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'avatar_profile_picture.dart';
import 'info_profile_athlete.dart';

class CardProfileMenu extends ConsumerStatefulWidget {
  const CardProfileMenu({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CardProfileMenuState();
}

class _CardProfileMenuState extends ConsumerState<CardProfileMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // This create the shadow effect that highlight the card in the [lightMode]
      decoration: buildBoxDecoration(),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: SizedBox(
          height: 175,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              AvatarProfilePicture(),
              InfoProfileAthlete()
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration buildBoxDecoration() {
    return const BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black,
          blurRadius: 8,
          spreadRadius: -10,
          offset: Offset(1.0, 1.0),
        ),
      ]
    );
  }
}


