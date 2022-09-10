/// RegExp for Xtyle
abstract class XtyleRegExp {
  /// English + Digit
  static final RegExp alphanumeric = RegExp(r'[a-zA-Z0-9]');

  /// Korean
  static final RegExp korean = RegExp(r'[ㄱ-ㅣ가-힣]');

  /// English
  static final RegExp english = RegExp(r'[a-zA-Z]');

  /// Digit
  static final RegExp digit = RegExp(r'[0-9]');

  /// Emoji
  static final RegExp emoji = RegExp(
      r'[\u00a9\u00ae\u2000-\u3300\ud83c\ud000-\udfff\ud83d\ud000-\udfff\ud83e\ud000-\udfff]');
}
