import 'package:flutter/widgets.dart';

import 'configuration.dart';

/// Util for Xtyle.
abstract class XtyleUtil {
  /// Substring match with regex.
  static List<String> chopStringWithRegex(String text, RegExp regExp) {
    final List<String> result = [];

    final matches = regExp.allMatches(text);
    for (RegExpMatch match in matches) {
      result.add(text.substring(match.start, match.end));
    }
    return result;
  }

  /// Intergrate multiple regexs into one super regex.
  static RegExp merge(List<RegExp> regexs) {
    List<String> codeRanges = [];

    List<String> patterns = regexs.map((x) {
      codeRanges.add(RegExp(r'(?<=^\[).*(?=\]$)').stringMatch(x.pattern) ?? '');
      return x.pattern.replaceAll(RegExp(r']$'), r'\s]+');
    }).toList();

    patterns.add('[^${codeRanges.join('')}]+');

    return RegExp(patterns.join(r'|'));
  }

  /// Build TextStyle based on source with XtyleConfig.
  static TextStyle textStyle({
    required String text,
    required TextStyle baseStyle,
    required XtyleConfig xtyleConfig,
  }) {
    for (RegExp regex in xtyleConfig.mapper.regexList) {
      if (regex.hasMatch(text)) {
        return baseStyle.merge(
            TextStyle(fontFamily: xtyleConfig.mapper.fontFamilyOf(regex)));
      }
    }
    if (xtyleConfig.defaultFontFamily != null) {
      return baseStyle
          .merge(TextStyle(fontFamily: xtyleConfig.defaultFontFamily));
    }
    return baseStyle;
  }
}
