import 'package:flutter/material.dart';

class NumberPuzzleTile extends StatefulWidget {
  const NumberPuzzleTile({
    Key? key,
    required this.number,
    required this.isRemoving,
    required this.onPressed,
  }) : super(key: key);

  final int number;
  final bool isRemoving;
  final VoidCallback onPressed;

  @override
  State<NumberPuzzleTile> createState() => _NumberPuzzleTileState();
}

class _NumberPuzzleTileState extends State<NumberPuzzleTile> with SingleTickerProviderStateMixin {
  late final AnimationController _removeController;
  late final Animation<double> _removeAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();

    _removeController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _removeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _removeController, curve: Curves.easeInBack),
    );
  }

  @override
  void didUpdateWidget(NumberPuzzleTile oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isRemoving && !oldWidget.isRemoving) _removeController.forward();
  }

  @override
  void dispose() {
    _removeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isRemoving
        ? AnimatedBuilder(
            animation: _removeAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _removeAnimation.value,
                child: _TileBody(
                  onTapDown: (_) => setState(() => _isPressed = true),
                  onTapUp: (_) {
                    setState(() => _isPressed = false);
                    widget.onPressed();
                  },
                  onTapCancel: () => setState(() => _isPressed = false),
                  isPressed: _isPressed,
                  number: widget.number,
                ),
              );
            },
          )
        : _TileBody(
            onTapDown: (_) => setState(() => _isPressed = true),
            onTapUp: (_) {
              setState(() => _isPressed = false);
              widget.onPressed();
            },
            onTapCancel: () => setState(() => _isPressed = false),
            isPressed: _isPressed,
            number: widget.number,
          );
  }
}

class _AnimationBuilder extends StatelessWidget {
  const _AnimationBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


class _TileBody extends StatelessWidget {
  const _TileBody({
    super.key,
    required this.onTapDown,
    required this.onTapUp,
    required this.onTapCancel,
    required this.isPressed,
    required this.number,
  });

  final void Function(TapDownDetails)? onTapDown;
  final void Function(TapUpDetails)? onTapUp;
  final void Function()? onTapCancel;
  final bool isPressed;
  final int number;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        transform: Matrix4.identity()..scale(isPressed ? 0.95 : 1.0),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0f3460), Color(0xFF16213e)],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isPressed ? Colors.yellow : Colors.white.withOpacity(0.3),
            width: isPressed ? 3 : 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: isPressed ? 8 : 4,
              offset: Offset(0, isPressed ? 4 : 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            number.toString(),
            // '${widget.tile.number}',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
