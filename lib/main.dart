import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rapid_number_puzzle/auth/blocs/auth_bloc.dart';
import 'package:rapid_number_puzzle/auth/screens/login_screen.dart';
import 'package:rapid_number_puzzle/auth/services/oauth_service.dart';
import 'package:rapid_number_puzzle/firebase_options.dart';
import 'package:rapid_number_puzzle/home/screens/home_screen.dart';
import 'package:rapid_number_puzzle/number_puzzle/repository/number_puzzle_repository.dart';
import 'package:rapid_number_puzzle/number_puzzle/screens/number_puzzle_screen.dart';
import 'package:rapid_number_puzzle/number_puzzle/screens/select_level_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase 사용을 위해 초기화합니다
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Hive 사용을 위해 초기화합니다
  // await Hive.initFlutter();

  runApp(
    MultiProvider(
      providers: [Provider(create: (_) => OauthService.instance)],
      child: _RapidNumberPuzzleApp(),
    ),
  );
}

class _RapidNumberPuzzleApp extends StatelessWidget {
  const _RapidNumberPuzzleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return _MultiRepositoryProvider(
      child: _MultiBlocProvider(
        child: MaterialApp.router(
          theme: ThemeData(textTheme: GoogleFonts.lexendTextTheme()),
          debugShowCheckedModeBanner: false,
          routerConfig: GoRouter(
            initialLocation: '/',
            routes: [
              GoRoute(path: '/', builder: (_, __) => HomeScreen()),
              GoRoute(path: '/login', builder: (_, __) => LoginScreen()),
              GoRoute(path: '/select-level', builder: (_, __) => SelectLevelScreen()),
              GoRoute(
                path: '/number-puzzle',
                builder: (_, state) {
                  final boardSize = int.tryParse(state.uri.queryParameters['boardSize'] ?? '');
                  return NumberPuzzleScreen(boardSize: boardSize ?? 4);
                },
              ),
            ],
          ),
          builder: (context, child) {
            return child!;
          },
        ),
      ),
    );
  }
}

class _MultiRepositoryProvider extends StatelessWidget {
  const _MultiRepositoryProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider(create: (_) => NumberPuzzleRepository())],
      child: child,
    );
  }
}

class _MultiBlocProvider extends StatelessWidget {
  const _MultiBlocProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => AuthBloc(context.read<OauthService>()))],
      child: child,
    );
  }
}
