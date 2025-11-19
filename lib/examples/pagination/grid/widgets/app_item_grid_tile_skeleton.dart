import 'package:feature_example/examples/pagination/widgets/skeleton_theme.dart';
import 'package:feature_example/examples/shimmer/widgets/custom_shimmer.dart';
import 'package:flutter/material.dart';

class AppItemGridTileSkeleton extends StatelessWidget {
  const AppItemGridTileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final baseColor = SkeletonShimmerColors.base;
    final highlightColor = SkeletonShimmerColors.highlight;
    final cs = Theme.of(context).colorScheme;

    return CustomShimmer(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: cs.outlineVariant.withValues(alpha: 0.4),
            width: 1,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              cs.surface.withValues(alpha: 0.96),
              cs.surfaceContainerHighest.withValues(alpha: 0.85),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 4 / 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Container(color: baseColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 16,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: baseColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    height: 14,
                    width: 90,
                    decoration: BoxDecoration(
                      color: baseColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppItemGridSkeletonGrid extends StatelessWidget {
  const AppItemGridSkeletonGrid({
    super.key,
    this.crossAxisCount = 2,
    this.childAspectRatio = 3 / 4,
    this.mainAxisSpacing = 12,
    this.crossAxisSpacing = 12,
    this.padding = const EdgeInsets.all(8),
    this.itemCount = 6,
  });

  final int crossAxisCount;
  final double childAspectRatio;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final EdgeInsets padding;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    assert(crossAxisCount > 0, 'crossAxisCount must be greater than zero');
    assert(
      childAspectRatio > 0,
      'childAspectRatio must be greater than zero',
    );

    return ExcludeSemantics(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: double.infinity,
        child: GridView.builder(
          padding: padding,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: mainAxisSpacing,
            crossAxisSpacing: crossAxisSpacing,
            childAspectRatio: childAspectRatio,
          ),
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: itemCount,
          itemBuilder: (context, index) => const AppItemGridTileSkeleton(),
        ),
      ),
    );
  }
}
