import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'test.tailor.dart';

@tailorMixin
class TestTheme extends ThemeExtension<TestTheme> with _$TestTheme {
  const TestTheme({
    this.someColor,
  });

  final Color? someColor;
}
