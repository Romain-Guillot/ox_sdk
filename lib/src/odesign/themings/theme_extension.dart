import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ox_sdk/src/odesign/grid.dart';
import 'package:ox_sdk/src/odesign/themings/supporting_colors.dart';

extension ThemeDataExt on ThemeData {
  ColorsTheme get colors => extension<ColorsTheme>()!;
  ConstraintsTheme get constraints => extension<ConstraintsTheme>()!;
  PaddingsTheme get paddings => extension<PaddingsTheme>()!;
  MarginTheme get margins => extension<MarginTheme>()!;
  RadiusesTheme get radiuses => extension<RadiusesTheme>()!;
  ComponentsTheme get components => extension<ComponentsTheme>()!;
  ButtonThemes get buttons => extension<ButtonThemes>()!;
}

class ColorsTheme extends ThemeExtension<ColorsTheme> {
  const ColorsTheme(
      {required this.error,
      required this.onError,
      required this.info,
      required this.onInfo,
      required this.success,
      required this.onSuccess,
      required this.onWarning,
      required this.warning,
      required this.supportings});

  final Color error;
  final Color onError;
  final Color info;
  final Color onInfo;
  final Color success;
  final Color onSuccess;
  final Color warning;
  final Color onWarning;
  final Map<SupportingColors, SupportingColorData> supportings;

  @override
  ThemeExtension<ColorsTheme> copyWith(
      {Color? error,
      Color? onError,
      Color? info,
      Color? onInfo,
      Color? success,
      Color? onSuccess,
      Color? warning,
      Color? onWarning,
      Map<SupportingColors, SupportingColorData>? supportings}) {
    return ColorsTheme(
      error: error ?? this.error,
      onError: onError ?? this.onError,
      info: info ?? this.info,
      onInfo: onInfo ?? this.onInfo,
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      onWarning: onWarning ?? this.onWarning,
      warning: warning ?? this.warning,
      supportings: supportings ?? this.supportings,
    );
  }

  @override
  ThemeExtension<ColorsTheme> lerp(ThemeExtension<ColorsTheme>? other, double t) {
    if (other is! ColorsTheme) {
      return this;
    }
    return ColorsTheme(
      error: Color.lerp(error, other.error, t)!,
      onError: Color.lerp(onError, other.onError, t)!,
      info: Color.lerp(info, other.info, t)!,
      onInfo: Color.lerp(onInfo, other.onInfo, t)!,
      success: Color.lerp(success, other.success, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      onWarning: Color.lerp(onWarning, other.onWarning, t)!,
      supportings: supportings,
    );
  }
}

class ButtonThemes extends ThemeExtension<ButtonThemes> {
  const ButtonThemes({
    required this.error,
    required this.success,
  });

  final ButtonStyle error;
  final ButtonStyle success;

  @override
  ThemeExtension<ButtonThemes> copyWith() {
    throw UnimplementedError();
  }

  @override
  ThemeExtension<ButtonThemes> lerp(ThemeExtension<ButtonThemes>? other, double t) {
    if (other is! ButtonThemes) {
      return this;
    }
    return ButtonThemes(
      error: error,
      success: success,
    );
  }
}

class PaddingsTheme extends ThemeExtension<PaddingsTheme> {
  const PaddingsTheme({
    required this.tiny,
    required this.medium,
    required this.big,
    required this.small,
  });

  final double medium;
  final double tiny;
  final double small;
  final double big;

  @override
  ThemeExtension<PaddingsTheme> copyWith() {
    throw UnimplementedError();
  }

  @override
  ThemeExtension<PaddingsTheme> lerp(ThemeExtension<PaddingsTheme>? other, double t) {
    if (other is! PaddingsTheme) {
      return this;
    }
    return PaddingsTheme(
        medium: lerpDouble(medium, other.medium, t)!,
        big: lerpDouble(big, other.big, t)!,
        small: lerpDouble(small, other.small, t)!,
        tiny: lerpDouble(tiny, other.tiny, t)!);
  }
}

class MarginTheme extends ThemeExtension<MarginTheme> {
  const MarginTheme({required this.normal});

  final double normal;

  @override
  ThemeExtension<MarginTheme> copyWith() {
    throw UnimplementedError();
  }

  @override
  ThemeExtension<MarginTheme> lerp(ThemeExtension<MarginTheme>? other, double t) {
    if (other is! MarginTheme) {
      return this;
    }
    return MarginTheme(
      normal: lerpDouble(normal, other.normal, t)!,
    );
  }
}

class RadiusesTheme extends ThemeExtension<RadiusesTheme> {
  const RadiusesTheme({
    required this.tiny,
    required this.small,
    required this.medium,
    required this.big,
  });

  final BorderRadius tiny;
  final BorderRadius small;
  final BorderRadius medium;
  final BorderRadius big;

  @override
  ThemeExtension<RadiusesTheme> copyWith() {
    throw UnimplementedError();
  }

  @override
  ThemeExtension<RadiusesTheme> lerp(ThemeExtension<RadiusesTheme>? other, double t) {
    if (other is! RadiusesTheme) {
      return this;
    }
    return RadiusesTheme(
        tiny: BorderRadius.lerp(tiny, other.tiny, t)!,
        small: BorderRadius.lerp(small, other.small, t)!,
        medium: BorderRadius.lerp(medium, other.medium, t)!,
        big: BorderRadius.lerp(big, other.big, t)!);
  }
}

class ComponentsTheme extends ThemeExtension<ComponentsTheme> {
  const ComponentsTheme({required this.dataGrid, required this.tooltip});

  final OTooltipThemeData? tooltip;
  final ODataGridTheme? dataGrid;

  @override
  ThemeExtension<ComponentsTheme> copyWith() {
    throw UnimplementedError();
  }

  @override
  ThemeExtension<ComponentsTheme> lerp(ThemeExtension<ComponentsTheme>? other, double t) {
    return this;
  }
}

class ConstraintsTheme extends ThemeExtension<ConstraintsTheme> {
  const ConstraintsTheme({required this.maxPageWidth, required this.mobileScreenMax, required this.snackbarMaxSize});

  final double mobileScreenMax;
  final double snackbarMaxSize;
  final double maxPageWidth;

  @override
  ThemeExtension<ConstraintsTheme> copyWith() {
    throw UnimplementedError();
  }

  @override
  ThemeExtension<ConstraintsTheme> lerp(ThemeExtension<ConstraintsTheme>? other, double t) {
    return this;
  }
}

class OTooltipThemeData {
  const OTooltipThemeData({this.backgroundColor, this.style, this.padding});

  final Color? backgroundColor;
  final TextStyle? style;
  final EdgeInsets? padding;
}

class OThemeExtensions {
  static List<ThemeExtension> extensions({
    required ButtonThemes buttons,
    required ColorsTheme colors,
    required PaddingsTheme paddings,
    required MarginTheme margins,
    required ComponentsTheme components,
    required ConstraintsTheme constraints,
  }) {
    return [buttons, colors, paddings, margins, components, constraints];
  }
}
