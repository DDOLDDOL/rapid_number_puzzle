import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rapid_number_puzzle/auth/utils/enums.dart';

class OauthService {
  /// Signleton
  OauthService._()
    : _googleSignIn = GoogleSignIn.instance..initialize(),
      _firebaseAuth = firebase_auth.FirebaseAuth.instance;

  static final _instance = OauthService._();

  static OauthService get instance => _instance;

  // Google Oauth 클라이언트
  late final GoogleSignIn _googleSignIn;

  // Firebase Auth 클라이언트
  late final firebase_auth.FirebaseAuth _firebaseAuth;

  Future<void> signIn(OauthPlatform oauthPlatform) async {
    final credential = switch (oauthPlatform) {
      OauthPlatform.google => await _getCredentialByGoogleSignIn(),
    };

    if (credential == null) return;

    // TODO: 로그인 시 에러 핸들링이 필요합니다
    _firebaseAuth.signInWithCredential(credential);
  }

  /// 앱에서의 로그아웃을 진행합니다
  void signOut(OauthPlatform oauthPlatform) {
    _firebaseAuth.signOut();
    _signOutOauth(oauthPlatform);
  }

  /// Firebase Auth의 User를 감시하는 Stream 입니다
  Stream<firebase_auth.User?> watchUser() => _firebaseAuth.userChanges();

  // 구글 로그인을 진행해 OauthCredential을 획득합니다
  Future<firebase_auth.OAuthCredential?> _getCredentialByGoogleSignIn() async {
    try {
      final googleAccount = await _googleSignIn.authenticate();
      final googleAuthResult = googleAccount.authentication;

      return firebase_auth.GoogleAuthProvider.credential(idToken: googleAuthResult?.idToken);
    } on GoogleSignInException catch (error) {
      if (error.code == GoogleSignInExceptionCode.canceled) return null;

      debugPrint('Error occurred on google login $error');
      return null;
    } on Exception catch (error) {
      debugPrint('Error occurred on google login $error');
      return null;
    }
  }

  // Oauth 클라이언트 로그아웃을 진행합니다
  void _signOutOauth(OauthPlatform oauthPlatform) async {
    return switch (oauthPlatform) {
      OauthPlatform.google => await _googleSignIn.signOut(),
    };
  }
}
