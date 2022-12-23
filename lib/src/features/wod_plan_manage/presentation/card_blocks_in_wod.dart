import 'package:flutter/material.dart';
import '../../configurate_athlete_profile/presentation/settings_menu_screen.dart';
import '../../training_week_calendar/presentation/items_icons_wods.dart';

class CardBlockInWOD extends StatelessWidget {
  // This is the single Card in the Single WOD information.
  // This is a block, but all the structure of the content of that area
  // is a list of this block, whit all the snippets the UI construct the interface style.
  const CardBlockInWOD({
    Key? key,
    required this.block,
  }) : super(key: key);

  final Map block;

  @override
  Widget build(BuildContext context) {
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
                      children: [
                        ItemIconWod(
                          title: block['mode'].toUpperCase(),
                          subtitle: 'Mode',
                          icon: Icons.cached,
                        ),
                        ItemIconWod(
                          title: "${block['sets']}",
                          subtitle: 'Total Sets',
                          icon: Icons.fitness_center,
                        ),
                        ItemIconWod(
                          title: "${block['time']}",
                          subtitle: 'Total Time',
                          icon: Icons.timer,
                        ),
                        ItemIconWod(
                            title: "${block['total_movements']}",
                            subtitle: 'Total Exercises',
                            icon: Icons.directions_run)
                      ]),
                ),
                trailing: SizedBox(
                  height: double.infinity,
                  child: NextButtonSettingsCard(callBack: () {
                    // TODO IMPLEMENT NEXT OR DISPLAY ANOTHER KIND OF MENU
                    print('NOT IMPLEMENTED BUTTON');
                    print('Click in  -> ${block['id']}');
                  }),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}