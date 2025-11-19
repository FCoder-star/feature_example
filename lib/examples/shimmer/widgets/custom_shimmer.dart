import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// 通用的 Shimmer 组件，支持自定义颜色
///
/// 使用示例：
/// ```dart
/// CustomShimmer(
///   baseColor: Colors.grey[300]!,
///   highlightColor: Colors.grey[100]!,
///   child: Container(
///     width: 200,
///     height: 100,
///     color: Colors.white,
///   ),
/// )
/// ```
class CustomShimmer extends StatelessWidget {
  const CustomShimmer({
    super.key,
    required this.child,
    this.baseColor,
    this.highlightColor,
    this.period,
    this.direction,
    this.loop,
    this.enabled,
  });

  /// 要应用 shimmer 效果的子组件
  final Widget child;

  /// 基础颜色（默认使用主题的 surfaceContainerHighest）
  final Color? baseColor;

  /// 高亮颜色（默认使用主题的 surface）
  final Color? highlightColor;

  /// 动画周期（默认 1500ms）
  final Duration? period;

  /// 动画方向（默认 ShimmerDirection.ltr）
  final ShimmerDirection? direction;

  /// 是否循环播放（默认 true）
  final int? loop;

  /// 是否启用 shimmer 效果（默认 true）
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // 如果没有指定颜色，使用主题颜色
    final base =
        baseColor ?? colorScheme.surfaceContainerHighest.withValues(alpha: 0.6);
    final highlight =
        highlightColor ?? colorScheme.surface.withValues(alpha: 0.9);

    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      period: period ?? const Duration(milliseconds: 1200),
      direction: direction ?? ShimmerDirection.ltr,
      loop: loop ?? 0, // 0 表示无限循环
      enabled: enabled ?? true,
      child: child,
    );
  }
}

/// Shimmer 预设样式
class ShimmerPresets {
  ShimmerPresets._();

  /// 默认样式（使用主题颜色）
  static CustomShimmer defaultStyle({
    required Widget child,
    Duration? period,
    ShimmerDirection? direction,
  }) {
    return CustomShimmer(period: period, direction: direction, child: child);
  }

  /// 浅色主题样式
  static CustomShimmer light({
    required Widget child,
    Duration? period,
    ShimmerDirection? direction,
  }) {
    return CustomShimmer(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      period: period,
      direction: direction,
      child: child,
    );
  }

  /// 深色主题样式
  static CustomShimmer dark({
    required Widget child,
    Duration? period,
    ShimmerDirection? direction,
  }) {
    return CustomShimmer(
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[700]!,
      period: period,
      direction: direction,
      child: child,
    );
  }

  /// 蓝色主题样式
  static CustomShimmer blue({
    required Widget child,
    Duration? period,
    ShimmerDirection? direction,
  }) {
    return CustomShimmer(
      baseColor: Colors.blue[300]!,
      highlightColor: Colors.blue[100]!,
      period: period,
      direction: direction,
      child: child,
    );
  }

  /// 紫色主题样式
  static CustomShimmer purple({
    required Widget child,
    Duration? period,
    ShimmerDirection? direction,
  }) {
    return CustomShimmer(
      baseColor: Colors.purple[300]!,
      highlightColor: Colors.purple[100]!,
      period: period,
      direction: direction,
      child: child,
    );
  }

  /// 自定义颜色样式
  static CustomShimmer custom({
    required Widget child,
    required Color baseColor,
    required Color highlightColor,
    Duration? period,
    ShimmerDirection? direction,
  }) {
    return CustomShimmer(
      baseColor: baseColor,
      highlightColor: highlightColor,
      period: period,
      direction: direction,
      child: child,
    );
  }
}
