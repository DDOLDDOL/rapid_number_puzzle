import 'package:flutter/material.dart';
import 'package:rapid_number_puzzle/auth/screens/login_screen.dart';
import 'package:rapid_number_puzzle/auth/widgets/auth_guard.dart';
import 'package:rapid_number_puzzle/number_puzzle/screens/select_level_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthGuard(home: const SelectLevelScreen(), login: LoginScreen());
  }
}
