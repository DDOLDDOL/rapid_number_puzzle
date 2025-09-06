import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeMenuBottomSheetTile extends StatelessWidget {
  const HomeMenuBottomSheetTile({super.key, required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pop(); // ModalRoute pop (PageRoute X)
        onTap?.call();
      },
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.all(16),
        child: Center(
          child: Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
