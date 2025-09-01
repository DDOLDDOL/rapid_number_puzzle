part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.oauthSignInRequested({required String oauthProvider,}) =
      _OauthSignInRequested;

  const factory AuthEvent.oauthSingOutRequested({required String oauthProvider,}) =
      _OauthSignOutRequested;

  const factory AuthEvent.updateUserRequested({required firebase_auth.User? user,}) =
      _UpdateUserRequested;
}
