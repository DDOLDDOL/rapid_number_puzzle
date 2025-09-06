import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rapid_number_puzzle/common/utils/parse_firebase_error_message.dart';
import 'package:rapid_number_puzzle/number_puzzle/models/puzzle_record.dart';
import 'package:rapid_number_puzzle/number_puzzle/repository/number_puzzle_repository.dart';

part 'fetch_puzzle_records_state.dart';

part 'fetch_puzzle_records_cubit.freezed.dart';

class FetchPuzzleRecordsCubit extends Cubit<FetchPuzzleRecordsState> {
  FetchPuzzleRecordsCubit(this._repository) : super(const FetchPuzzleRecordsState.initial());

  final NumberPuzzleRepository _repository;

  Future<void> fetchPuzzleRecords(int boardSize, int count) async {
    emit(const FetchPuzzleRecordsState.loading());

    try {
      final records = await _repository.fetchPuzzleRecords(boardSize, count);
      emit(FetchPuzzleRecordsState.loaded(records));
    } on FirebaseException catch (error) {
      emit(FetchPuzzleRecordsState.error('기록 조회 실패', parseFirebaseErrorMessage(error)));
    } on Exception catch (error) {
      emit(
        FetchPuzzleRecordsState.error(
          '기록 조회 실패',
          error.toString().split('Exception: ').lastOrNull ?? '',
        ),
      );
    }
  }
}
