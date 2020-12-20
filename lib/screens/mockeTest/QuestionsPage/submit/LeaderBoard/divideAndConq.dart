import 'dart:math';

void main() {
  // int athul = 16;
  // // var list = [5, 8, 10, 12, 16, 18, 19, 35, 36, 100, 200, 300, 350, 500];
  // List<Map> list = [
  //   {'score': 2},
  //   {'score': 5},
  //   {'score': 7}
  // ];
  // // list.insert(0, 6);
  // // int a = sort(0, list.length - 1, 0, list, 51);
  // int a = addToSortedListIndex(0, list.length - 1, list, 0, 15, false);
  // Map toadd = {'score': 15};
  // list.insert(a, toadd);
  // print('a= $list');
  List<Map> list = [];
  var rng = new Random();

  for (int i = 0; i < 100000; i++) {
    int r = rng.nextInt(1000);
    list.add({'score': r});
  }
  print(list.length);
  sortArray(list);
}

int addToSortedListIndex(int first, int last, List<Map> list, int index,
    int num, bool firstChecked) {
  if (firstChecked == false) {
    if (num <= list[first]['score']) {
      return 0;
    } else if (num >= list[last]['score']) {
      return list.length;
    }
  }
  if (first == last) {
    if (num <= list[first]['score']) {
      index = first - 1;
      if (first == 0) index = 0;
      return index;
    } else {
      print(first + 1);
      index = first + 1;
      return index;
    }
  } else if (first == last - 1) {
    if (num == list[first]['score']) return first;
    if (num == list[last]['score']) return last;
    if (num < list[first]['score']) {
      index = first - 1;
      return index;
    } else if (list[last]['score'] > num) {
      return index = first + 1;
      // or index=last;
    } else
      return index = last + 1;
  } else {
    int mid = ((first + last) / 2).floor();
    if (list[mid]['score'] == num) return mid;
    if (list[mid]['score'] > num) {
      return index = addToSortedListIndex(first, mid, list, index, num, true);
    } else {
      // print(
      //     'called : greater than ${list[mid]} index= $index ,mid :$mid ,last: $last');
      return index = addToSortedListIndex(mid, last, list, index, num, true);
    }
  }
}

sortArray(List<Map> toSort) {
  if (toSort.length < 1) {
    return [];
  }
  List<Map> result = [];
  result.add(toSort[0]);
  for (int i = 1; i < toSort.length; i++) {
    int indexToAdd = addToSortedListIndex(
        0, result.length - 1, result, 0, toSort[i]['score'], false);
    result.insert(indexToAdd, toSort[i]);
  }
  print('sorted List : $result');
}
