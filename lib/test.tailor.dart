// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$TestThemeTailorMixin on ThemeExtension<TestTheme> {
  Color? get someColor;

  @override
  TestTheme copyWith({Color? someColor}) {
    return TestTheme(someColor: someColor ?? this.someColor);
  }

  @override
  TestTheme lerp(covariant ThemeExtension<TestTheme>? other, double t) {
    if (other is! TestTheme) return this as TestTheme;
    return TestTheme(someColor: Color.lerp(someColor, other.someColor, t));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TestTheme &&
            const DeepCollectionEquality().equals(someColor, other.someColor));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(someColor),
    );
  }
}

extension TestThemeBuildContextProps on BuildContext {
  TestTheme get testTheme => Theme.of(this).extension<TestTheme>()!;
  Color? get someColor => testTheme.someColor;
}
