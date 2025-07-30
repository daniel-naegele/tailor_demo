import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'test.tailor.dart';

@tailorMixin
class TestTheme extends ThemeExtension<TestTheme> with _$TestThemeTailorMixin {
  const TestTheme({this.someColor});

  @override
  final Color? someColor;
}
