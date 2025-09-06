import 'package:flutter/material.dart';
import 'package:rapid_number_puzzle/common/utils/palette.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.enabled = true,
    this.loadingWhen = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 24),
    this.borderRadiusValue = 12,
    this.elevation = 2,
    this.enabledColor,
    this.disabledColor,
    this.enabledButtonTextColor,
    this.disabledButtonTextColor,
    this.border = const BorderSide(width: 0, color: Colors.transparent),
    this.width = double.maxFinite,
    this.height = 50,
    this.animationDuration,
    this.buttonTextStyle,
  });

  final void Function()? onPressed;
  final bool enabled;
  final bool loadingWhen;
  final EdgeInsetsGeometry padding;
  final double borderRadiusValue;
  final double elevation;
  final Color? enabledColor;
  final Color? disabledColor;
  final Color? enabledButtonTextColor;
  final Color? disabledButtonTextColor;
  final BorderSide border;
  final double width;
  final double height;
  final Duration? animationDuration;
  final TextStyle? buttonTextStyle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        animationDuration: animationDuration,
        elevation: elevation,
        padding: padding,
        fixedSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadiusValue)),
          side: border,
        ),
        backgroundColor: enabledColor ?? Palette.primaryColor,
        disabledBackgroundColor: disabledColor ?? Colors.grey.shade400,
        foregroundColor: enabledButtonTextColor ?? Colors.white,
        disabledForegroundColor: disabledButtonTextColor ?? Colors.white,
      ),
      onPressed: enabled
          ? loadingWhen
                ? () {}
                : onPressed
          : null,
      child: loadingWhen ? _loadingIndicator : _child,
    );
  }

  Widget get _child {
    if (child is Text) {
      return Text((child as Text).data!, style: buttonTextStyle ?? _defaultStyle);
    }

    return child;
  }

  Widget get _loadingIndicator => const CircularProgressIndicator(color: Colors.white);

  TextStyle get _defaultStyle => TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: enabledButtonTextColor ?? Colors.white,
  );
}
