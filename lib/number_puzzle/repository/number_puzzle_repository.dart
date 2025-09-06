import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rapid_number_puzzle/firebase_options.dart';
import 'package:rapid_number_puzzle/number_puzzle/models/puzzle_record.dart';

class NumberPuzzleRepository {
  NumberPuzzleRepository()
    : _database = FirebaseDatabase.instanceFor(
        app: Firebase.app(),
        databaseURL: 'https://mini-games-bf495-default-rtdb.asia-southeast1.firebasedatabase.app',
      ).ref().child('puzzleRecord');

  late final DatabaseReference _database;

  Future<List<PuzzleRecord>> fetchPuzzleRecords(int count) async {
    // await Future.delayed(Duration(seconds: 3));
    // throw Exception('Error Error');

    try {
      final snapshot = await _database.orderByChild('clearTime').limitToFirst(count).get();
      final records = snapshot.children.indexed
          .map((element) {
            final (index, child) = element;
            final id = child.key;
            final data = {
              'id': id,
              'rank': index+1,
              ...(child.value as Map?)?.cast<String, dynamic>() ?? {},
            };

            return PuzzleRecord.fromJson(data);
          })
          .toList();
      return records;
    } on Exception {
      rethrow;
    }
  }

  Future<void> savePuzzleRecords(int boardSize, int clearTimeDuration) async {
    try {
      await _database.push().set({
        'username': 'abc',
        'boardSize': boardSize,
        'clearTime': clearTimeDuration,
        'clearAt': DateTime.now().toString(),
      });
    } on Exception {
      rethrow;
    }
  }
}
