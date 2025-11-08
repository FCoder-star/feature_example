import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../grid/widgets/pagination_grid_widgets.dart';

class AppPagedMasonry<PageKey, Item> extends StatelessWidget {
  const AppPagedMasonry.count({
    super.key,
    required this.controller,
    required this.itemBuilder,
    this.crossAxisCount = 2,
    this.padding,
    this.physics,
    this.scrollController,
    this.mainAxisSpacing = 8,
    this.crossAxisSpacing = 8,
    this.enableRefresh = true,
    this.onRefresh,
    this.showNewPageProgressIndicatorAsGridChild = false,
    this.showNewPageErrorIndicatorAsGridChild = false,
    this.showNoMoreItemsIndicatorAsGridChild = false,
    this.firstPageProgressIndicatorBuilder,
    this.newPageProgressIndicatorBuilder,
    this.noItemsFoundIndicatorBuilder,
    this.firstPageErrorIndicatorBuilder,
    this.newPageErrorIndicatorBuilder,
  }) : maxCrossAxisExtent = null;

  final PagingController<PageKey, Item> controller;
  final ItemWidgetBuilder<Item> itemBuilder;
  final int? crossAxisCount;
  final double? maxCrossAxisExtent;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final ScrollController? scrollController;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final bool enableRefresh;
  final Future<void> Function()? onRefresh;

  final bool showNewPageProgressIndicatorAsGridChild;
  final bool showNewPageErrorIndicatorAsGridChild;
  final bool showNoMoreItemsIndicatorAsGridChild;

  final WidgetBuilder? firstPageProgressIndicatorBuilder;
  final WidgetBuilder? newPageProgressIndicatorBuilder;
  final WidgetBuilder? noItemsFoundIndicatorBuilder;
  final WidgetBuilder? firstPageErrorIndicatorBuilder;
  final WidgetBuilder? newPageErrorIndicatorBuilder;

  const AppPagedMasonry.extent({
    super.key,
    required this.controller,
    required this.itemBuilder,
    required double this.maxCrossAxisExtent,
    this.padding,
    this.physics,
    this.scrollController,
    this.mainAxisSpacing = 8,
    this.crossAxisSpacing = 8,
    this.enableRefresh = true,
    this.onRefresh,
    this.showNewPageProgressIndicatorAsGridChild = true,
    this.showNewPageErrorIndicatorAsGridChild = true,
    this.showNoMoreItemsIndicatorAsGridChild = true,
    this.firstPageProgressIndicatorBuilder,
    this.newPageProgressIndicatorBuilder,
    this.noItemsFoundIndicatorBuilder,
    this.firstPageErrorIndicatorBuilder,
    this.newPageErrorIndicatorBuilder,
  }) : crossAxisCount = null;

  @override
  Widget build(BuildContext context) {
    final view = PagingListener<PageKey, Item>(
      controller: controller,
      builder: (context, state, fetchNextPage) {
        final delegate = PagedChildBuilderDelegate<Item>(
          itemBuilder: itemBuilder,
          firstPageProgressIndicatorBuilder:
              firstPageProgressIndicatorBuilder ??
              (context) => const GridFirstPageProgress(),
          newPageProgressIndicatorBuilder:
              newPageProgressIndicatorBuilder ??
              (context) => const GridNewPageProgress(),
          noItemsFoundIndicatorBuilder:
              noItemsFoundIndicatorBuilder ??
              (context) => const GridNoItemsIndicator(),
          firstPageErrorIndicatorBuilder:
              firstPageErrorIndicatorBuilder ??
              (context) => GridFirstPageError(onTryAgain: fetchNextPage),
          newPageErrorIndicatorBuilder:
              newPageErrorIndicatorBuilder ??
              (context) => GridNewPageError(onTryAgain: fetchNextPage),
        );

        if (crossAxisCount != null) {
          return PagedMasonryGridView<PageKey, Item>.count(
            state: state,
            fetchNextPage: fetchNextPage,
            builderDelegate: delegate,
            crossAxisCount: crossAxisCount!,
            padding: padding,
            physics: physics,
            scrollController: scrollController,
            mainAxisSpacing: mainAxisSpacing,
            crossAxisSpacing: crossAxisSpacing,
            showNewPageProgressIndicatorAsGridChild:
                showNewPageProgressIndicatorAsGridChild,
            showNewPageErrorIndicatorAsGridChild:
                showNewPageErrorIndicatorAsGridChild,
            showNoMoreItemsIndicatorAsGridChild:
                showNoMoreItemsIndicatorAsGridChild,
          );
        }

        return PagedMasonryGridView<PageKey, Item>.extent(
          state: state,
          fetchNextPage: fetchNextPage,
          builderDelegate: delegate,
          maxCrossAxisExtent: maxCrossAxisExtent!,
          padding: padding,
          physics: physics,
          scrollController: scrollController,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          showNewPageProgressIndicatorAsGridChild:
              showNewPageProgressIndicatorAsGridChild,
          showNewPageErrorIndicatorAsGridChild:
              showNewPageErrorIndicatorAsGridChild,
          showNoMoreItemsIndicatorAsGridChild:
              showNoMoreItemsIndicatorAsGridChild,
        );
      },
    );

    if (!enableRefresh) return view;
    return RefreshIndicator(
      onRefresh: onRefresh ?? () => Future.sync(controller.refresh),
      child: view,
    );
  }
}


