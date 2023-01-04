import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/features/common_widgets/movement_stats/progress_bar_below_title.dart';
import 'package:tobe_total/src/features/common_widgets/movement_stats/title_text_card_move_stat.dart';
import '../../../providers/my_movements/controllers/my_movements_controller.dart';
import '../../../providers/theme/is_dark_mode_provider.dart';
import 'card_aspectes.dart';
import 'chip_equip_move_stats.dart';
import 'images_card.dart';

class SingleCardMoveStats extends ConsumerWidget {
  SingleCardMoveStats({
    required Map<String, Object?> moveStats,
    Key? key,
  }) : super(key: key) {
    setInitAttributes(moveStats);
  }

  late String createDate;
  late int id;
  late int fitnessMoveId;
  late int learned;
  late bool? isLike;
  late int bestRecord;
  late int bestTime;
  late int? moreUsedMode;
  late double? avgRestTime;
  late double? avgWeight;
  late String lastDateTrained;
  late int isRemoved;
  late int prioritize;
  late String name;
  late String ytUrl;
  late String muscleProta;
  late String bodyArea;
  late String difficulty;
  late String movementPattern;
  late int dynamic;
  late int fullBody;
  late int abs;
  late int obliques;
  late int pect;
  late int deltoids;
  late int tricep;
  late int back;
  late int traps;
  late int lats;
  late int serratus;
  late int spinalErectors;
  late int bicep;
  late int forearm;
  late int leg;
  late int glutes;
  late int quadriceps;
  late int calves;
  late int neck;
  late int fingerFlexors;
  late int noEquipment;
  late int dumbbells;
  late int kettlebells;
  late int bench;
  late int barbell;
  late int weightMachinesSelectorized;
  late int resistanceBandsCables;
  late int leggings;
  late int medicineBall;
  late int stabilityBall;
  late int ball;
  late int trx;
  late int raisedPlatformBox;
  late int box;
  late int rings;
  late int pullUpBar;
  late int parallelsBar;
  late int wall;
  late int pole;
  late int trineo;
  late int rope;
  late int wheel;
  late int assaultBike;
  late int? isCompoundMovement;
  late int maxRepsExpected;
  late String? description;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(isDarkModeProviderNotifier);
    final myMovesController = ref.watch(myMovementControllerProvider);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // if the darkMode is True wont display shadow
          boxShadow: isDark
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: const Offset(-2, 5),
                    blurRadius: 10,
                    spreadRadius: -10,
                  )
                ]),
      child: Stack(
        children: [
          CarAspects(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleSingleCardMoveStat(name: name),
                IconTextMuscleProtaMoveStat(
                  nameMove: muscleProta,
                ),
                KPIBarMoveStat(
                  label: 'Difficulty',
                  textInsideBar: difficulty,
                  score:
                      myMovesController.generateDifficultyProgress(difficulty),
                ),
                KPIBarMoveStat(
                  label: 'Learned Level',
                  textInsideBar: '${(learned * 100).toInt()} %',
                  score:
                      myMovesController.generateLearningLevelProgress(learned),
                ),
                ChipEquipmentMoveStats(
                  noEquipment: noEquipment,
                  dumbbells: dumbbells,
                  kettlebells: kettlebells,
                  bench: bench,
                  barbell: barbell,
                  weightMachinesSelectorized: weightMachinesSelectorized,
                  resistanceBandsCables: resistanceBandsCables,
                  leggings: leggings,
                  medicineBall: medicineBall,
                  stabilityBall: stabilityBall,
                  ball: ball,
                  trx: trx,
                  raisedPlatformBox: raisedPlatformBox,
                  box: box,
                  rings: rings,
                  pullUpBar: pullUpBar,
                  parallelsBar: parallelsBar,
                  wall: wall,
                  pole: pole,
                  trineo: trineo,
                  rope: rope,
                  wheel: wheel,
                  assaultBike: assaultBike,
                ),
              ],
            ),
          ),
          const ImageCardMoveStat()
        ],
      ),
    );
  }

  void setInitAttributes(Map attributes) {
    createDate = attributes['create_date'];
    id = attributes['id'];
    fitnessMoveId = attributes['fitness_move_id'];
    learned = attributes['learned'];
    isLike = attributes['is_like'];
    bestRecord = attributes['best_record'];
    bestTime = attributes['best_time'];
    moreUsedMode = attributes['more_used_mode'];
    avgRestTime = attributes['avg_rest_time'];
    avgWeight = attributes['avg_weight'];
    lastDateTrained = attributes['last_date_trained'];
    isRemoved = attributes['is_removed'];
    prioritize = attributes['prioritize'];
    name = attributes['name'];
    ytUrl = attributes['yt_url'];
    muscleProta = attributes['muscle_prota']!;
    bodyArea = attributes['body_area'];
    difficulty = attributes['difficulty'];
    movementPattern = attributes['movement_pattern'];
    dynamic = attributes['dynamic'];
    fullBody = attributes['full_body'];
    abs = attributes['abs'];
    obliques = attributes['obliques'];
    pect = attributes['pect'];
    deltoids = attributes['deltoids'];
    tricep = attributes['tricep'];
    back = attributes['back'];
    traps = attributes['traps'];
    lats = attributes['lats'];
    serratus = attributes['serratus'];
    spinalErectors = attributes['spinal_erectors'];
    bicep = attributes['bicep'];
    forearm = attributes['forearm'];
    leg = attributes['leg'];
    glutes = attributes['glutes'];
    quadriceps = attributes['quadriceps'];
    calves = attributes['calves'];
    neck = attributes['neck'];
    fingerFlexors = attributes['finger_flexors'];
    noEquipment = attributes['no_equipment'];
    dumbbells = attributes['dumbbells'];
    kettlebells = attributes['kettlebells'];
    bench = attributes['bench'];
    barbell = attributes['barbell'];
    weightMachinesSelectorized = attributes['weight_machines_selectorized'];
    resistanceBandsCables = attributes['resistance_bands_cables'];
    leggings = attributes['leggings'];
    medicineBall = attributes['medicine_ball'];
    stabilityBall = attributes['stability_ball'];
    ball = attributes['ball'];
    trx = attributes['trx'];
    raisedPlatformBox = attributes['raised_platform_box'];
    box = attributes['box'];
    rings = attributes['rings'];
    pullUpBar = attributes['pull_up_bar'];
    parallelsBar = attributes['parallels_bar'];
    wall = attributes['wall'];
    pole = attributes['pole'];
    trineo = attributes['trineo'];
    rope = attributes['rope'];
    wheel = attributes['wheel'];
    assaultBike = attributes['assault_bike'];
    isCompoundMovement = attributes['is_compound_movement'];
    maxRepsExpected = attributes['max_reps_expected'];
    description = attributes['description'];
  }
}
