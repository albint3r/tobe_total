import '../block_creator/block_creator.dart';

class MovementCreator {
  MovementCreator({
    required BlockCreator context,
    required this.index,
    required this.totalMoves,
  }) : _context = context;

  int index;
  double totalMoves;
  final BlockCreator _context;


  @override
  String toString() {
    return 'Move(index=$index)';
  }
}
