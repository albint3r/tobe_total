import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/my_movements/controllers/my_movements_controller.dart';

class IconButtonSearchLogic extends ConsumerWidget {
  const IconButtonSearchLogic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allMyMovements = ref.watch(allMyMovementsProvider);
    final myMovementsController = ref.watch(myMovementControllerProvider);
    return allMyMovements.when(
        loading: () => const CircularProgressIndicator(),
        error: (error, stackTrace) => Text('Error $error'),
        data: (movesData) {
          Map<String, Map> myMovementsSearch =
              myMovementsController.generateMyMoveSearch(movesData);
          return IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(
                    movesData: myMovementsSearch, ref: ref),
              );
            },
            icon: const Icon(Icons.search, color: Colors.white),
          );
        });
  }
}

/// A custom search delegate that handles search functionality for a list of moves.
class CustomSearchDelegate extends SearchDelegate {
  /// Constructs a [CustomSearchDelegate] object.
  ///
  /// The [movesData] and [ref] parameters must not be null.
  CustomSearchDelegate({
    required this.movesData,
    required this.ref,
  });
  /// A map of moves.
  Map<String, Map> movesData;
  /// A reference to a widget.
  WidgetRef ref;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          // if the query is empty close the search prompt
          if (query == '') {
            close(context, null);
          }
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var move in movesData.entries) {
      if (move.key.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(move.key);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (BuildContext context, int i) {
        var result = matchQuery[i];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  /// Builds suggestions for the search query.
  ///
  /// This method returns a list of suggestions for the current search query.
  /// The suggestions are obtained by iterating through the entries in the
  /// [movesData] map and adding the keys of the entries that match the
  /// search query to the [matchQuery] list.
  ///
  /// The list of suggestions is displayed in a `ListView` built using the
  /// `ListView.builder` constructor. Each suggestion is a `ListTile` widget
  /// wrapped in a `GestureDetector` that calls the
  /// `setStateQueryMyMovementFilteredProvider` method of the
  /// [myMovementController] object when tapped. The search prompt is then
  /// closed.
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var move in movesData.entries) {
      if (move.key.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(move.key);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (BuildContext context, int i) {
        var queryResult = matchQuery[i];
        return GestureDetector(
          onTap: () {
            final myMovementController = ref.watch(myMovementControllerProvider);
            myMovementController.setStateQueryMyMovementFilteredProvider(queryResult, ref);
            print('You are clicking -> ${ref.watch(queryMyMovementFilteredProvider)}');
            close(context, null);
          },
          child: ListTile(
            title: Text(queryResult),
          ),
        );
      },
    );
  }
}
