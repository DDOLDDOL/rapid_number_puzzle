import 'package:flutter/material.dart';
import 'package:rapid_number_puzzle/common/forms/bottom_sheet_footer.dart';
import 'package:rapid_number_puzzle/common/forms/bottom_sheet_header.dart';

class BottomSheetForm extends StatelessWidget {
  const BottomSheetForm({
    super.key,
    required this.body,
    this.title,
    this.bodyHeight,
    this.footerWidget,
    this.isSubmitButtonDisabled = false,
    this.isCancelButtonDisabled = false,
    this.leading,
    this.titlePadValue = 0,
    this.centerTitle = false,
    this.showFooter = true,
    this.autoPopOnSubmit = true,
    this.submitButtonText = '확인',
    this.cancelButtonText = '취소',
    this.onSubmit,
    this.onCancel,
    this.onClose,
    this.onTapBackButton,
  });

  final Widget body;
  final String? title;
  final double? bodyHeight;
  final Widget? footerWidget;
  final Widget? leading;
  final bool centerTitle;
  final double titlePadValue;
  final bool showFooter;
  final bool autoPopOnSubmit;
  final String submitButtonText;
  final String cancelButtonText;
  final bool isSubmitButtonDisabled;
  final bool isCancelButtonDisabled;
  final void Function()? onSubmit;
  final void Function()? onCancel;
  final void Function()? onClose; // 닫힘 버튼 클릭 시, trailing
  final void Function()? onTapBackButton; // 뒤로 가기 버튼 클릭 시, leading

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if(title != null)
          BottomSheetHeader(
            title: title!,
            leading: leading,
            centerTitle: centerTitle,
            titlePadValue: titlePadValue,
            onClose: onClose,
            onTapBackButton: onTapBackButton,
          ),
          SizedBox(
            height: bodyHeight == null ? null : bodyHeight! + 84,
            child: Column(
              children: [
                bodyHeight == null ? body : Expanded(child: body),
                Visibility(
                  visible: showFooter,
                  child: BottomSheetFooter(
                    key: key,
                    onSubmit: onSubmit,
                    onCancel: onCancel,
                    submitButtonText: submitButtonText,
                    cancelButtonText: cancelButtonText,
                    isSubmitButtonDisabled: isSubmitButtonDisabled,
                    isCancelButtonDisabled: isCancelButtonDisabled,
                    footerWidget: footerWidget,
                    autoPopOnSubmit: autoPopOnSubmit,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
