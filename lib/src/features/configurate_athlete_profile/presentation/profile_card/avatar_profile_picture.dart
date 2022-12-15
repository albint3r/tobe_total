import 'package:flutter/material.dart';


class AvatarProfilePicture extends StatelessWidget {
  const AvatarProfilePicture({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircleAvatar(
            backgroundImage:
            AssetImage(r'assets/statics/profile_picture.jpg'),
            maxRadius: 50,
          ),
        ],
      ),
    );
  }
}