import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'icon_trio_item.dart';
import 'next_screen_button.dart';

class SingleCardItem extends ConsumerWidget {
  const SingleCardItem(
      {Key? key,
      required this.iconsTrioItemsList,
      required NextScreenButton buttonNextScreen})
      : _buttonNextScreen = buttonNextScreen,
        super(key: key);

  final List<IconTrioItems> iconsTrioItemsList;
  final NextScreenButton _buttonNextScreen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: const EdgeInsets.all(5),
                minLeadingWidth: 0,
                subtitle: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: iconsTrioItemsList),
                ),
                trailing: SizedBox(
                  height: double.infinity,
                  child: _buttonNextScreen,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
