import 'package:feature_example/examples/pagination/pages/pagination_grid_page.dart';
import 'package:feature_example/examples/pagination/pages/pagination_list_page.dart';
import 'package:feature_example/examples/pagination/pages/pagination_masonry_page.dart';
import 'package:feature_example/home/home_page.dart';
import 'package:feature_example/widgets/app_page_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutePaths {
  static const home = '/';
  static const paginationList = '/examples/pagination/list';
  static const paginationGrid = '/examples/pagination/grid';
  static const paginationMasonry = '/examples/pagination/masonry';
}

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: AppRoutePaths.home,
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: HomePage()),
    ),
    GoRoute(
      path: AppRoutePaths.paginationList,
      builder: (context, state) => const PaginationListPage(),
    ),
    GoRoute(
      path: AppRoutePaths.paginationGrid,
      builder: (context, state) => const PaginationGridPage(),
    ),
    GoRoute(
      path: AppRoutePaths.paginationMasonry,
      builder: (context, state) => const PaginationMasonryPage(),
    ),
  ],
  errorBuilder: (context, state) => Builder(
    builder: (context) {
      final scheme = Theme.of(context).colorScheme;
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const AppPageBar(
          title: 'Not Found',
          backgroundColor: Colors.transparent,
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.topLeft,
                    radius: 1.2,
                    colors: [scheme.primary, scheme.secondary],
                    stops: const [0.0, 1.0],
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Center(child: Text('Route not found: ${state.uri}')),
            ),
          ],
        ),
      );
    },
  ),
);
