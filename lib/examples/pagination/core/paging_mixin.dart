import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

mixin IntPagingMixin<T> on Object {
  int get pageSize => 20;

  late final PagingController<int, T> pagingController =
      PagingController<int, T>(
        getNextPageKey: (state) => state.nextIntPageKey,
        fetchPage: _mixinFetch,
      );

  Future<List<T>> _mixinFetch(int pageKey) async {
    final items = await fetchPage(pageKey);
    final hasMore = computeHasMore(pageKey: pageKey, items: items);
    if (!hasMore) {
      pagingController.value = pagingController.value.copyWith(
        hasNextPage: false,
      );
    }
    return items;
  }

  Future<List<T>> fetchPage(int pageKey);

  bool computeHasMore({required int pageKey, required List<T> items}) {
    return items.length >= pageSize;
  }
}
