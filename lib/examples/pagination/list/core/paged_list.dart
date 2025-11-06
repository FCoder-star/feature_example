import 'package:feature_example/examples/pagination/core/pagination_widgets.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class AppPagedList<PageKey, Item> extends StatelessWidget {
  const AppPagedList({
    super.key,
    required this.controller,
    required this.itemBuilder,
    this.separatorBuilder,
    this.padding,
    this.physics,
    this.scrollController,
    this.enableRefresh = true,
    this.onRefresh,
    this.firstPageProgressIndicatorBuilder,
    this.newPageProgressIndicatorBuilder,
    this.noItemsFoundIndicatorBuilder,
    this.firstPageErrorIndicatorBuilder,
    this.newPageErrorIndicatorBuilder,
  });

  final PagingController<PageKey, Item> controller;
  final ItemWidgetBuilder<Item> itemBuilder;
  final IndexedWidgetBuilder? separatorBuilder;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final ScrollController? scrollController;
  final bool enableRefresh;
  final Future<void> Function()? onRefresh;

  final WidgetBuilder? firstPageProgressIndicatorBuilder;
  final WidgetBuilder? newPageProgressIndicatorBuilder;
  final WidgetBuilder? noItemsFoundIndicatorBuilder;
  final WidgetBuilder? firstPageErrorIndicatorBuilder;
  final WidgetBuilder? newPageErrorIndicatorBuilder;

  @override
  Widget build(BuildContext context) {
    final listBuilder = PagingListener<PageKey, Item>(
      controller: controller,
      builder: (context, state, fetchNextPage) {
        final delegate = PagedChildBuilderDelegate<Item>(
          itemBuilder: itemBuilder,
          firstPageProgressIndicatorBuilder:
              firstPageProgressIndicatorBuilder ??
              (context) => const AppFirstPageProgress(),
          newPageProgressIndicatorBuilder:
              newPageProgressIndicatorBuilder ??
              (context) => const AppNewPageProgress(),
          noItemsFoundIndicatorBuilder:
              noItemsFoundIndicatorBuilder ??
              (context) => const AppNoItemsIndicator(),
          firstPageErrorIndicatorBuilder:
              firstPageErrorIndicatorBuilder ??
              (context) => AppFirstPageError(onTryAgain: fetchNextPage),
          newPageErrorIndicatorBuilder:
              newPageErrorIndicatorBuilder ??
              (context) => AppNewPageError(onTryAgain: fetchNextPage),
        );

        if (separatorBuilder != null) {
          return PagedListView<PageKey, Item>.separated(
            state: state,
            fetchNextPage: fetchNextPage,
            builderDelegate: delegate,
            separatorBuilder: separatorBuilder!,
            padding: padding,
            physics: physics,
            scrollDirection: Axis.vertical,
            scrollController: scrollController,
          );
        }

        return PagedListView<PageKey, Item>(
          state: state,
          fetchNextPage: fetchNextPage,
          builderDelegate: delegate,
          padding: padding,
          physics: physics,
          scrollDirection: Axis.vertical,
          scrollController: scrollController,
        );
      },
    );

    if (!enableRefresh) return listBuilder;
    return RefreshIndicator(
      onRefresh: onRefresh ?? () => Future.sync(controller.refresh),
      child: listBuilder,
    );
  }
}
