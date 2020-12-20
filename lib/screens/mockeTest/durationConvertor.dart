String secondsConvertor(int sec) {
  var toReturn;
  if (sec >= 3600) {
    toReturn = (sec / 3600);
    int q = sec ~/ 3600;
    int r = sec % 3600;
    if (r == 0) {
      if (q > 1) {
        return ('$q Hours');
      } else {
        return ('$q Hour');
      }
    } else {
      int qOfMin = r ~/ 60;
      if (q > 1) {
        return ('$q Hours $qOfMin m');
      } else {
        return ('$q Hour $qOfMin m');
      }
    }
  } else {
    toReturn = sec / 60;
    return ('$toReturn minutes');
  }
}
