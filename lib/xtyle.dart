library xtyle;

import 'src/configuration.dart';
import 'src/util.dart';

export 'src/configuration.dart';
export 'src/regex.dart';
export 'src/text.dart';
export 'src/text_controller.dart';

/// Global Xtyle Instance.
// ignore: non_constant_identifier_names
final XtyleInterface Xtyle = _XtyleImpl();

/// XtyleInterface
abstract class XtyleInterface {
  late XtyleConfig config;
  late RegExp regExp;
  void init({required XtyleConfig configuration});
}

/// Implement of XtyleInterface
class _XtyleImpl implements XtyleInterface {
  _XtyleImpl();

  @override
  late XtyleConfig config;

  @override
  late RegExp regExp;

  @override
  void init({required XtyleConfig configuration}) {
    config = configuration;
    regExp = XtyleUtil.merge(configuration.mapper.regexList);
  }
}
