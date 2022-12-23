import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NextScreenButton extends ConsumerWidget {
  const NextScreenButton({
    required VoidCallback callBack,
    Key? key,
  })  : _callBack = callBack,
        super(key: key);
  final VoidCallback _callBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: _callBack,
      child: const Icon(Icons.arrow_forward_ios_outlined),
    );
  }
}