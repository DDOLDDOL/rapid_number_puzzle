part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    firebase_auth.User? user,
    @Default(false) bool isFetchingUser,
    String? errorMessage,
  }) = _AuthState;

  const AuthState._();

  bool get hasError => errorMessage != null;
}
