import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapid_number_puzzle/common/utils/palette.dart';
import 'package:rapid_number_puzzle/number_puzzle/cubits/number_puzzle_cubit.dart';
import 'package:rapid_number_puzzle/number_puzzle/cubits/save_puzzle_record_cubit.dart';
import 'package:rapid_number_puzzle/number_puzzle/repository/number_puzzle_repository.dart';
import 'package:rapid_number_puzzle/number_puzzle/widgets/clear_result_leader_board.dart';
import 'package:rapid_number_puzzle/number_puzzle/widgets/number_puzzle_board.dart';
import 'package:rapid_number_puzzle/number_puzzle/widgets/number_puzzle_timer.dart';

class NumberPuzzleScreen extends StatelessWidget {
  const NumberPuzzleScreen({super.key, required this.boardSize});

  final int boardSize;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NumberPuzzleCubit(boardSize: boardSize)..initializeGame()),
        BlocProvider(create: (_) => SavePuzzleRecordCubit(context.read<NumberPuzzleRepository>())),
      ],
      child: const _View(),
    );
  }
}

class _View extends StatefulWidget {
  const _View({super.key});

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> with TickerProviderStateMixin {
  late AnimationController _completionController;
  late AnimationController _fireworksController;
  late Animation<double> _completionAnimation;
  late Animation<double> _fireworksAnimation;

  Map<int, AnimationController> tileAnimations = {};
  Set<int> removingTiles = {};

  @override
  void initState() {
    super.initState();
    _completionController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    _fireworksController = AnimationController(duration: Duration(milliseconds: 2000), vsync: this);

    _completionAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _completionController, curve: Curves.elasticOut));

    _fireworksAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fireworksController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _completionController.dispose();
    _fireworksController.dispose();
    tileAnimations.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a2e),
      body: SafeArea(
        child: BlocConsumer<NumberPuzzleCubit, NumberPuzzleState>(
          listenWhen: (_, current) => current.isGameCleared,
          listener: (context, state) {
            context.read<SavePuzzleRecordCubit>().savePuzzleRecord(
              state.boardSize,
              state.clearTimeInMilliseconds,
            );
          },
          builder: (context, state) {
            return Stack(
              children: [
                Column(
                  children: [
                    _Header(isGameCleared: state.isGameCleared, clearTimeText: state.clearTimeText),
                    Expanded(
                      child: Center(
                        child: NumberPuzzleBoard(
                          numbers: state.numbers,
                          gridSize: state.boardSize,
                          currentPressedNumber: state.pressedNumber,
                          onTilePressed: context.read<NumberPuzzleCubit>().pressNumberTile,
                        ),
                      ),
                    ),

                    _ResetButton(onPressed: context.read<NumberPuzzleCubit>().resetGame),
                  ],
                ),

                if (state.isGameCleared)
                  Positioned.fill(
                    child: Center(
                      child: ClearResultLeaderBoard(
                        boardSize: state.boardSize,
                        clearTimeText: state.clearTimeText,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({super.key, required this.isGameCleared, required this.clearTimeText});

  final bool isGameCleared;
  final String clearTimeText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 12),
                child: BackButton(color: Colors.white),
              ),
            ),
          ),
          if (!isGameCleared) NumberPuzzleTimer(timeText: clearTimeText),
          const Spacer(),
        ],
      ),
    );
  }
}

class _ResetButton extends StatelessWidget {
  const _ResetButton({super.key, this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF16213e),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          Icon(Icons.refresh_outlined, color: Palette.white, size: 20),
          const Text('Retry', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
