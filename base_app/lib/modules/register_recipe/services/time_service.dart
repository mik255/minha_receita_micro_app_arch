class TimeService {
  String formatTime(int time) {

    if (time == 0) {
     throw 'Tempo não pode ser 0';
    }
    //mim
    if (time < 60) {
      return '$time mim';
    }
    //h
    if (time < 1440) {
      return '${(time / 60).floor()} h';
    }
    return '${(time / 1440).floor()} d';
  }
}
