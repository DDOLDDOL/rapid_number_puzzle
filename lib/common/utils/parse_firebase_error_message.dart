import 'package:firebase_core/firebase_core.dart';

String parseFirebaseErrorMessage(FirebaseException error) {
  return switch (error.code) {
    'permission-denied' => '접근 권한이 없습니다',
    'network-error' => '네트워크 연결을 확인해주세요',
    'disconnected' => '서버와 연결이 끊어졌습니다',
    _ => '알 수 없는 오류가 발생했습니다',
  };
}