import 'dart:collection';
import 'dart:io';

Future<void> main() async {
  final input = new File('5/input.txt');

  processInput(input);

  print(crateStacks.values
      .map((e) => e.first.replaceAll(']', '').replaceAll('[', ''))
      .join());
}

void processInput(File input) {
  var lines = input.readAsLinesSync().toList(growable: false);

  var isStep = false;
  for (var line in lines) {
    if (line.isEmpty) {
      isStep = true;
      crateStacks.values.forEach((stack) =>
          stack.removeWhere((element) => RegExp(r'^\s*$').hasMatch(element)));
    }

    if (!isStep && line.contains('[')) {
      //process crates in columns

      final crates = <String>[];

      for (var i = 0; i < line.length; i++) {
        final maybeCrate = line.substring(i, i + 3);
        crates.add(maybeCrate);
        i += 3;
      }

      for (var i = 0; i < crates.length; i++) {
        if (crates[i].isEmpty) {
          continue;
        }

        if (!crateStacks.containsKey(i + 1)) {
          crateStacks[i + 1] = Queue<String>();
        }
        crateStacks[i + 1]!.addLast(crates[i]);
      }
    } else {
      if (!line.contains('move')) continue;
      final counts = line
          .split(' ')
          .where((value) => RegExp(r'\d').hasMatch(value))
          .map((e) => int.parse(e))
          .toList();
      if (counts.isEmpty) continue;
      final moveCount = counts.first;
      final fromStack = crateStacks[counts[1]];
      final toStack = crateStacks[counts.last];

      final takenItems = <String>[];
      for (var i = 0; i < moveCount; i++) {
        takenItems.add(fromStack!.removeFirst());
      }

      for (var item in takenItems) {
        toStack!.addFirst(item);
      }
    }
  }
}

final crateStacks = <int, Queue<String>>{};
