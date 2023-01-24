

// USE THE CARD_BELOW_MAIN_DISPLAY TO CREATE THE AREA OF THE UI.
import 'package:flutter/material.dart';

class NextButtonSettingsCard extends StatelessWidget {
  const NextButtonSettingsCard({
    required VoidCallback callBack,
    Key? key,
  })  : _callBack = callBack,
        super(key: key);
  final VoidCallback _callBack;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _callBack,
      child: const Icon(Icons.arrow_forward_ios_outlined),
    );
  }
}