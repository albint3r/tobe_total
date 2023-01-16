import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../proxies/movement_proxy.dart';
import '../../proxies/wod_proxy.dart';

enum TimerState { play, pause, stop, finish }

class TrainingTimerModel extends ChangeNotifier {
  // Initial state of the timer
  // Maximum duration of the timer in seconds
  late final ProxyWOD proxyWod;

  final int _maxSeconds = 60;

  int? currentBlockIndex;
  int? roundsCurrentBlock;
  int? currentBlockTotalMovements;
  ProxyMovement? currentMovement;

  int? get totalBlocksInWod => proxyWod.blocks?.length;

  // Timer instance
  Timer? _timer;

  // Is the current Second in the timer
  int _seconds = 0;

  // Is the timer State
  TimerState _currentState = TimerState.stop;

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
    if (currentState == TimerState.stop) {
      // Get the information of the next block to do.
      getNextBlock();
      getNameCurrentMovement();
      _seconds = 0;
      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          // Normal
          if (_seconds != maxSeconds && roundsCurrentBlock != 0) {
            _seconds = _seconds + 1;
            _currentState = TimerState.play;
            notifyListeners();
          } else if (_seconds == maxSeconds && roundsCurrentBlock != 0) {
            _seconds = 0;
            roundsCurrentBlock = roundsCurrentBlock! - 1;
            popMovementToDo();
            getNameCurrentMovement();
            notifyListeners();
          } else if (roundsCurrentBlock == 0) {
            print('ya acabe');
            print('ya acabe');
            print('ya acabe');
            print('ya acabe');
            _timer?.cancel();
            _seconds = 0;
            _currentState = TimerState.stop;
            notifyListeners();
          }
        },
      );
    } else if (currentState == TimerState.pause) {
      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          if (_seconds != maxSeconds) {
            _seconds = _seconds + 1;
            _currentState = TimerState.play;
            notifyListeners();
          }
        },
      );
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
    _currentState = TimerState.pause;
    _timer?.cancel();
    notifyListeners();
  }

  //Method that stops the timer
  void stopTimer() {
    _timer?.cancel();
    _seconds = 0;
    _currentState = TimerState.stop;
    notifyListeners();
  }

  void getNextBlock() {
    // Get the next block to train and the Movement sequence.
    proxyWod.getNextBlock();
    proxyWod.getMovementToDo();
    if (proxyWod.movementToDo != null) {
      roundsCurrentBlock = proxyWod.movementToDo?.length;
      // this is a ref to save the total rounds and the remaining
      currentBlockTotalMovements = roundsCurrentBlock;
      if (currentBlockIndex == null) {
        currentBlockIndex = 1;
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
  final t = TrainingTimerModel();
  t.proxyWod = proxyWod;
  return t;
});
