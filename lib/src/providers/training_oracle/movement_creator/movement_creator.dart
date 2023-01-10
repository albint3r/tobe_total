import '../../movement_history/model/movement_history_model.dart';
import '../../my_movements/model/my_movements_model.dart';
import '../block_creator/block_creator.dart';

class MovementCreator {
  MovementCreator({
    required BlockCreator context,
    required this.index,
    required Map data,
  }) : _context = context,
        id = data['id'],
        name = data['name'],
        ytUrl = data['yt_url'],
        muscleProta = data['muscle_prota'],
        bodyArea = data['body_area'],
        difficulty = data['difficulty'],
        movementPattern = data['movement_pattern'],
        dynamic = data['dynamic'],
        fullBody = data['full_body'],
        abs = data['abs'],
        obliques = data['obliques'],
        pect = data['pect'],
        deltoids = data['deltoids'],
        tricep = data['tricep'],
        back = data['back'],
        traps = data['traps'],
        lats = data['lats'],
        serratus = data['serratus'],
        spinalErectors = data['spinal_erectors'],
        bicep = data['bicep'],
        forearm = data['forearm'],
        leg = data['leg'],
        glutes = data['glutes'],
        quadriceps = data['quadriceps'],
        calves = data['calves'],
        neck = data['neck'],
        fingerFlexors = data['finger_flexors'],
        noEquipment = data['no_equipment'],
        dumbbells = data['dumbbells'],
        kettlebells = data['kettlebells'],
        bench = data['bench'],
        barbell = data['barbell'],
        weightMachinesSelectorized = data['weight_machines_selectorized'],
        resistanceBandsCables = data['resistance_bands_cables'],
        leggings = data['leggings'],
        medicineBall = data['medicine_ball'],
        stabilityBall = data['stability_ball'],
        ball = data['ball'],
        trx = data['trx'],
        raisedPlatformBox = data['raised_platform_box'],
        box = data['box'],
        rings = data['rings'],
        pullUpBar = data['pull_up_bar'],
        parallelsBar = data['parallels_bar'],
        wall = data['wall'],
        pole = data['pole'],
        trineo = data['trineo'],
        rope = data['rope'],
        wheel = data['wheel'],
        assaultBike = data['assault_bike'],
        isCompoundMovement = data['is_compound_movement'] ?? 0,
        maxRepsExpected = data['max_reps_expected'] ?? 15,
        description = data['description'] ?? ''
  ;

  int index;
  final BlockCreator _context;

  int id;
  String name;
  String ytUrl;
  String muscleProta;
  String bodyArea;
  String difficulty;
  String movementPattern;
  int dynamic;
  int fullBody;
  int abs;
  int obliques;
  int pect;
  int deltoids;
  int tricep;
  int back;
  int traps;
  int lats;
  int serratus;
  int spinalErectors;
  int bicep;
  int forearm;
  int leg;
  int glutes;
  int quadriceps;
  int calves;
  int neck;
  int fingerFlexors;
  int noEquipment;
  int dumbbells;
  int kettlebells;
  int bench;
  int barbell;
  int weightMachinesSelectorized;
  int resistanceBandsCables;
  int leggings;
  int medicineBall;
  int stabilityBall;
  int ball;
  int trx;
  int raisedPlatformBox;
  int box;
  int rings;
  int pullUpBar;
  int parallelsBar;
  int wall;
  int pole;
  int trineo;
  int rope;
  int wheel;
  int assaultBike;
  int isCompoundMovement;
  int maxRepsExpected;
  String description;

  BlockCreator get currentBlock => _context;

  /// Saves the current movement in my_movements and movement_history.
  /// If the movement is already in my_movements, it will only be added to movement_history.
  /// Throws an exception in case of error.
  Future<void> save() async {
    // Save in my_movements and history_movement
    final myMovementsModel = currentBlock.context.context.context.ref.watch(myMovementsProvider);
    final movementHistoryModel = currentBlock.context.context.context.ref.watch(movementHistoryModelProvider);
    try {
      await myMovementsModel.addNew(id);
    } catch(e) {
      print('************************************');
      print('The Movement is Already in MyMovements');
      print('This would be added to my MovementHistory only');
      print(e);
      print('************************************');
      print('');
    }
    await movementHistoryModel.addNew(id, currentBlock.id);
  }

  @override
  String toString() {
    return 'Move(index=$index, name=$name, muscleProta=$muscleProta, movementPattern=$movementPattern, bodyArea=$bodyArea, difficulty=$difficulty)';
  }
}
