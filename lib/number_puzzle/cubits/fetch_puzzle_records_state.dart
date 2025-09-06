part of 'fetch_puzzle_records_cubit.dart';

@freezed
class FetchPuzzleRecordsState with _$FetchPuzzleRecordsState {
  const factory FetchPuzzleRecordsState.initial() = _Initial;
  const factory FetchPuzzleRecordsState.loading() = _Loading;
  const factory FetchPuzzleRecordsState.loaded(List<PuzzleRecord> records) = _Loaded;
  const factory FetchPuzzleRecordsState.error(String message, String reason) = _Error;
}