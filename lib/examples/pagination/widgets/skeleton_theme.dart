import 'package:flutter/material.dart';

/// Shared colors for shimmer skeletons so the UI stays consistent.
class SkeletonShimmerColors {
  SkeletonShimmerColors._();

  static Color get base => Colors.teal.withValues(alpha: 0.3);
  static Color get highlight => Colors.grey.shade400.withValues(alpha: 0.8);
}
