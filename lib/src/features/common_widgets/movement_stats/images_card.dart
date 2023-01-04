import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


/// A widget that displays an image with a rounded border.
// Inside the stack card
class ImageCardMoveStat extends ConsumerWidget {
  const ImageCardMoveStat({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      top: 10,
      right: 10,
      child: Container(
        height: 220,
        width: 150,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
            color: Colors.black54,
            image: DecorationImage(
                image: AssetImage(r'assets/statics/body_front.png'),
                fit: BoxFit.fitHeight)),
      ),
    );
  }
}
