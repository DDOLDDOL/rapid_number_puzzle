import 'package:flutter/material.dart';

class NumberPuzzleTimer extends StatelessWidget {
  const NumberPuzzleTimer({super.key, required this.timeText});

  final String timeText;

  @override
  Widget build(BuildContext context) {
    return Text(
      timeText,
      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }
}
