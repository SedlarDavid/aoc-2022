import 'dart:io';
import 'dart:math';

Future<void> main() async {
  final input = new File('1/input.txt');

  partOne(input);
}

void partOne(File input) {
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

  print(indexToCallories.values.reduce(max));
}
