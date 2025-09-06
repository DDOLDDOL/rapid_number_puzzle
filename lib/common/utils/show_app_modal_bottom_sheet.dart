import 'package:flutter/material.dart';
import 'package:rapid_number_puzzle/common/forms/bottom_sheet_form.dart';

Future<T?> showAppModalBottomSheet<T>({
  required BuildContext context,
  required Widget body,
  String? title,
}) async {
  return showModalBottomSheet<T>(
    context: context,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
    builder: (context) =>
        BottomSheetForm(title: title, body: body, centerTitle: true, autoPopOnSubmit: true),
  );
}
