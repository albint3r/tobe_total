import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/providers/proxies/proxies.dart';

import 'movement_proxy.dart';

class ProxyBlock extends ProxiesTraining {
  ProxyBlock(Map<String, Object?> context) : super(context);

  int? id;
  int? wodId;
  DateTime? createDate;
  String? mode;
  int? sets;
  int? time;
  int? totalMovements;
  int? isCreatedManual;
  int? isEdited;
  int? didBlock;
  int? isLike;
  Map<int, ProxyMovement> movements ={};

  @override
  void initProxy() {
    Map<String, Object?> block = context;
    id = block['id'] as int?;
    wodId = block['wod_id'] as int?;
    createDate = DateTime.parse(block['create_date'] as String);
    mode = block['mode'] as String?;
    sets = block['sets'] as int?;
    time = block['time'] as int?;
    totalMovements = block['total_movements'] as int?;
    isCreatedManual = block['created_manual'] as int?;
    isEdited = block['edited'] as int?;
    didBlock = block['did_block'] as int?;
    isLike = block['is_like'] as int?;
  }

  void setMovements() {

  }

  @override
  String toString() {
    return 'Block(id=$id, mode=$mode, sets=$sets, time=$time, totalMovements=$totalMovements)';
  }
}

final blocksInWodProxyProvider = StateProvider<List<Map<String, Object?>>>((ref) {
  return [];
});
