class PuzzleRecord {
  const PuzzleRecord(
    this.id,
    this.rank,
    this.username,
    this.boardSize,
    this._clearTime,
    this._clearAt,
  );

  PuzzleRecord.fromJson(Map<String, dynamic> data)
    : id = data['id'] as String,
      rank = data['rank'] as int,
      username = data['username'] as String,
      boardSize = data['boardSize'] as int,
      _clearTime = data['clearTime'] as int,
      _clearAt = data['clearAt'] as String;

  final String id;
  final int rank;
  final String username;
  final int boardSize;
  final int _clearTime;
  final String _clearAt;

  DateTime? get clearAt => DateTime.tryParse(_clearAt);

  String get clearTimeText {
    final time = DateTime.fromMillisecondsSinceEpoch(_clearTime);

    final minutes = time.minute;
    final seconds = time.second.toString().padLeft(2, '0');
    final milliseconds = (time.millisecond ~/ 10).toString().padLeft(2, '0');
    return '$minutes:$seconds.$milliseconds';
  }
}
