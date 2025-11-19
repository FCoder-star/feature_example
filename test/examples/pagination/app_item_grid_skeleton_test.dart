import 'package:feature_example/examples/pagination/grid/widgets/app_item_grid_tile_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AppItemGridSkeletonGrid can build semantics tree', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: AppItemGridSkeletonGrid(),
            ),
          ],
        ),
      ),
    );

    final semanticsHandle = tester.ensureSemantics();

    await tester.pump(const Duration(milliseconds: 100));
    semanticsHandle.dispose();
  });
}
