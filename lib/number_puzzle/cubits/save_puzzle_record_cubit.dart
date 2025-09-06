import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rapid_number_puzzle/common/utils/parse_firebase_error_message.dart';
import 'package:rapid_number_puzzle/number_puzzle/repository/number_puzzle_repository.dart';

part 'save_puzzle_record_state.dart';

part 'save_puzzle_record_cubit.freezed.dart';

class SavePuzzleRecordCubit extends Cubit<SavePuzzleRecordState> {
  SavePuzzleRecordCubit(this._repository) : super(const SavePuzzleRecordState.initial());

  final NumberPuzzleRepository _repository;

  Future<void> savePuzzleRecord(int boardSize, int clearTimeDuration) async {
    emit(const SavePuzzleRecordState.loading());

    try {
      await _repository.savePuzzleRecords(boardSize, clearTimeDuration);
      emit(const SavePuzzleRecordState.success());
    } on FirebaseException catch (error) {
      emit(SavePuzzleRecordState.error('기록 저장 실패', parseFirebaseErrorMessage(error)));
    }on Exception catch (error) {
      emit(
        SavePuzzleRecordState.error(
          '기록 저장 실패',
          error.toString().split('Exception: ').lastOrNull ?? '',
        ),
      );
    }
  }
}
