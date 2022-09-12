[![pub package](https://img.shields.io/pub/v/xtyle.svg?label=xtyle&color=blue)](https://pub.dev/packages/xtyle_text)
[![likes](https://img.shields.io/pub/likes/xtyle.svg)](https://pub.dev/packages/xtyle/score)



[![English](https://img.shields.io/badge/Language-English-9cf?style=for-the-badge)](README.md)
<!-- [![Korean](https://img.shields.io/badge/Language-Korean-9cf?style=for-the-badge)](README.ko-kr.md) -->

# Xtyle

`Xtyle` means "**Multilingual-style**".

As a design requirement, there are many requests for different fonts in English and native language.

This package allows you to use different fonts for different types of characters, including English, numbers, alphanumeric characters, Korean, emoji, and so on.

<div><img src="https://github.com/TykanN/xtyle/blob/master/assets/screenshot.png?raw=true" width="375"></div>

<div><img src="https://github.com/TykanN/xtyle/blob/master/assets/example.gif?raw=true" width="375"></div>

## Getting Started

Add `xtyle` to your pubspec.yaml file:
```yaml
dependencies:
  xtyle:
```

## Example

```dart
import 'package:xtyle/xtyle.dart';

// initialize Xtyle before runApp() in main.dart
void main() {
...
  Xtyle.init(
    configuration: XtyleConfig.korean(
      fontFamilyKor: 'SpoqaHanSansNeo', // FontFamily for Korean
      defaultFontFamily: 'DancingScript', // Default FontFamily
    ),
  );
  runApp(const MyApp());
}

// Just use XtyleText Widget instead of Text Widget
XtyleText(
    'Hello안녕123한글과English',
    style: Theme.of(context).textTheme.bodyMedium,
),
```

## Supported Lauguages for xtyle-mapping
* Korean
* English (+Upper/Lower case)
* Digit
* AlphaNumeric (English + Digit)
* Emoji
* ...(other languages will be supported. Create issue or PR with regex.)