import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rapid_number_puzzle/common/utils/palette.dart';
import 'package:rapid_number_puzzle/number_puzzle/cubits/fetch_puzzle_records_cubit.dart';
import 'package:rapid_number_puzzle/number_puzzle/models/puzzle_record.dart';
import 'package:rapid_number_puzzle/number_puzzle/repository/number_puzzle_repository.dart';

class ClearResultLeaderBoard extends StatelessWidget {
  const ClearResultLeaderBoard({super.key, required this.boardSize, required this.clearTimeText});

  final int boardSize;
  final String clearTimeText;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FetchPuzzleRecordsCubit(context.read<NumberPuzzleRepository>())
            ..fetchPuzzleRecords(boardSize, 5),
      child: _Body(clearTimeText: clearTimeText),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({super.key, required this.clearTimeText});

  final String clearTimeText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Palette.secondaryColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.yellow, width: 2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Game Clear!',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.yellow),
          ),
          SizedBox(height: 20),
          Text(
            clearTimeText,
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 40),
          const _PuzzleRecordListView(),
        ],
      ),
    );
  }
}

class _PuzzleRecordListView extends StatelessWidget {
  const _PuzzleRecordListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchPuzzleRecordsCubit, FetchPuzzleRecordsState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: SizedBox.shrink,
          loading: () => const Center(child: CircularProgressIndicator()),
          loaded: (records) => ListView(
            shrinkWrap: true,
            children: records.map((record) => _PuzzleRecordListTile(record: record)).toList(),
          ),
          error: (message, reason) {
            return SizedBox.shrink();
          },
        );
      },
    );
  }
}

class _PuzzleRecordListTile extends StatelessWidget {
  const _PuzzleRecordListTile({super.key, required this.record});

  final PuzzleRecord record;

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey();
    printRenderedWidgetSize(key);

    return DefaultTextStyle(
      style: GoogleFonts.lexend(color: Palette.white, fontSize: 18, fontWeight: FontWeight.w600),
      child: Row(
        spacing: 8,
        children: [
          SizedBox(
            width: 21,
            child: Text(switch (record.rank) {
              1 => '🥇',
              2 => '🥈',
              3 => '🥉',
              _ => '',
            }),
          ),
          Text('${record.rank}'), // 1~5까지만 표기하므로 길이에 constraint를 주지 않습니다
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(record.username, overflow: TextOverflow.ellipsis),
            ),
          ),
          Container(width: 68, alignment: Alignment.centerLeft, child: Text(key: key, record.clearTimeText)),
        ],
      ),
    );
  }

  Future<void> printRenderedWidgetSize(GlobalKey key) async {
    await Future.delayed(const Duration(milliseconds: 100));

    final widget = key.currentContext?.findRenderObject() as RenderBox?;
    print('width: ${widget?.size.width}');
    print('height: ${widget?.size.height}');
  }
}

class FireworksPainter extends CustomPainter {
  final double progress;
  final List<Firework> fireworks;

  FireworksPainter(this.progress) : fireworks = _generateFireworks();

  static List<Firework> _generateFireworks() {
    final random = Random();
    return List.generate(8, (index) {
      return Firework(
        x: random.nextDouble(),
        y: 0.3 + random.nextDouble() * 0.4,
        color: Color.fromRGBO(random.nextInt(255), random.nextInt(255), random.nextInt(255), 1),
        delay: index * 0.1,
      );
    });
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (final firework in fireworks) {
      firework.paint(canvas, size, progress);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class Firework {
  final double x;
  final double y;
  final Color color;
  final double delay;

  Firework({required this.x, required this.y, required this.color, required this.delay});

  void paint(Canvas canvas, Size size, double progress) {
    final adjustedProgress = ((progress - delay) / (1 - delay)).clamp(0.0, 1.0);
    if (adjustedProgress <= 0) return;

    final center = Offset(x * size.width, y * size.height);
    final radius = 50 * adjustedProgress;
    final particleCount = 12;

    final paint = Paint()
      ..color = color.withOpacity((1 - adjustedProgress).clamp(0.0, 1.0))
      ..style = PaintingStyle.fill;

    for (int i = 0; i < particleCount; i++) {
      final angle = (i / particleCount) * 2 * pi;
      final particleRadius = radius * (0.8 + 0.4 * sin(adjustedProgress * pi));
      final particleCenter = Offset(
        center.dx + cos(angle) * particleRadius,
        center.dy + sin(angle) * particleRadius,
      );

      canvas.drawCircle(particleCenter, 3, paint);
    }
  }
}
