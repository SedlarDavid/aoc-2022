import 'dart:io';

Future<void> main() async {
  final input = new File('2/input.txt');

  partOne(input);
}

void partOne(File input) {
  final points = pointsForGame(input);

  print('1 - ' + points.toString());
}

int pointsForGame(File input) {
  final data = input.readAsLinesSync().toList(growable: false);

  var points = 0;

  for (var line in data) {
    final split = line.split(" ");
    if (isDraw(split.first, split.last)) {
      points += 3;
      points += decisionToPoint[split.last] ?? 0;
      continue;
    }
    if (isWin(split.first, split.last)) {
      points += 6;
    } else {
      points += 0;
    }

    points += decisionToPoint[split.last] ?? 0;
    continue;
  }

  return points;
}

bool isDraw(String a, String b) {
  final op = oponnent.indexOf(a);
  final me = myself.indexOf(b);

  return op == me;
}

bool isWin(String a, String b) {
  final op = oponnent.indexOf(a);
  final me = myself.indexOf(b);

  return (me == 0 && op == 1) || (me == 1 && op == 2) || (me == 2 && op == 0);
}

const oponnent = ["A", "B", "C"];
const myself = ["X", "Y", "Z"];
final decisionToPoint = <String, int>{"X": 1, "Y": 2, "Z": 3};
