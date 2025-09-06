import 'dart:async';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'number_puzzle_state.dart';

part 'number_puzzle_cubit.freezed.dart';

class NumberPuzzleCubit extends Cubit<NumberPuzzleState> {
  NumberPuzzleCubit({required int boardSize})
    : super(
        NumberPuzzleState(
          boardSize: boardSize,
          startTimeMillisEpoch: DateTime.now().millisecondsSinceEpoch,
        ),
      );

  Timer? _gameTimer;

  void initializeGame() {
    final numbers = List.generate(state.boardSize * state.boardSize, (index) => index + 1)
      ..shuffle(Random(state.startTimeMillisEpoch));

    emit(
      NumberPuzzleState(
        boardSize: state.boardSize,
        numbers: numbers,
        startTimeMillisEpoch: DateTime.now().millisecondsSinceEpoch,
        currentTimeMillisEpoch: DateTime.now().millisecondsSinceEpoch,
      ),
    );

    _startTimer();
  }

  void resetGame() {
    _clearTimer();
    initializeGame();
  }

  /// 타일을 탭했을 때의 이벤트를 감지합니다
  void pressNumberTile(int number) {
    if(number != state.pressedNumber + 1) return;

    if(number == state.boardSize * state.boardSize) _clearTimer();
    emit(state.copyWith(pressedNumber: number));
  }

  void _startTimer() {
    // 타이머 정지 안정성 확보
    if(_gameTimer?.isActive ?? false) _gameTimer?.cancel();

    _gameTimer = Timer.periodic(
      const Duration(milliseconds: 10),
          (_) => emit(
        state.copyWith(
          currentTimeMillisEpoch: state.currentTimeMillisEpoch == null
              ? null
              : state.currentTimeMillisEpoch! + 10,
        ),
      ),
    );
  }

  void _clearTimer() {
    if(_gameTimer?.isActive ?? false) _gameTimer?.cancel();
    _gameTimer = null;
  }

  @override
  Future<void> close() {
    _gameTimer?.cancel();
    return super.close();
  }
}
