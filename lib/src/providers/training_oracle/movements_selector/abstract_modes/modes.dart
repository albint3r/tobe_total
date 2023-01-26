import '../../../cliente/model/cliente_model_provider.dart';
import '../../../my_movements/model/my_movements_model.dart';
import '../../block_creator/block_creator.dart';
import '../../movement_creator/movement_creator.dart';
import 'dart:math';

abstract class Modes {
  Modes({
    required BlockCreator context,
  }) : _context = context;

  final BlockCreator _context;

  /// Creates and returns a new [MovementCreator] instance based on
  /// the provided [index] and [movementOption].
  Future<MovementCreator> createMove(
      int index, Map<String, Object?> movementOption) async {
    return MovementCreator(
      context: currentBlock,
      index: index,
      data: movementOption,
    );
  }

  /// Saves the provided [movement] to the database and sets it as the
  /// current movement for [currentBlock].
  /// Also resets the [maxIterationCounter] and sets the muscle frequency
  /// for the week based on the muscle of the [movement].
  Future<void> setMovementSaveProcess(MovementCreator movement) async {
    currentBlock.setMovement(movement);
    setMuscleFreqOfTheWeek(movement.muscleProta, currentBlock.sets);
    resetMaxIterationCounter();
    await movement.save();
  }

  bool isMoveIdInBlock(int moveId) {
    return _context.isMoveIdInBlock(moveId);
  }

  /// Creates and adds the first move to the current block, if it is not
  /// already present in the list of my movements and the selected muscle
  /// frequency is available.
  /// If the move is not in the list of my movements and the
  /// [maxIterationCounter] is zero, it will be added to the block
  /// and to my history.
  Future<void> createFirstMove(int i) async {
    Map<String, Object?> movementOption;
    while (currentBlock.isFirstMoveToAdd) {
      movementOption = await getLearningMove();
      MovementCreator movement = await createMove(i, movementOption);
      // if the ID already exist in the Database it will skip
      // so the blocks list wont have the first Move inside.
      if (await notExistIdInMyMovements(movement.id) &&
          isSelectedMuscleFreqAvailable(
              movement.muscleProta, currentBlock.sets) &&
          !isMoveIdInBlock(movement.id)) {
        await movement.setRepsToDo();
        setMovementSaveProcess(movement);
        // If the counter is Zero it would use the move. But
        // only would be added to my history not to myMoves
      } else if (await notExistIdInMyMovements(movement.id) &&
          !isMoveIdInBlock(movement.id) &&
          isMaxIterCounterZero()) {
        await movement.setRepsToDo();
        setMovementSaveProcess(movement);
      }
      restMaxIterationCounter();
    }
  }

  Future<void> createFirstMoveWithLearningMoves(int i) async {
    Map<String, Object?> movementOption;
    while (currentBlock.isFirstMoveToAdd) {
      movementOption = await getLearningMove();
      MovementCreator movement = await createMove(i, movementOption);
      // Check if the muscle frequencies isn't full
      if (isSelectedMuscleFreqAvailable(
              movement.muscleProta, currentBlock.sets) &&
          !isMoveIdInBlock(movement.id)) {
        await movement.setRepsToDo();
        setMovementSaveProcess(movement);
        // If the counter is Zero it would use the move. But
        // only would be added to my history not to myMoves
      } else if (isMaxIterCounterZero() && !isMoveIdInBlock(movement.id)) {
        await movement.setRepsToDo();
        setMovementSaveProcess(movement);
      }
      restMaxIterationCounter();
    }
  }

  /// Creates and adds the next move to the current block, if it is not
  /// already present in the list of my movements and the selected
  /// muscle frequency is available.
  /// If the move is not in the list of my movements and the
  /// [maxIterationCounter] is zero, it will be added to the block
  /// and to my history.
  Future<void> createNextMove(int i) async {
    bool finisProcess = false;
    Map<String, Object?> movementOption;
    while (!finisProcess) {
      movementOption = await getLearningMoveNotCollidePrev();
      MovementCreator movement = await createMove(i, movementOption);
      // if the ID already exist in the Database it will skip
      // so the blocks list wont have the first Move inside.
      if (await notExistIdInMyMovements(movement.id) &&
          !isMoveIdInBlock(movement.id) &&
          isSelectedMuscleFreqAvailable(
              movement.muscleProta, currentBlock.sets)) {
        await movement.setRepsToDo();
        setMovementSaveProcess(movement);
        finisProcess = !finisProcess;
        // This will let the user add a move if this is not in [myMovements]
        // and the counter is Zero. This will pass the Muscle Freq rule.
        // If the counter is Zero it would use the move. But
        // only would be added to my history not to myMoves
      } else if (await notExistIdInMyMovements(movement.id) &&
          !isMoveIdInBlock(movement.id) &&
          isMaxIterCounterZero()) {
        await movement.setRepsToDo();
        setMovementSaveProcess(movement);
        finisProcess = !finisProcess;
      }
      restMaxIterationCounter();
    }
  }

  /// Creates and adds the next move to the current block, if it is not
  /// already present in the list of my movements and the selected
  /// muscle frequency is available.
  /// If the move is not in the list of my movements and the
  /// [maxIterationCounter] is zero, it will be added to the block
  /// and to my history.
  Future<void> getNextLearningMove(int i) async {
    bool finisProcess = false;
    Map<String, Object?> movementOption;
    while (!finisProcess) {
      movementOption = await getLearningMoveNotCollidePrev();
      MovementCreator movement = await createMove(i, movementOption);
      // if the ID already exist in the Database it will skip
      // so the blocks list wont have the first Move inside.
      if (isSelectedMuscleFreqAvailable(
              movement.muscleProta, currentBlock.sets) &&
          !isMoveIdInBlock(movement.id)) {
        await movement.setRepsToDo();
        setMovementSaveProcess(movement);
        finisProcess = !finisProcess;
        // This will let the user add a move if this is not in [myMovements]
        // and the counter is Zero. This will pass the Muscle Freq rule.
        // If the counter is Zero it would use the move. But
        // only would be added to my history not to myMoves
      } else if (isMaxIterCounterZero() && !isMoveIdInBlock(movement.id)) {
        await movement.setRepsToDo();
        setMovementSaveProcess(movement);
        finisProcess = !finisProcess;
      }
      restMaxIterationCounter();
    }
  }

  /// Creates a new block mode and set the movements for it.
  ///
  /// This method creates a new block mode and sets the movements for it.
  /// It also checks if there are any learning movements available
  /// and adds them to the block.
  /// The movements in the block are added iteratively, ensuring that
  /// no collision with previous movements occurs.
  /// If the learning movements list is full, the method will only add
  /// movements that are already learned.
  ///
  /// @return Future A future that completes with void when the block
  /// is created and the movements are set.
  Future<void> create() async {
    /// This Method Create the Block Mode Selected.
    //
    // Because is an extension of Blocks, this class have heavy relationship
    // So, this select all the move that would have the current block.
    Map<String, Object?> movementOption;
    // Iterate in all over the moves inside the Block.
    for (int i in currentBlock.getPossibleCreateMoves) {
      //1 - First Check if We have learning Moves.
      // If the list is full this will mean that We have move to learn.
      if (!await currentBlock.learningMovesIsFull()) {
        //2- Check if the Current Block is fill
        if (currentBlock.isFirstMoveToAdd) {
          // 4- Get Some Movements options
          // Iterate until the block have their first Move.
          await createFirstMove(i);
        } else {
          // is not the first move and you need to fill the rest of the block.
          await createNextMove(i);
        }
      } else {
        if (currentBlock.isFirstMoveToAdd) {
          // Select the first movement for the block, this will be
          // a not learned movement
          await createFirstMoveWithLearningMoves(i);
        } else {
          // Select next unlearned movement
          await getNextLearningMove(i);
        }
      }
    }
    print(
        '***WOD(WOD_ID=${currentBlock.context.index}, blocksInWod= ${currentBlock.context.totalBlocks})*******Block(index=${currentBlock.index}, totalMoves=${currentBlock.totalMovesInBlock}, blockDuration=${currentBlock.blockDuration}, mode=${currentBlock.mode} , sets = ${currentBlock.sets})****************');
    print(currentBlock.movements);
    print('************************************************');
    print(currentBlock.context.context.musclesMaxFreq);
  }

  BlockCreator get currentBlock => _context;

  int get clientLevel =>
      currentBlock.context.context.context.ref.watch(clientProvider).level;

  /// Get the equipment of the current client.
  ///
  /// @return A map with the equipment of the client.
  Future<Map> get clientEquipment async {
    return currentBlock.context.context.context.ref
        .watch(clientProvider)
        .getEquipment();
  }

  /// Increase the frequency count of a muscle in the current week.
  ///
  /// @param muscleName Name of the muscle to update.
  /// @param sets Number of sets to add to the current frequency count.
  void setMuscleFreqOfTheWeek(String muscleName, int sets) {
    // Apply the [setMuscleFreq] to increase the muscle count of the week.
    currentBlock.context.context.setMuscleFreq(muscleName, sets);
    print('UPDATE VALUES [setMuscleFreqOfTheWeek] -> $muscleName, $sets');
  }

  /// Check if it is possible to add a muscle frequency to the map.
  //
  /// @param muscleName Name of the muscle to add.
  /// @param sets Sets of the muscle to add.
  /// @return True if it is possible to add the muscle frequency, false otherwise
  bool isSelectedMuscleFreqAvailable(String muscleName, int sets) {
    return currentBlock.context.context
        .isSelectedMuscleFreqAvailable(muscleName, sets);
  }

  /// Decrement the value of [_maxIterCounter] by 1.
  void restMaxIterationCounter() {
    currentBlock.context.context.restMaxIterationCounter();
  }

  /// Get the current value of [_maxIterCounter].
  int get maxIterCounter {
    return currentBlock.context.context.maxIterCounter;
  }

  /// Reset the value of [_maxIterCounter] to its original value (100).
  void resetMaxIterationCounter() {
    currentBlock.context.context.resetMaxIterationCounter();
  }

  /// Returns `true` if the maximum iteration counter is zero, `false` otherwise.
  bool isMaxIterCounterZero() {
    return currentBlock.context.context.isMaxIterCounterZero();
  }

  void restSpecification();

  Future<Map<String, Object?>> getLearningMove() async {
    // Create and Call a query to get all the possible movements
    // for a new learning movement. In this case because is the first
    // we don't need to verify if not collide the movement pattern
    String selectedQueryBodyArea = queryBodyArea();
    String selectedQueryDifficulty = queryDifficulty();
    String selectedQueryEquipment = await queryEquipment();
    final myMovementsModel =
        currentBlock.context.context.context.ref.watch(myMovementsProvider);

    List<Map<String, Object?>> movementOption;
    // Use all fitness movements if learning moves is not full
    if (!await currentBlock.learningMovesIsFull()) {
      movementOption = await myMovementsModel.getAllPossibleMovements(
        selectedQueryBodyArea,
        selectedQueryDifficulty,
        selectedQueryEquipment,
      );
      // otherwise use only the learning movements to create the Block
    } else {
      movementOption = await myMovementsModel.getAllLearnedPossibleMovements(
        selectedQueryBodyArea,
        selectedQueryDifficulty,
        selectedQueryEquipment,
      );
    }
    // movementOption =
    //     await myMovementsModel.getAllLearnedPossibleMovements(
    //   selectedQueryBodyArea,
    //   selectedQueryDifficulty,
    //   selectedQueryEquipment,
    // );
    Random random = Random();
    int randomIndex = random.nextInt(movementOption.length);
    return movementOption[randomIndex];
  }

  Future<Map<String, Object?>> getLearningMoveNotCollidePrev() async {
    String selectedQueryBodyArea = queryBodyArea();
    String selectedQueryDifficulty = queryDifficulty();
    String selectedQueryEquipment = await queryEquipment();
    final myMovementsModel =
        currentBlock.context.context.context.ref.watch(myMovementsProvider);
    List<Map<String, Object?>> movementOption;
    // Use all fitness movements if learning moves is not full
    if (!await currentBlock.learningMovesIsFull()) {
      movementOption =
          await myMovementsModel.getAllPossibleMovementsNotCollidePrev(
              selectedQueryBodyArea,
              selectedQueryDifficulty,
              selectedQueryEquipment,
              getLastMovementPattern);
      // otherwise use only the learning movements to create the Block
    } else {
      movementOption = await myMovementsModel
          .getAllPossibleMovementsNotCollidePrevLearningMoves(
              selectedQueryBodyArea,
              selectedQueryDifficulty,
              selectedQueryEquipment,
              getLastMovementPattern);
    }
    Random random = Random();
    int randomIndex = random.nextInt(movementOption.length);
    return movementOption[randomIndex];
  }

  Future<bool> notExistIdInMyMovements(int moveId) async {
    // Check if the Id already exist in MyMovements
    // Return true if the ID [not exist.]
    final myMovementsModel =
        currentBlock.context.context.context.ref.watch(myMovementsProvider);
    return await myMovementsModel.notExistID(moveId);
  }

  String get getLastMovementPattern {
    // Return the las movement pattern.
    MovementCreator lastMove = currentBlock.movements.last;
    return lastMove.movementPattern;
  }

  Future<String> queryEquipment() async {
    // Get the dictionary with the customer's equipment
    final response = await clientEquipment;
    // Initialize the variable that will store the query
    String query = 'WHERE ';

    // Loop through each item in the dictionary
    for (var entry in response.entries) {
      // If the value is equal to 1, add the column and its value to the query
      if (entry.value == 1) {
        query += '${entry.key} = ${entry.value} OR ';
      }
    }

    // Remove the excess OR at the end
    if (query.endsWith(" OR ")) {
      query = query.substring(0, query.length - 4);
    }

    return query;
  }

  String queryBodyArea() {
    // Select a Query that would only return the movements
    // whit the same [BodyArea]
    switch (currentBlock.bodyArea) {
      case 'full_body':
        {
          return "WHERE body_area = 'full_body' OR body_area = 'core' OR body_area = 'upper' OR body_area = 'lower' OR body_area = 'monostructural'";
        }
      case 'upper':
        {
          return "WHERE body_area = 'upper' OR body_area = 'core' OR body_area = 'monostructural'";
        }
      case 'lower':
        {
          return "WHERE body_area = 'lower' OR body_area = 'core' OR body_area = 'monostructural'";
        }

      default:
        {
          return "WHERE body_area = 'full_body' OR body_area = 'core' OR body_area = 'upper' OR body_area = 'lower' OR body_area = 'monostructural'";
        }
    }
  }

  String queryDifficulty() {
    // Select a Query that would only return the movements
    // whit the same [BodyArea]
    switch (clientLevel) {
      case 0:
        {
          return "WHERE difficulty = 'beginner'";
        }
      case 1:
        {
          return "WHERE difficulty = 'beginner' OR difficulty = 'intermediate'";
        }
      case 2:
        {
          return "WHERE difficulty = 'beginner' OR difficulty = 'intermediate' OR difficulty = 'advanced'";
        }

      default:
        {
          return "WHERE difficulty = 'beginner' OR difficulty = 'intermediate' OR difficulty = 'advanced' OR difficulty = 'elit'";
        }
    }
  }
}
