import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BodyHeadMap extends ConsumerWidget {
  const BodyHeadMap({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Image.asset(r'assets/statics/body_front.png'),
    );
  }
}
