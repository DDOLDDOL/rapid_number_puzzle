import 'package:flutter/material.dart';
import 'number_puzzle_tile.dart';

class NumberPuzzleBoard extends StatelessWidget {
  const NumberPuzzleBoard({
    super.key,
    required this.numbers,
    required this.currentPressedNumber,
    required this.gridSize,
    required this.onTilePressed,
  });

  final List<int> numbers;
  final int currentPressedNumber;
  final int gridSize;
  final Function(int) onTilePressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.9,
        maxHeight: MediaQuery.of(context).size.width * 0.9,
      ),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridSize,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: numbers.length,
          itemBuilder: (context, index) {
            final number = numbers[index];

            return NumberPuzzleTile(
              number: number,
              isRemoving: number <= currentPressedNumber,
              onPressed: () => onTilePressed(number),
            );
          },
        ),
      ),
    );
  }
}