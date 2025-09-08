part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.oauthSignInRequested({required OauthPlatform oauthPlatform}) =
      _OauthSignInRequested;

  const factory AuthEvent.oauthSingOutRequested({required OauthPlatform oauthPlatform}) =
      _OauthSignOutRequested;

  const factory AuthEvent.updateUserRequested({required firebase_auth.User? user}) =
      _UpdateUserRequested;
}
