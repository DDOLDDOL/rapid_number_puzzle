import 'package:flutter/material.dart';
import 'package:rapid_number_puzzle/common/utils/text_styles.dart';

class HomeMenuBottomSheetTile extends StatelessWidget {
  const HomeMenuBottomSheetTile({super.key, required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: Text(label, style: AppTextStyles.menu)),
      ),
    );
  }
}
