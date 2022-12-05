import 'dart:io';

Future<void> main() async {
  final input = new File('3/input.txt');

  prepPoints();
  partOne(input);
  partTwo(input);
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

void partTwo(File input) {
  final sum = sumOfPrioritiesFromChunks(input);

  print('2 - ' + sum.toString());
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
    points += charToPoints[char]!;
  }

  return points;
}

int sumOfPrioritiesFromChunks(File input) {
  var lines = input.readAsLinesSync().toList(growable: false);
  final chunks = <int, List<String>>{};

  var counter = 0;
  for (var i = 0; i < lines.length; i++) {
    if (!chunks.containsKey(counter)) {
      chunks[counter] = [lines[i]];
      continue;
    }
    if (chunks[counter]!.length < 3) {
      chunks[counter]!.add(lines[i]);
    }
    if (chunks[counter]!.length == 3) {
      counter++;
    }
  }

  var points = 0;
  final containedChars = <String>[];

  for (var chunk in chunks.entries) {
    final first = chunk.value.first.split('')..sort();
    final second = chunk.value[1].split('')..sort();
    final third = chunk.value.last.split('')..sort();

    final lineContainedChars = <String>{};

    for (var i = 0; i < first.length; i++) {
      if (second.contains(first[i]) && third.contains(first[i])) {
        lineContainedChars.add(first[i]);
      }
    }
    containedChars.addAll(lineContainedChars);
  }
  for (var char in containedChars) {
    points += charToPoints[char]!;
  }

  return points;
}

final charToPoints = <String, int>{};
