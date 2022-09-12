import 'package:flutter/widgets.dart';
import 'dart:ui' as ui;

import 'package:xtyle/xtyle.dart';

import 'util.dart';

/// ### English
/// "Xtyle" means `multilingual-style`.
///
/// Multiple fonts can be applied according to the character type.
///
/// ### Korean
/// "Xtyle"는 `multilingual-style`를 뜻합니다.
///
/// 문자 유형에 따라 여러 글꼴이 적용될 수 있다.
class XtyleText extends StatelessWidget {
  /// The text to display.
  final String? text;

  /// The text to display as a [InlineSpan].
  final InlineSpan? span;

  /// If non-null, the style to use for this text.
  final TextStyle? style;

  /// {@macro flutter.painting.textPainter.strutStyle}
  final StrutStyle? strutStyle;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// The directionality of the text.
  final TextDirection? textDirection;

  /// Used to select a font when the same Unicode character can
  /// be rendered differently, depending on the locale.
  final Locale? locale;

  /// Whether the text should break at soft line breaks.
  final bool? softWrap;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  /// The number of font pixels for each logical pixel.
  final double? textScaleFactor;

  /// An optional maximum number of lines for the text to span, wrapping if necessary.
  /// If the text exceeds the given number of lines, it will be truncated according
  /// to [overflow].
  final int? maxLines;

  /// {@macro flutter.widgets.Text.semanticsLabel}
  final String? semanticsLabel;

  /// {@macro flutter.painting.textPainter.textWidthBasis}
  final TextWidthBasis? textWidthBasis;

  /// {@macro dart.ui.textHeightBehavior}
  final ui.TextHeightBehavior? textHeightBehavior;

  /// The color to use when painting the selection.
  final Color? selectionColor;

  /// ### English
  /// Create a multilingual-styled text widget.
  ///
  /// The [text] parameter must not be null.
  ///
  /// All other parameters except [style] are used the same as the [Text] widget.
  ///
  /// ### Korean
  /// 다국어로 동기화된 텍스트 위젯을 생성합니다.
  ///
  /// [text] 파라미터는 null일 수 없습니다.
  ///
  /// [style]을 제외한 다른 모든 파라미터는 [Text] 위젯과 동일하게 사용됩니다.
  const XtyleText(
    this.text, {
    Key? key,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  })  : assert(
          text != null,
          'A non-null String must be provided to a XtyleText widget',
        ),
        span = null,
        super(key: key);

  /// Create a multilingual-styled text widget.
  ///
  /// The [span] parameter must not be null.
  ///
  /// All other parameters except [style] are used the same as the Text widget.
  const XtyleText.rich(
    this.span, {
    Key? key,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  })  : assert(
          span != null,
          'A non-null TextSpan must be provided to a XtyleText.rich widget.',
        ),
        text = null,
        super(key: key);

  // Generate span.
  List<InlineSpan> _build() {
    if (span != null) {
      return _buildSpanFromRich(TextSpan(children: [span!]));
    }
    return _buildSpan(text!);
  }

  // Default text
  @protected
  List<InlineSpan> _buildSpan(String source) {
    List<String> list = XtyleUtil.chopStringWithRegex(source, Xtyle.regExp);

    return list
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
  }

  /// Rich text
  @protected
  List<InlineSpan> _buildSpanFromRich(TextSpan textSpan) {
    if (textSpan.children == null) {
      return [TextSpan(text: textSpan.text)];
    }
    List<InlineSpan> result = [];
    for (InlineSpan span in textSpan.children!) {
      List<String> choppedString =
          XtyleUtil.chopStringWithRegex(span.toPlainText(), Xtyle.regExp);
      List<InlineSpan> styledString = choppedString
          .map(
            (text) => TextSpan(
              text: text,
              style: XtyleUtil.textStyle(
                text: text,
                baseStyle:
                    span.style ?? textSpan.style ?? style ?? const TextStyle(),
                xtyleConfig: Xtyle.config,
              ),
            ),
          )
          .toList();
      result.addAll(styledString);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final InlineSpan textSpan = TextSpan(children: _build());
    return Text.rich(
      textSpan,
      style: style,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );
  }
}
