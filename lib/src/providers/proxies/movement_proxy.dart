import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/providers/proxies/proxies.dart';

class ProxyMovement extends ProxiesTraining {
  ProxyMovement(Map<String, Object?> context) : super(context);

  int? id;
  int? blockId;
  int? fitnessMoveId;
  int? reps;
  int? restTime;
  int? weight;
  bool? isCreatedManual;
  bool? isEdited;
  bool? didExercise;
  bool? whyCantDoAllWork;
  bool? canDoMore;
  // Info move
  String? name;
  String? ytUrl;
  String? muscleProta;
  String? bodyArea;
  String? difficulty;
  String? movementPattern;
  int? dynamic;
  // int abs;
  // int obliques;
  // int pect;
  // int deltoids;
  // int tricep;
  // int back;
  // int traps;
  // int lats;
  // int serratus;
  // int spinalErectors;
  // int bicep;
  // int forearm;
  // int leg;
  // int glutes;
  // int quadriceps;
  // int calves;
  // int neck;
  // int fingerFlexors;
  // int noEquipment;
  // int dumbbells;
  // int kettlebells;
  // int bench;
  // int barbell;
  // int weightMachinesSelectorized;
  // int resistanceBandsCables;
  // int leggings;
  // int medicineBall;
  // int stabilityBall;
  // int ball;
  // int trx;
  // int raisedPlatformBox;
  // int box;
  // int rings;
  // int pullUpBar;
  // int parallelsBar;
  // int wall;
  // int pole;
  // int trineo;
  // int rope;
  // int wheel;
  // int assaultBike;
  // int isCompoundMovement;
  // int maxRepsExpected;
  // String description;

  @override
  void initProxy() {
    id = context['id'] as int?;
    blockId = context['blocks_id'] as int?;
    fitnessMoveId= context['fitness_move_id'] as int?;
    reps= context['reps'] as int?;
    restTime= context['rest_time'] as int?;
    weight= context['weight'] as int?;
    // // Info move
    name= context['name'] as String;
    ytUrl= context['yt_url'] as String;
    muscleProta= context['muscle_prota'] as String;
    bodyArea= context['body_area'] as String;
    difficulty= context['difficulty'] as String;
    movementPattern= context['movement_pattern'] as String;
    dynamic= context['dynamic'] as int;
  }

  //
  @override
  String toString() {
    return 'Move(id=$id, blockId=$blockId)';
  }
}
