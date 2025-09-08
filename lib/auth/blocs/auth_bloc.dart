import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rapid_number_puzzle/auth/services/oauth_service.dart';

import '../utils/enums.dart';

part 'auth_event.dart';

part 'auth_state.dart';

part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  /// Firebase Auth를 통해 로그인/로그아웃을 하고,
  /// 해당 Oauth의 결과로 나온 유저로 앱의 자동 로그인 및 Routing & Navigating을 수행합니다
  AuthBloc(this._oauthService) : super(const AuthState(isFetchingUser: true)) {
    on<_OauthSignInRequested>(_onOauthSignInRequested);
    on<_OauthSignOutRequested>(_onOauthSignOutRequested);
    on<_UpdateUserRequested>(_onUpdateUserRequested);

    _userOauthSubscription = _oauthService.watchUser().listen(
      (user) => add(AuthEvent.updateUserRequested(user: user)),
    );
  }

  final OauthService _oauthService;
  late final StreamSubscription<firebase_auth.User?> _userOauthSubscription;

  void _onOauthSignInRequested(_OauthSignInRequested event, Emitter<AuthState> emit) {
    _oauthService.signIn(event.oauthPlatform);
  }

  void _onOauthSignOutRequested(_OauthSignOutRequested event, Emitter<AuthState> emit) {
    _oauthService.signOut(event.oauthPlatform);
  }

  void _onUpdateUserRequested(_UpdateUserRequested event, Emitter<AuthState> emit) {
    if (event.user == null) return emit(const AuthState()); // 로그아웃 상태
    emit(AuthState(user: event.user!)); // 로그인 상태
  }

  @override
  Future<void> close() {
    _userOauthSubscription.cancel();
    return super.close();
  }
}
