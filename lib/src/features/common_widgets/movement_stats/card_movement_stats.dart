import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/features/common_widgets/movement_stats/single_card_move_stats.dart';
import '../../../providers/my_movements/controllers/my_movements_controller.dart';

class CardsMovementStats extends ConsumerStatefulWidget {
  const CardsMovementStats({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CardsMovementStatsState();
}

class _CardsMovementStatsState extends ConsumerState<CardsMovementStats> {
  @override
  Widget build(BuildContext context) {
    final allMyMovements = ref.watch(allMyMovementsProvider);
    return allMyMovements.when(
      error: (error, stackTrace) => Text('Error $error'),
      loading: () => const CircularProgressIndicator(),
      data: (movesData) {
        List<SingleCardMoveStats> allCards = generateCardsStats(movesData, ref);
        return ListView.builder(
          shrinkWrap: true,
          itemCount: allCards.length,
          itemBuilder: (BuildContext context, int index) {
            return allCards[index];
          },
        );
      },
    );
  }

  /// [SingleCardMoveStats] objects.
  ///
  /// The list of moves is filtered using the [filteredMove] string obtained from
  /// the [ref] object and the [queryMyMovementFilteredProvider] method. If the
  /// [filteredMove] string is not empty, the search result is obtained from the
  /// [myMovementController] object also obtained from the [ref] object using the
  /// [generateMyMoveSearch] method and the [movesData] list is updated with the
  /// result.
  ///
  /// Then, a [SingleCardMoveStats] object is created for each map in the
  /// [movesData] list and added to the [allCards] list. The [allCards] list is
  /// returned at the end of the function.
  List<SingleCardMoveStats> generateCardsStats(
      List<Map<String, Object?>> movesData, WidgetRef ref) {
    final filteredMove = ref.watch(queryMyMovementFilteredProvider);
    final myMovementController = ref.watch(myMovementControllerProvider);
    List<SingleCardMoveStats> allCards = [];
    // If the user click the search option this will filter all the
    // card and only show the one that clicked.
    if (filteredMove[0] != '') {
      var moveResult = myMovementController.generateMyMoveSearch(movesData);
      Map<String, Object?> result =
          moveResult[filteredMove[0]] as Map<String, Object?>;
      movesData = [result];
    }

    for (Map<String, Object?> move in movesData) {
      final SingleCardMoveStats cardMoveStat = SingleCardMoveStats(
        moveStats: move,
      );
      allCards.add(cardMoveStat);
    }
    return allCards;
  }
}
