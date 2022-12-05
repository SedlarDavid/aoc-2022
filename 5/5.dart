import 'dart:collection';
import 'dart:io';

Future<void> main() async {
  final input = new File('5/input.txt');

  processInput(input);
}

void processInput(File input) {
  var lines = input.readAsLinesSync().toList(growable: false);

  var isStep = false;
  for (var line in lines) {
    if (line.isEmpty) {
      isStep = true;
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

      print(crateStacks);
    } else {
      //process step
    }
  }
}

final crateStacks = <int, Queue<String>>{};
