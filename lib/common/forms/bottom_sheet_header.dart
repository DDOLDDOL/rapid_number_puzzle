import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomSheetHeader extends StatelessWidget {
  const BottomSheetHeader({
    super.key,
    required this.title,
    required this.leading,
    required this.centerTitle,
    required this.titlePadValue,
    required this.onClose,
    required this.onTapBackButton,
  });

  final String title;
  final bool centerTitle;
  final double titlePadValue;
  final Widget? leading;
  final void Function()? onClose;
  final void Function()? onTapBackButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        borderRadius: BorderRadiusGeometry.vertical(top: Radius.circular(24)),
        border: Border(bottom: BorderSide(width: 0.75, color: Color(0xFFDEDEDE))),
      ),
      child: Row(
        spacing: titlePadValue,
        children: [
          // onTapBackButton이 전달될 때만 leading에 BackButton을 배치하고
          // leading보다 우선시 됩니다
          onTapBackButton == null
              ? leading ?? SizedBox(width: centerTitle ? 24 : 0)
              : _BackButton(onTap: onTapBackButton),
          Expanded(
            child: Align(
              alignment: centerTitle ? Alignment.center : Alignment.centerLeft,
              child: Text(title, style: _titleStyle),
            ),
          ),
          GestureDetector(
            onTap: context.pop,
            child: const Icon(Icons.close_outlined, size: 24, color: Colors.black),
          ),
        ],
      ),
    );
  }

  TextStyle get _titleStyle =>
      TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black);
}

class _BackButton extends StatelessWidget {
  const _BackButton({super.key, required this.onTap});

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 24,
        height: 24,
        child: Center(
          child: Transform.scale(
            scale: 5 / 6,
            // OS별로 알맞는 BackButton 노출
            child: const BackButton().icon,
          ),
        ),
      ),
    );
  }
}
