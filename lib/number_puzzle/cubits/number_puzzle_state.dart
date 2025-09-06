part of 'number_puzzle_cubit.dart';

@freezed
class NumberPuzzleState with _$NumberPuzzleState {
  const factory NumberPuzzleState({
    required int boardSize,
    @Default([]) List<int> numbers,
    @Default(0) int pressedNumber,
    int? startTimeMillisEpoch,
    int? currentTimeMillisEpoch,
  }) = _NumberPuzzleState;

  const NumberPuzzleState._();

  bool get isGameCleared => pressedNumber == boardSize * boardSize;

  int get clearTimeInMilliseconds {
    return startTimeMillisEpoch == null || currentTimeMillisEpoch == null
        ? 0
        : currentTimeMillisEpoch! - startTimeMillisEpoch!;
  }

  String get clearTimeText {
    final time = DateTime.fromMillisecondsSinceEpoch(clearTimeInMilliseconds);

    final minutes = time.minute;
    final seconds = time.second.toString().padLeft(2, '0');
    final milliseconds = (time.millisecond ~/ 10).toString().padLeft(2, '0');
    return '$minutes:$seconds.$milliseconds';
  }
}
