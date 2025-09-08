import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rapid_number_puzzle/auth/blocs/auth_bloc.dart';

class AuthGuard extends StatelessWidget {
  const AuthGuard({super.key, required this.home, required this.login});

  final Widget home;
  final Widget login;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (previous, current) => previous.user != current.user,
      listener: (context, state) {
        context.go('/');
      },
      builder: (context, state) {
        // user != null인지를 우선 보고, null이 아니라면 home으로 이동
        if (state.authorized) return home;

        // user == null && errorMessage != null인 상황에서 에러 뷰 호출
        if (state.hasError) return _ErrorView(errorMessage: state.errorMessage!);

        // user == null && !hasError && !isFetchingUser인 상황은 로그아웃 후라고 판단 -> 로그아웃으로 이동
        if (state.unauthorized) return login;

        // 그 외에는 로딩 상황으로 간주하여 로딩 뷰 노출
        return const _LoadingView();
      },
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({super.key, required this.errorMessage});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(errorMessage));
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const Center(child: CircularProgressIndicator()));
  }
}
