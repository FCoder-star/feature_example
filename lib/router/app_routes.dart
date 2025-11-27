import 'package:feature_example/examples/dismissible/pages/dismissible_demo_page.dart';
import 'package:feature_example/examples/pagination/pages/pagination_grid_page.dart';
import 'package:feature_example/examples/pagination/pages/pagination_list_page.dart';
import 'package:feature_example/examples/pagination/pages/pagination_masonry_page.dart';
import 'package:feature_example/examples/showcaseview/pages/autoplay_showcase_page.dart';
import 'package:feature_example/examples/showcaseview/pages/basic_showcase_page.dart';
import 'package:feature_example/examples/showcaseview/pages/custom_tooltip_page.dart';
import 'package:feature_example/examples/showcaseview/pages/multi_scope_page.dart';
import 'package:feature_example/examples/showcaseview/pages/showcase_index_page.dart';
import 'package:feature_example/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutePaths {
  static const home = '/';
  static const paginationList = '/examples/pagination/list';
  static const paginationGrid = '/examples/pagination/grid';
  static const paginationMasonry = '/examples/pagination/masonry';
  static const dismissibleDemo = '/examples/dismissible/demo';
  static const showcaseIndex = '/examples/showcaseview';
  static const showcaseBasic = '/examples/showcaseview/basic';
  static const showcaseCustomTooltip = '/examples/showcaseview/custom-tooltip';
  static const showcaseAutoPlay = '/examples/showcaseview/auto-play';
  static const showcaseMultiScope = '/examples/showcaseview/multi-scope';
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
    GoRoute(
      path: AppRoutePaths.showcaseIndex,
      builder: (context, state) => const ShowcaseIndexPage(),
    ),
    GoRoute(
      path: AppRoutePaths.showcaseBasic,
      builder: (context, state) => const BasicShowcasePage(),
    ),
    GoRoute(
      path: AppRoutePaths.showcaseCustomTooltip,
      builder: (context, state) => const CustomTooltipPage(),
    ),
    GoRoute(
      path: AppRoutePaths.showcaseAutoPlay,
      builder: (context, state) => const AutoPlayShowcasePage(),
    ),
    GoRoute(
      path: AppRoutePaths.showcaseMultiScope,
      builder: (context, state) => const MultiScopePage(),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('Not Found')),
    body: Center(child: Text('Route not found: ${state.uri}')),
  ),
);
