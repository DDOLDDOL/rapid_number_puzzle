part of 'save_puzzle_record_cubit.dart';

@freezed
class SavePuzzleRecordState with _$SavePuzzleRecordState {
  const factory SavePuzzleRecordState.initial() = _Initial;
  const factory SavePuzzleRecordState.loading() = _Loading;
  const factory SavePuzzleRecordState.success() = _Success;
  const factory SavePuzzleRecordState.error(String message, String reason) = _Error;
}