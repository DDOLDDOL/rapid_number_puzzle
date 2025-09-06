import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rapid_number_puzzle/auth/blocs/auth_bloc.dart';

class AuthGuard extends StatelessWidget {
  const AuthGuard({super.key, required this.home, required this.login,});

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
        if (state.hasError) return _ErrorView(errorMessage: state.errorMessage!);
        // if (state.isFetchingUser) return _LoadingView();

        return state.user == null ? login : home;
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
    return const Center(child: CircularProgressIndicator());
  }
}
