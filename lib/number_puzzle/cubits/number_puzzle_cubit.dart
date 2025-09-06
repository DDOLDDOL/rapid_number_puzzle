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

    // final tiles = numbers.asMap().entries.map((entry) {
    //   return NumberTile(
    //     id: entry.key,
    //     number: entry.value,
    //     row: entry.key ~/ gridSize,
    //     col: entry.key % gridSize,
    //     visible: true,
    //   );
    // }).toList();
    //
    // final startTime = DateTime.now();
    //
    // emit(
    //   state.copyWith(
    //     gridSize: gridSize,
    //     tiles: tiles,
    //     nextNumber: 1,
    //     startTime: startTime,
    //     elapsedTime: Duration.zero,
    //     gameStatus: const GameStatus.playing(),
    //     removingTiles: {},
    //     pressedTiles: {},
    //   ),
    // );
    //
    // _startTimer();
  }

  void resetGame() {
    _clearTimer();
    initializeGame();
  }

  /// 타일을 탭했을 때의 이벤트를 감지합니다
  void pressNumberTile(int number) {
    if(number == state.boardSize * state.boardSize) _clearTimer();
    if(number == state.pressedNumber + 1) emit(state.copyWith(pressedNumber: number));

    // final gameStatus = state.gameStatus;
    //
    // // 게임이 진행 중이고, 타일이 보이고, 올바른 순서인지 확인
    // if (gameStatus is! _Playing || !tile.visible || tile.number != state.nextNumber) {
    //   return;
    // }
    //
    // // 타일 제거 애니메이션 시작
    // emit(state.copyWith(removingTiles: {...state.removingTiles, tile.id}));
    //
    // // 200ms 후 실제 타일 제거
    // Future.delayed(const Duration(milliseconds: 200), () {
    //   if (!isClosed) {
    //     final updatedTiles = state.tiles
    //         .map((t) => t.id == tile.id ? t.copyWith(visible: false) : t)
    //         .toList();
    //
    //     final nextNumber = state.nextNumber + 1;
    //     final totalTiles = state.gridSize * state.gridSize;
    //
    //     // 게임 완료 확인
    //     if (nextNumber > totalTiles) {
    //       completeGame();
    //     } else {
    //       emit(
    //         state.copyWith(
    //           tiles: updatedTiles,
    //           nextNumber: nextNumber,
    //           removingTiles: state.removingTiles.where((id) => id != tile.id).toSet(),
    //         ),
    //       );
    //     }
    //   }
    // });
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
