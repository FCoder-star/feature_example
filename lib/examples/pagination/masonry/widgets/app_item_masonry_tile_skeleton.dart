import 'package:feature_example/examples/pagination/widgets/skeleton_theme.dart';
import 'package:feature_example/examples/shimmer/widgets/custom_shimmer.dart';
import 'package:flutter/material.dart';

class AppItemMasonryTileSkeleton extends StatelessWidget {
  const AppItemMasonryTileSkeleton({super.key, required this.height});

  final double height;

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
            color: cs.outlineVariant.withValues(alpha: 0.35),
            width: 1,
          ),
          gradient: LinearGradient(
            colors: [
              cs.primaryContainer.withValues(alpha: 0.22),
              cs.secondaryContainer.withValues(alpha: 0.18),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Container(
                height: height,
                width: double.infinity,
                color: baseColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
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
                    width: 120,
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

class AppItemMasonrySkeletonGrid extends StatelessWidget {
  const AppItemMasonrySkeletonGrid({
    super.key,
    this.crossAxisCount = 2,
    this.itemCount = 6,
    this.mainAxisSpacing = 8,
    this.crossAxisSpacing = 8,
    this.padding = const EdgeInsets.all(8),
  });

  final int crossAxisCount;
  final int itemCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      width: double.infinity,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          childAspectRatio: 0.65,
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          final double variableHeight =
              (120 + (index % 3) * 30 + (index.isEven ? 10 : 0)).toDouble();
          return AppItemMasonryTileSkeleton(
            height: variableHeight,
          );
        },
      ),
    );
  }
}


