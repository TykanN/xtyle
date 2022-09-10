import 'regex.dart';

/// Map FontFamily to RegExp.
typedef XtyleMapper = Map<RegExp, String>;

/// Extension for XtyleMapper.
extension XtyleMapperHelper on XtyleMapper {
  List<RegExp> get regexList => keys.toList();
  List<String> get fontFamilyList => values.toList();

  String? fontFamilyOf(RegExp regExp) => this[regExp];
}

/// Configuration for Xtyle.
///
///
/// [mapper] : set XtyleMapper for your app.
///
/// [defaultFontFamily] : fontFamily for unmatched characters through mapper.
class XtyleConfig {
  final XtyleMapper mapper;
  final String? defaultFontFamily;

  const XtyleConfig({
    required this.mapper,
    this.defaultFontFamily,
  });

  XtyleConfig copyWith({
    XtyleMapper? mapper,
    String? defaultFontFamily,
  }) {
    return XtyleConfig(
      mapper: mapper ?? this.mapper,
      defaultFontFamily: defaultFontFamily ?? this.defaultFontFamily,
    );
  }

  /// You can generate XtyleConfing through builder pattern.
  factory XtyleConfig.builder() => const XtyleConfig(mapper: {});

  XtyleConfig setDefaultFontFamily(String defaultFontFamily) =>
      copyWith(defaultFontFamily: defaultFontFamily);

  XtyleConfig addMapping(RegExp regExp, String fontFamily) => copyWith(
        mapper: Map.fromEntries(
          [
            ...mapper.entries,
            MapEntry(regExp, fontFamily),
          ],
        ),
      );

  /// 한글은 지정 폰트 적용, 그 외 영문, 숫자, 특수문자 등은 기본 폰트 적용
  factory XtyleConfig.korean({
    required String fontFamilyKor,
    String? defaultFontFamily,
    bool showDebugLog = false,
  }) =>
      XtyleConfig(
        mapper: {XtyleRegExp.korean: fontFamilyKor},
        defaultFontFamily: defaultFontFamily,
      );
}
