import 'package:audioplayers/audioplayers.dart';

/// Class `TimerSound` is responsible for playing sounds for the timer.
class TimerSound {
  /// Plays the sound `start_beep.mp3` when the timer is within the last 5 seconds.
  static void lastFiveSeconds(int seconds) {
    if (seconds >= 55) {
      final audioPlayer = AudioPlayer();
      audioPlayer.play(AssetSource('start_beep.mp3'));
      audioPlayer.release();
    }
  }

  /// Plays the sound `star_new_round.mp3` when the timer starts a new round.
  static void startNewRound(int seconds) {
    if (seconds == 0) {
      final audioPlayer = AudioPlayer();
      audioPlayer.setVolume(1);
      audioPlayer.play(AssetSource('star_new_round.mp3'));
      audioPlayer.release();
    }
  }

  /// Plays the sound `start_beep.mp3` when the timer is within the first 5 seconds.
  static void playReady(int seconds) {
    if (seconds <= 5) {
      final audioPlayer = AudioPlayer();
      audioPlayer.play(AssetSource('start_beep.mp3'));
      audioPlayer.release();
    }
  }

  /// Plays the sound `stop_beep.mp3` when the timer is paused.
  static void pause() {
    final audioPlayer = AudioPlayer();
    audioPlayer.play(AssetSource('stop_beep.mp3'));
    audioPlayer.release();
  }
}
