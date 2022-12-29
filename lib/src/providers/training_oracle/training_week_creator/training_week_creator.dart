import '../wod_creator/wod_creator.dart';

class TrainingWeek {
  TrainingWeek({required int sessionDuration})
      : _sessionDuration = sessionDuration;
  final int _sessionDuration;
  late List<WODCreator> _wods;

  int get sessionDuration => _sessionDuration;

  List<WODCreator> get wods => _wods;

  void setWODS(List<WODCreator> WODS) {
    _wods = WODS;
  }

  // The total WODs in the training week.
  int get totalWODS => wods.length;

  setWODBlocks() {
    for(var wod in wods) {
      wod.setBlocks();
    }
  }

  @override
  String toString() {
    return 'TrainingWeek(sessionDuration=$sessionDuration, WODS = $wods)';
  }
}
