import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapid_number_puzzle/auth/blocs/auth_bloc.dart';
import 'package:rapid_number_puzzle/auth/screens/login_screen.dart';

class AuthGuard extends StatelessWidget {
  const AuthGuard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.hasError) return _ErrorView(errorMessage: state.errorMessage!);
        if (state.isFetchingUser) return _LoadingView();

        return state.user == null ? const LoginScreen() : Scaffold();
      },
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({super.key, required this.errorMessage});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
