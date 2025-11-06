import 'package:feature_example/examples/pagination/core/paging_mixin.dart';
import 'package:feature_example/examples/pagination/data/app_item.dart';
import 'package:feature_example/examples/pagination/data/fake_remote_api.dart';
import 'package:feature_example/examples/pagination/grid/core/paged_grid.dart';
import 'package:feature_example/examples/pagination/grid/widgets/app_item_grid_tile.dart';
import 'package:feature_example/widgets/app_page_bar.dart';
import 'package:flutter/material.dart';

class PaginationGridPage extends StatefulWidget {
  const PaginationGridPage({super.key});

  @override
  State<PaginationGridPage> createState() => _PaginationGridPageState();
}

class _PaginationGridPageState extends State<PaginationGridPage>
    with IntPagingMixin<AppItem> {
  @override
  Future<List<AppItem>> fetchPage(int pageKey) =>
      FakeRemoteApi.fetchItems(page: pageKey, pageSize: pageSize);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const AppPageBar(
        title: 'Pagination · Grid',
        // backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: AppPagedGrid<int, AppItem>(
          controller: pagingController,
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 3 / 4,
          ),
          itemBuilder: (context, item, index) =>
              AppItemGridTile(item: item),
        ),
      ),
    );
  }
}
