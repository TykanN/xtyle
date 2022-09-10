import 'package:flutter/material.dart';
import 'package:xtyle/xtyle.dart';
import 'util.dart';

class XtyleTextController extends TextEditingController {
  XtyleTextController({String? text}) : super(text: text);

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    List<String> list = XtyleUtil.chopStringWithRegex(text, Xtyle.regExp);

    List<InlineSpan> spans = list
        .map(
          (text) => TextSpan(
            text: text,
            style: XtyleUtil.textStyle(
              text: text,
              baseStyle: style ?? const TextStyle(),
              xtyleConfig: Xtyle.config,
            ),
          ),
        )
        .toList();
    return TextSpan(children: spans, style: const TextStyle(height: 1.0));
  }
}
