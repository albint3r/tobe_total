import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:tobe_total/src/providers/block/model/block_model_provider.dart';
import 'package:tobe_total/src/providers/my_movements/model/my_movements_model.dart';
import 'package:tobe_total/src/providers/routes/routes_provider.dart';
import 'package:tobe_total/src/providers/wod/model/wod_model_provider.dart';
import 'package:tobe_total/src/repositories/my_movements_repository.dart';
import '../../../repositories/blocks_repository.dart';
import '../../../repositories/movement_history_repository.dart';
import '../../../repositories/wods_repository_repository.dart';
import '../../../routes/const_url.dart';
import '../../movement_history/model/movement_history_model.dart';
import '../../proxies/block_proxy.dart';
import '../../proxies/movement_proxy.dart';
import '../../proxies/wod_proxy.dart';
import 'package:audioplayers/audioplayers.dart';


enum TimerState {
  unStarted,
  waitBlock,
  play,
  pause,
  stop, // SKIP AND STOP ARE THE SAME.
  rateTraining,
  finishWorkOut
}

class TrainingTimerModel extends ChangeNotifier {
  // Initial state of the timer
  // Maximum duration of the timer in seconds

  late final ProxyWOD proxyWod;
  late final MovementHistory _movementsHistoryModel;
  late final MyMovements _myMovementsModel;
  late final Blocks _blocksModel;
  late final WODs _wodsModel;

  final int _maxSeconds = 60;
  int? currentBlockIndex;
  int? currentRoundsBlock;
  int? currentBlockTotalMovements;
  ProxyMovement? currentMovement;

  int? get totalBlocksInWod => proxyWod.blocks?.length;

  // Timer instance
  Timer? _timer;

  // Is the current Second in the timer
  int _seconds = 0;

  // Is the timer State
  TimerState _currentState = TimerState.unStarted;

  // Getter that returns the current state of the timer
  int get seconds => _seconds;

  // Getter that returns the maximum duration of the timer
  int get maxSeconds => _maxSeconds;

  TimerState get currentState => _currentState;

  //Method that checks if the timer has reached its maximum duration
  bool isMaxSeconds() {
    if (seconds > _maxSeconds) {
      return true;
    }
    return false;
  }

  /// Set the [movementsHistoryModel] to update the rates results
  /// After the training is over.
  void setMovementsHistoryModel(MovementHistory movementHistory) {
    _movementsHistoryModel = movementHistory;
  }

  void setMyMovementsModel(MyMovements myMovements) {
    _myMovementsModel = myMovements;
  }

  /// Set the [wodsModel] to update the rates results
  /// After the training is over.
  void setWodsModel(WODs wodsModel) {
    _wodsModel = wodsModel;
  }

  /// Set the [Block] Model to update the [blocks] results.
  void setBlockModel(Blocks blockModel) {
    _blocksModel = blockModel;
  }

  /// Set the Proxy Model this will help to manage all the Block in the WOD
  void setProxyWod(ProxyWOD wod) {
    proxyWod = wod;
  }

  getNameCurrentMovement() {
    int index;
    int currentMovementId;
    if (currentMovement == null) {
      index = proxyWod.movementToDo!.first;
      currentMovementId =
          proxyWod.currentBlockProcessing!.movements.keys.toList()[index];
      currentMovement =
          proxyWod.currentBlockProcessing!.movements[currentMovementId];
    } else {
      try {
        index = proxyWod.movementToDo!.first;
        currentMovementId =
            proxyWod.currentBlockProcessing!.movements.keys.toList()[index];
        currentMovement =
            proxyWod.currentBlockProcessing!.movements[currentMovementId];
      } catch (e) {
        print(e);
      }
    }
  }

  ProxyBlock selectBlockMoveToShow() {
    ProxyBlock blockToShow;
    if (currentBlockIndex == null) {
      var blockToShowIndex = proxyWod.blocks!.keys.toList()[0];
      blockToShow = proxyWod.blocks![blockToShowIndex]!;
    } else {
      // This catch an error that occur when the user ends the training
      // answering the Quiz training, this try to get another index out of range
      try {
        var blockToShowIndex =
            proxyWod.blocks!.keys.toList()[currentBlockIndex!];
        blockToShow = proxyWod.blocks![blockToShowIndex]!;
      } catch (e) {
        blockToShow = proxyWod.blocks![0]!;
      }
    }
    return blockToShow;
  }


  void playLastFiveSecondsSound() {
    if(_seconds >=55) {
      final audioPlayer = AudioPlayer();
      audioPlayer.play(AssetSource('start_beep.mp3'));
      audioPlayer.release();
    }
  }

  void playStartNewRoundSound() {
    if(_seconds ==0) {
      final audioPlayer = AudioPlayer();
      audioPlayer.setVolume(1);
      audioPlayer.play(AssetSource('star_new_round.mp3'));
      audioPlayer.release();
    }
  }

  void playReadyBlockSound() {
    if(_seconds <=5) {
      final audioPlayer = AudioPlayer();
      audioPlayer.play(AssetSource('start_beep.mp3'));
      audioPlayer.release();
    }
  }

  void pauseSound() {
    final audioPlayer = AudioPlayer();
    audioPlayer.play(AssetSource('stop_beep.mp3'));
    audioPlayer.release();
  }


  /// Get the time and Set of the current block.
  /// It decide if the timer go, stop or pause.
  void getTimeAndRounds() {
    if (_seconds != maxSeconds && currentRoundsBlock != 0) {
      // if the remaining time is 5 or less, start sound counting
      playLastFiveSecondsSound();
      playStartNewRoundSound();
      _seconds = _seconds + 1;
      _currentState = TimerState.play;
      notifyListeners();
      // Change Round State and reset time
    } else if (_seconds == maxSeconds && currentRoundsBlock != 0) {
      _seconds = 0;
      // Change the state o the Blocks Clock
      currentRoundsBlock = currentRoundsBlock! - 1;
      // Delete the movement of the last block.
      popMovementToDo();
      // Obtain the name of the new movements to display in [show moves]
      getNameCurrentMovement();
      notifyListeners();
      // Block is finished
    } else if (currentRoundsBlock == 0) {
      setRateBlock();
    }
  }

  void setRateBlock() {
    _currentState = TimerState.rateTraining;
    resetTimer();
    notifyListeners();
  }

  void getGetReadyTimer() {
    if (_seconds != 5) {
      playReadyBlockSound();
      _seconds = _seconds + 1;
      notifyListeners();
      // Change Round State and reset time
    } else {
      _seconds = 0;
      _currentState = TimerState.play;
      notifyListeners();
      startTimer();
    }
  }

  /// Starts the timer.
  ///
  /// If the current state of the timer is [TimerState.stop],
  /// it will set the seconds to 0,
  /// and start a new periodic timer with a duration of 1 second,
  /// and set the current state to [TimerState.play] and notify the listeners.
  ///
  /// If the current state of the timer is [TimerState.pause],
  /// it will start a new periodic timer
  /// with a duration of 1 second, and set the current state to
  /// [TimerState.play] and notify the listeners.
  ///
  /// The [currentState] should be of type [TimerState],
  /// otherwise, it will not perform any action.
  void startTimer() {
    switch (currentState) {
      case TimerState.unStarted:
        skipBlock();
        break;
      case TimerState.waitBlock:
        // If the Ready Timer is running (sec more than zero)
        // it wont let the user click, preventing having two timers at the
        // same time.
        if (_seconds == 0) {
          _timer = Timer.periodic(
            const Duration(seconds: 1),
            (timer) {
              // this is the 5 second timer, it will be use if the other
              // timer is not required yet.
              getGetReadyTimer();
            },
          );
        }
        break;
      case TimerState.play:
        // Get the information of the next block to do.
        // this help for the pause option, if the value is zero still zero,
        // but if came after a pause, this will continue in the number it stop.

        //***********************************************************************
        // CANCEL THE TIMER BEFORE STARTING IS TO AVOID THE TIMER DUPLICATION
        // THIS DUPLICATION HAPPEN WHEN THE TIMER IN THE PLAY STATE AND
        // YOU CLICK AGAIN TO START, THIS CREATE ANOTHER TIMER, BUT THE LAST
        // IS STILL RUNNING, THIS IS WHY I CANCEL ONLY IF EXIST BEFORE.
        //***********************************************************************
        _timer?.cancel();
        _seconds = _seconds == 0 ? 0 : _seconds;
        _timer = Timer.periodic(
          const Duration(seconds: 1),
          (timer) {
            getTimeAndRounds();
          },
        );
        break;
      case TimerState.pause:
        pauseSound();
        _currentState = TimerState.play;
        notifyListeners();
        startTimer();
        break;
      case TimerState.stop:
        _currentState = TimerState.waitBlock;
        notifyListeners();
        startTimer();
        break;
      case TimerState.rateTraining:
        // TODO: Handle this case.
        break;
      case TimerState.finishWorkOut:
        // TODO: Handle this case.
        break;
    }
  }

  /// Pauses the timer.
  ///
  /// It sets the current state of the timer to [TimerState.pause]
  /// and notify the listeners.
  ///
  /// The [currentState] should be of type [TimerState], otherwise,
  /// it will not perform any action.
  void pauseTime() {
    if (currentState == TimerState.play || currentState == TimerState.stop) {
      pauseSound();
      _currentState = TimerState.pause;
      _timer?.cancel();
      notifyListeners();
    }
  }

  //Method that stops the timer
  void skipBlock() {
    if (currentState == TimerState.pause ||
        currentState == TimerState.play ||
        currentState == TimerState.unStarted ||
        currentState == TimerState.rateTraining) {
      getNextBlock();
      getNameCurrentMovement();
      resetTimer();
      setStateFinishOrStop();
      notifyListeners();
    }
  }

  /// Check if the WorkOut is finished
  bool get isFinishWorkOut => _currentState == TimerState.finishWorkOut;

  void resetTimer() {
    _timer?.cancel();
    _seconds = 0;
  }

  void updateLearningMove() {
    print('updateLearningMove----------------');
    for (var block in proxyWod.blocks!.values) {
      for (ProxyMovement move in block.movements.values) {
        // Check if the client did All the Reps
        // If is True, the value would be updated in MyMovements
        if (move.didAllReps ?? false) {
          _myMovementsModel.updateLearnedValues(move: move);
        }
      }
    }
  }

  /// Return is Finished if the Training don't have more Blocks in the Wod
  void setStateFinishOrStop() {
    if (currentBlockIndex != totalBlocksInWod) {
      _currentState = TimerState.stop;
    } else {
      _currentState = TimerState.finishWorkOut;
    }
  }

  /// This save all the results and go the the progress screen.
  /// this function is running in the:
  /// widget -> [rate_block_dialog.dart]
  /// file -> [RateBlockDialog]
  void saveAndExitTraining(BuildContext context, WidgetRef ref) {
    final routes = ref.watch(routesProvider);
    saveMovesResults();
    saveBlocksResults();
    saveWodResults();
    updateLearningMove();
    routes.navigateTo(context, ConstantsUrls.progress);
  }

  void saveMovesResults() {
    print(proxyWod.blocks);
    for (var block in proxyWod.blocks!.entries) {
      for (var move in block.value.movements.entries) {
        print('MOVE TO SAVE RESULTS [${move.value.name}]----------------');
        print('ID ${move.value.id}');
        print('didExercise -> ${move.value.didExercise}');
        print('didAllReps -> ${move.value.didAllReps}');
        print('canDoMore -> ${move.value.canDoMore}');
        // Update values in the Database
        _movementsHistoryModel.updateRateMovement(move: move.value);
      }
    }
  }

  /// Set in the objet the values to [Update] latter the [Block] as Did it!
  void setDidBlock() {
    proxyWod.currentBlockProcessing?.didBlock = 1;
    proxyWod.currentBlockProcessing?.isCreatedManual = 0;
    proxyWod.currentBlockProcessing?.isEdited = 0;
  }

  /// Update the [Blocks] Results in DB
  void saveBlocksResults() {
    _blocksModel.updateBlocksTrainedInfo(proxyWod.blocks!);
  }

  /// Save [WODs] Result After training.
  void saveWodResults() {
    proxyWod.didWod = 1; // 1 is TRUE check note in proxyWod class.
    proxyWod.isCreatedManual = 0; // 1 is TRUE check note in proxyWod class.
    proxyWod.isEdited = 0; // 1 is TRUE check note in proxyWod class.
    _wodsModel.updateWodTrainedInfo(proxyWod);
  }

  /// Get the next [block] that would be trained and the [movements].
  void getNextBlock() {
    // Get the next block to train and the Movement sequence.
    proxyWod.getNextBlock();
    proxyWod.getMovementToDo();
    if (proxyWod.movementToDo != null) {
      currentRoundsBlock = proxyWod.movementToDo?.length;
      // this is a ref to save the total rounds and the remaining
      currentBlockTotalMovements = currentRoundsBlock;
      if (currentBlockIndex == null) {
        currentBlockIndex = 0;
      } else {
        currentBlockIndex = currentBlockIndex! + 1;
      }
    }
  }

  void popMovementToDo() {
    proxyWod.movementToDo!.removeAt(0);
  }
}

final trainingTimerProvider = ChangeNotifierProvider.autoDispose<TrainingTimerModel>((ref) {
  final proxyWod = ref.watch(proxyWodProvider);
  final movementHistoryModel = ref.watch(movementHistoryModelProvider);
  final myMovementsModel = ref.watch(myMovementsProvider);
  final blocksModel = ref.watch(blocksModelProvider);
  final wodModel = ref.watch(wodsModelProvider);
  final timeModel = TrainingTimerModel();
  // Set Model in the Timer
  timeModel.setMovementsHistoryModel(movementHistoryModel);
  timeModel.setMyMovementsModel(myMovementsModel);
  timeModel.setWodsModel(wodModel);
  timeModel.setBlockModel(blocksModel);
  timeModel.setProxyWod(proxyWod);
  return timeModel;
});
