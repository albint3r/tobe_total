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
        children: const [
          CircleAvatar(
            backgroundImage:
            AssetImage(r'assets/statics/profile_picture2.jpg'),
            maxRadius: 50,
          ),
        ],
      ),
    );
  }
}