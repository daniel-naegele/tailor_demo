import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';
import 'package:flutter/material.dart';

part 'test.tailor.dart';

@tailorMixin
class TestTheme extends ThemeExtension<TestTheme> with _$TestThemeTailorMixin {
  const TestTheme({this.someColor});

  final Color? someColor;
}
