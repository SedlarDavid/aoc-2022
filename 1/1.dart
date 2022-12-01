import 'dart:io';
import 'dart:math';

Future<void> main() async {
  final input = new File('1/input.txt');

  partOne(input);
  partTwo(input);
}

void partOne(File input) {
  final indexToCallories = getIndexToCalories(input);

  print('1 - ' + indexToCallories.values.reduce(max).toString());
}

void partTwo(File input) {
  final indexToCallories = getIndexToCalories(input);

  final topFirst = indexToCallories.values.reduce(max);
  indexToCallories.removeWhere((key, value) => value == topFirst);

  final topSecond = indexToCallories.values.reduce(max);
  indexToCallories.removeWhere((key, value) => value == topSecond);

  final topThird = indexToCallories.values.reduce(max);

  print('2 - ' + (topFirst + topSecond + topThird).toString());
}

Map<int, int> getIndexToCalories(File input) {
  final data = input
      .readAsLinesSync()
      .map((l) => int.tryParse(l))
      .toList(growable: false);

  var index = 0;
  var indexToCallories = <int, int>{
    0: 0,
  };
  for (var callory in data) {
    if (callory != null) {
      if (!indexToCallories.containsKey(index)) {
        indexToCallories[index] = 0;
      }
      var sum = indexToCallories[index]!;
      sum += callory;
      indexToCallories[index] = sum;
    } else {
      index++;
      continue;
    }
  }
  return indexToCallories;
}
