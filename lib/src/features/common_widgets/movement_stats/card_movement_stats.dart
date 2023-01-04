import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/features/common_widgets/movement_stats/single_card_move_stats.dart';
import '../../../providers/my_movements/controllers/my_movements_controller.dart';


/// A widget that displays the movement statistics for a collection of cards.
class CardsMovementStats extends ConsumerWidget {
  /// Creates a new instance of [CardsMovementStats].
  const CardsMovementStats({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allMyMovements = ref.watch(allMyMovementsProvider);
    return allMyMovements.when(
      error: (error, stackTrace) => Text('Erro $error'),
      loading: () => const CircularProgressIndicator(),
      data: (movesData) {
        return Column(
          children: generateCardsStats(movesData),
        );
      },
    );
  }
  /// Generates a list of [SingleCardMoveStats] widgets based on the provided
  /// [movesData].
  List<SingleCardMoveStats> generateCardsStats(
      List<Map<String, Object?>> movesData) {
    List<SingleCardMoveStats> allCards = [];
    for (Map<String, Object?> move in movesData) {
      print('------------');
      print(move);
      final SingleCardMoveStats cardMoveStat = SingleCardMoveStats(
        moveStats: move,
      );
      allCards.add(cardMoveStat);
    }
    return allCards;
  }
}



