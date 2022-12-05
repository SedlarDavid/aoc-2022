import 'dart:io';

Future<void> main() async {
  final input = new File('3/input.txt');

  prepPoints();
  partOne(input);
}

void prepPoints() {
  final alphabetUpperCase =
      List.generate(26, (index) => String.fromCharCode(index + 65));
  final alphabetLowerCase =
      List.generate(26, (index) => String.fromCharCode(index + 97));

  final chars = [...alphabetLowerCase, ...alphabetUpperCase].toList();
  for (var i = 0; i < chars.length; i++) {
    charToPoints[chars[i]] = i + 1;
  }
}

void partOne(File input) {
  final sum = sumOfPriorities(input);

  print('1 - ' + sum.toString());
}

int sumOfPriorities(File input) {
  final lines = input.readAsLinesSync().toList(growable: false);

  var points = 0;
  final containedChars = <String>[];

  for (var line in lines) {
    var first = line.substring(0, (line.length / 2).ceil()).split('')..sort();
    var second = line.substring((line.length / 2).ceil()).split('')..sort();
    if (first.length != second.length) {
      continue;
    }

    final lineContainedChars = <String>{};

    for (var i = 0; i < first.length; i++) {
      if (second.contains(first[i])) {
        lineContainedChars.add(first[i]);
      }
    }
    containedChars.addAll(lineContainedChars);
  }
  for (var char in containedChars) {
    print(char + " " + charToPoints[char]!.toString());
    points += charToPoints[char]!;
  }

  return points;
}

final charToPoints = <String, int>{};
