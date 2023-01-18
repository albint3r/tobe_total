import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/providers/proxies/proxies.dart';
import 'block_proxy.dart';
import 'movement_proxy.dart';

class ProxyWOD extends ProxiesTraining {
  ProxyWOD(Map<String, Object?> context) : super(context);

  int? id;
  DateTime? createDate;
  DateTime? expectedTrainingDay;
  int? isExpired;
  int? day;
  int? isCreatedManual;
  int? isEdited;
  String? bodyArea;
  int? totalBlocks;
  int? totalTime;
  List? equipment;
  int? didWod;
  int? isLike;
  Map<int, ProxyBlock>? blocks;
  ProxyBlock? currentBlockProcessing;
  List<int>? movementToDo;

  @override
  void initProxy() {
    Map<String, Object?> wod = context;
    id = wod['id'] as int?;
    createDate = DateTime.parse(wod['create_date'] as String);
    expectedTrainingDay =
        DateTime.parse(wod['expected_training_day'] as String);
    isExpired = wod['expired'] as int?;
    day = wod['day'] as int?;
    isCreatedManual = wod['created_manual'] as int?;
    isEdited = wod['edited'] as int?;
    bodyArea = wod['body_area'] as String?;
    totalBlocks = wod['total_blocks'] as int?;
    totalTime = wod['total_time_work_out'] as int?;
    equipment = wod['equipment'] as List?;
    didWod = wod['did_wod'] as int?;
    isLike = wod['is_like'] as int?;
  }

  void setBlocksInWod(List blocksInWod) {
    Map<int, ProxyBlock>? blocksResult = {};
    for (var block in blocksInWod) {
      ProxyBlock blockProxy = ProxyBlock(block);
      blockProxy.initProxy();
      blocksResult[blockProxy.id!] = blockProxy;
    }
    blocks = blocksResult;
  }

  void setMovesInBlocks(List movesInBlocks) {
    for(var move in movesInBlocks) {
      ProxyMovement movement = ProxyMovement(move);
      movement.initProxy();
      ProxyBlock? tempBlock = blocks![movement.blockId];
      tempBlock?.movements[movement.id!] = movement;
    }
  }

  void getNextBlock() {
    // if not selected block
    int? tempId;
    print('[getNextBlock]-----------------------');
    // Not exist next block, select first
    if(currentBlockProcessing == null) {

      tempId = blocks?.keys.first;
      print('tempId-> $tempId');
      currentBlockProcessing = blocks![tempId];
    // Select next until is the last.
    } else {
      tempId = (currentBlockProcessing!.id! + 1);
      print('tempId-> $tempId');
      // validate exist next Element in the Map
      if(blocks![tempId] != null) {
        currentBlockProcessing = blocks![tempId];
      }
    }
  }
  /// Returns a list of integers representing the index of the movement
  /// to perform at each minute of the [blockTime].
  ///
  /// The function getMovementToDo(10, ['jumping jacks', 'push ups', 'squats'])
  /// is called, which returns a list of integers representing the [index]
  /// of the movement to perform at each [minute] of the 10-minute block.
  //
  // In this case, the returned list would be [0, 1, 2, 0, 1, 2, 0, 1, 2, 0],
  // this means that at the first minute the movement to
  // perform is 0 (jumping jacks), at the second minute the
  // movement is 1 (push ups), and so on.
  void getMovementToDo() {
    List<int> minutes = List.generate(currentBlockProcessing!.time!, (i) => i);
    int totalMoves = currentBlockProcessing!.movements.length;
    movementToDo = [for (int minute in minutes) minute % totalMoves];
  }

  @override
  String toString() {
    return 'WOD(id=$id, expectedTrainingDate=${expectedTrainingDay.toString().substring(0, 10)}, expired=$isExpired, bodyArea=$bodyArea, totalBlocks=$totalBlocks, totalTime=$totalTime)';
  }
}

final todayTrainingWodProvider = StateProvider<Map<String, Object?>>((ref) {
  return {};
});

final movementInBlockWodProxyProvider =
    StateProvider<List<Map<String, Object?>>>((ref) {
  return [];
});

final proxyWodProvider = Provider<ProxyWOD>((ref) {
  final wodResult = ref.watch(todayTrainingWodProvider);
  final blocksInWod = ref.watch(blocksInWodProxyProvider);
  final movesInBlocks = ref.watch(movementInBlockWodProxyProvider);
  final ProxyWOD wod = ProxyWOD(wodResult);
  wod.initProxy();
  wod.setBlocksInWod(blocksInWod);
  wod.setMovesInBlocks(movesInBlocks);
  return wod;
});
