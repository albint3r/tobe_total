import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/features/common_widgets/movement_stats/single_card_move_stats.dart';
import '../../../providers/block/controllers/block_controller_provider.dart';
import '../../../providers/block/model/block_model_provider.dart';
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
    final clickedBlockId = ref.watch(clickedBlockIDProvider);
    // When the BlockId is less than zero, it means that the is not set id
    if (clickedBlockId <= 0) {
      /// Depending if the MyMove Cards is selected from myMovements
      /// or by clicking the block moves information, this is the difference
      /// that would change the behavior of the Cards creation.
      final allMyMovements = ref.watch(allMyMovementsProvider);
      return generateAllCards(context, allMyMovements);
    } else {
      // This is by Block creation
      final movesInBlockId = ref.watch(blockMovesInsideProvider);
      return generateAllCards(context, movesInBlockId);
    }
  }

  /// Generates a list of cards using the data from the given [selectedProvider].
  ///
  /// The list is displayed using a `ListView.builder` widget.
  ///
  /// [context] is the current build context.
  /// [selectedProvider] is an `AsyncValue` object representing
  /// the selected provider.
  dynamic generateAllCards(BuildContext context, AsyncValue selectedProvider) {
    return selectedProvider.when(
      error: (error, stackTrace) => Text('Error $error'),
      loading: () => const CircularProgressIndicator(),
      data: (movesData) {
        List<SingleCardMoveStats> allCards = generateCardsStats(movesData, ref);
        return ListView.builder(
          shrinkWrap: true,
          itemCount: allCards.length,
          // physics: const AlwaysScrollableScrollPhysics(),
          physics: const NeverScrollableScrollPhysics(),
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
