import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../proxies/block_proxy.dart';
import '../../proxies/movement_proxy.dart';
import '../../proxies/wod_proxy.dart';

enum TimerState {
  unStarted,
  waitBlock,
  play,
  pause,
  stop,
  rateTraining,
  finishWorkOut
}

class TrainingTimerModel extends ChangeNotifier {
  // Initial state of the timer
  // Maximum duration of the timer in seconds
  late final ProxyWOD proxyWod;

  final int _maxSeconds = 60;
  bool isBeepSound = false;
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
    if(currentBlockIndex == null) {
      var blockToShowIndex = proxyWod.blocks!.keys.toList()[0];
      // TODO PUEDE SER PROBABLE QUE AL FINALIZAR EL ENTRENAMIENTO
      // EL INDEX SE MUEVA Y GENERE ERROR, ES IMPORTANTE MONITOREAR ESTO
      // PARA EVITAR QUE PASE CUANDO SE MUESTRAN LOS MOVIMIENTOS A HACER
      blockToShow = proxyWod.blocks![blockToShowIndex]!;
    } else {
      var blockToShowIndex = proxyWod.blocks!.keys.toList()[currentBlockIndex!];
      blockToShow = proxyWod.blocks![blockToShowIndex]!;
    }
    return blockToShow;
  }


  /// Get the time and Set of the current block.
  /// It decide if the timer go, stop or pause.
  void getTimeAndSets() {
    if (_seconds != maxSeconds && currentRoundsBlock != 0) {
      _seconds = _seconds + 1;
      _currentState = TimerState.play;
      notifyListeners();
      // Change Round State and reset time
    } else if (_seconds == maxSeconds && currentRoundsBlock != 0) {
      _seconds = 0;
      currentRoundsBlock = currentRoundsBlock! - 1;
      popMovementToDo();
      getNameCurrentMovement();
      notifyListeners();
      // Round finalize
    } else if (currentRoundsBlock == 0) {
      _timer?.cancel();
      _seconds = 0;
      // TODO CHANGE THE STATE TO EVALUATE THE BLOCK
      _currentState = TimerState.stop;
      notifyListeners();
    }
  }

  void getGetReadyTimer() {
    if (_seconds != 5) {
      _seconds = _seconds + 1;
      notifyListeners();
      // Change Round State and reset time
    } else {
      _seconds = 0;
      _currentState = TimerState.play;
      _timer?.cancel();
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
    switch(currentState) {
      case TimerState.unStarted:
        _currentState = TimerState.waitBlock;
        notifyListeners();
        startTimer();
        break;
      case TimerState.waitBlock:
        getNextBlock();
        getNameCurrentMovement();
        _seconds = _seconds;
        _timer = Timer.periodic(
          const Duration(seconds: 1),
              (timer) {
            // this is the 5 second timer, it will be use if the other timer is not required yet.
            getGetReadyTimer();
          },
        );
        break;
      case TimerState.play:
      // Get the information of the next block to do.
        // this help for the pause option, if the value is zero still zero,
        // but if came after a pause, this will continue in the number it stop.
        _seconds = _seconds == 0 ? 0: _seconds;
        _timer = Timer.periodic(
          const Duration(seconds: 1),
              (timer) {
            getTimeAndSets();
          },
        );
        break;
      case TimerState.pause:
        _timer = Timer.periodic(
          const Duration(seconds: 1),
              (timer) {
            if (_seconds != 12) {
              _seconds = _seconds + 1;
              _currentState = TimerState.play;
              notifyListeners();
              _timer?.cancel();
              startTimer();
            }
          },
        );
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


    // When the block isn't started it will change to waitBlock Data
    // if (currentState == TimerState.unStarted) {
    //   _currentState = TimerState.waitBlock;
    //   notifyListeners();
    //   startTimer();
    // } else if(currentState == TimerState.waitBlock) {
    //   getNextBlock();
    //   getNameCurrentMovement();
    //   _seconds = 0;
    //   _timer = Timer.periodic(
    //     const Duration(seconds: 1),
    //         (timer) {
    //       getGetReadyTimer();
    //     },
    //   );
    // } else if (currentState == TimerState.play) {
    //   // Get the information of the next block to do.
    //   _seconds = 0;
    //   _timer = Timer.periodic(
    //     const Duration(seconds: 1),
    //     (timer) {
    //       getTimeAndSets();
    //     },
    //   );
    // } else if (currentState == TimerState.pause) {
    //   _timer = Timer.periodic(
    //     const Duration(seconds: 1),
    //     (timer) {
    //       if (_seconds != maxSeconds) {
    //         _seconds = _seconds + 1;
    //         _currentState = TimerState.play;
    //         notifyListeners();
    //       }
    //     },
    //   );
    // }


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
      _currentState = TimerState.pause;
      _timer?.cancel();
      notifyListeners();
    }
  }

  //Method that stops the timer
  void stopTimer() {
    if (currentState == TimerState.pause || currentState == TimerState.play) {
      _timer?.cancel();
      _seconds = 0;
      _currentState = TimerState.stop;
      notifyListeners();
    }
  }

  void setBeepSound(){
    isBeepSound = true;
  }

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

final trainingTimerProvider = ChangeNotifierProvider<TrainingTimerModel>((ref) {
  final proxyWod = ref.watch(proxyWodProvider);
  final timeModel = TrainingTimerModel();
  timeModel.proxyWod = proxyWod;
  return timeModel;
});
