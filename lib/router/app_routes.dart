import 'package:feature_example/examples/dismissible/pages/dismissible_demo_page.dart';
import 'package:feature_example/examples/pagination/pages/pagination_grid_page.dart';
import 'package:feature_example/examples/pagination/pages/pagination_list_page.dart';
import 'package:feature_example/examples/pagination/pages/pagination_masonry_page.dart';
import 'package:feature_example/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutePaths {
  static const home = '/';
  static const paginationList = '/examples/pagination/list';
  static const paginationGrid = '/examples/pagination/grid';
  static const paginationMasonry = '/examples/pagination/masonry';
  static const dismissibleDemo = '/examples/dismissible/demo';
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
    GoRoute(
      path: AppRoutePaths.dismissibleDemo,
      builder: (context, state) => const DismissibleDemoPage(),
    ),

  ],
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('Not Found')),
    body: Center(child: Text('Route not found: ${state.uri}')),
  ),
);
