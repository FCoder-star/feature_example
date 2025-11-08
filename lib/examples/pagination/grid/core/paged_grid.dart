import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../grid/widgets/pagination_grid_widgets.dart';

class AppPagedGrid<PageKey, Item> extends StatelessWidget {
  const AppPagedGrid({
    super.key,
    required this.controller,
    required this.itemBuilder,
    required this.gridDelegate,
    this.padding,
    this.physics,
    this.scrollController,
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
  });

  final PagingController<PageKey, Item> controller;
  final ItemWidgetBuilder<Item> itemBuilder;
  final SliverGridDelegate gridDelegate;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final ScrollController? scrollController;
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

  @override
  Widget build(BuildContext context) {
    final view = PagingListener<PageKey, Item>(
      controller: controller,
      builder: (context, state, fetchNextPage) => PagedGridView<PageKey, Item>(
        state: state,
        fetchNextPage: fetchNextPage,
        gridDelegate: gridDelegate,
        padding: padding,
        physics: physics,
        scrollController: scrollController,
        showNewPageProgressIndicatorAsGridChild:
            showNewPageProgressIndicatorAsGridChild,
        showNewPageErrorIndicatorAsGridChild:
            showNewPageErrorIndicatorAsGridChild,
        showNoMoreItemsIndicatorAsGridChild:
            showNoMoreItemsIndicatorAsGridChild,
        builderDelegate: PagedChildBuilderDelegate<Item>(
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
        ),
      ),
    );

    if (!enableRefresh) return view;
    return RefreshIndicator(
      onRefresh: onRefresh ?? () => Future.sync(controller.refresh),
      child: view,
    );
  }
}
