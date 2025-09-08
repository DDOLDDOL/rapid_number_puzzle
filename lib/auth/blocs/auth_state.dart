part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    firebase_auth.User? user,
    @Default(false) bool isFetchingUser,
    String? errorMessage,
  }) = _AuthState;

  const AuthState._();

  // 에러 발생
  bool get hasError => errorMessage != null;

  // 로그인 완료
  bool get authorized => user != null;

  // 로그아웃 완료
  bool get unauthorized => user == null && !hasError && !isFetchingUser;

}
