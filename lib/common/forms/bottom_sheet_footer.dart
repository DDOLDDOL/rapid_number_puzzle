import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rapid_number_puzzle/common/utils/palette.dart';

class BottomSheetFooter extends StatelessWidget {
  const BottomSheetFooter({
    super.key,
    this.onSubmit,
    this.onCancel,
    this.submitButtonText = '확인',
    this.cancelButtonText = '취소',
    this.isSubmitButtonDisabled = false,
    this.isCancelButtonDisabled = false,
    this.footerWidget,
    this.autoPopOnSubmit = true,
  });

  final void Function()? onSubmit;
  final void Function()? onCancel;
  final String submitButtonText;
  final String cancelButtonText;
  final bool isSubmitButtonDisabled;
  final bool isCancelButtonDisabled;
  final Widget? footerWidget;
  final bool autoPopOnSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      // Stack 위에 올라가므로 width 값을 설정해줘야 보입니다
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(offset: const Offset(0, -4), blurRadius: 4, color: Colors.black.withAlpha(10)),
        ],
      ),
      child: Column(
        children: [
          Visibility(
            visible: footerWidget != null,
            child: Padding(padding: const EdgeInsets.only(bottom: 24), child: footerWidget),
          ),
          Row(
            children: [
              Visibility(
                visible: onCancel != null,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: _FooterButton(
                    backgroundColor: Palette.thirdColor,
                    foregroundColor: Palette.white,
                    buttonText: cancelButtonText,
                    onTap: onCancel,
                    disabled: isCancelButtonDisabled,
                  ),
                ),
              ),
              Expanded(
                child: Visibility(
                  visible: onSubmit != null,
                  child: _FooterButton(
                    backgroundColor: Palette.primaryColor,
                    foregroundColor: Palette.white,
                    buttonText: submitButtonText,
                    disabled: isSubmitButtonDisabled,
                    onTap: () {
                      if (autoPopOnSubmit) context.pop();
                      onSubmit?.call();
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FooterButton extends StatelessWidget {
  const _FooterButton({
    super.key,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.buttonText,
    required this.onTap,
    required this.disabled,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final String buttonText;
  final void Function()? onTap;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled ? null : onTap,
      child: Opacity(
        opacity: disabled ? 0.3 : 1.0,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(8)),
          child: Center(child: Text(buttonText)),
        ),
      ),
    );
  }
}
