String timeConvertor(double time) {
  if (time >= 3600) {
    double toReturn = time / 3600;
    int q = time ~/ 3600;
    int r = (time % 3600).toInt();
    if (r == 0) {
      return '$q h';
    } else {
      int qOfMin = r ~/ 60;
      return '$q h $qOfMin m';
    }
//    toReturn = num.parse(toReturn.toStringAsFixed(2));
//    return '$toReturn h';
  } else if (time >= 60) {
//    double toReturn = time / 60;
    int q = time ~/ 60;
    int r = (time % 60).toInt();
    if (r == 0) {
      return '$q m';
    } else {
      return '$q m $r s';
    }
  } else {
    return '${time.toInt()} s';
  }
}
