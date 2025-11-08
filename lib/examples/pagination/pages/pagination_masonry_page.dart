import 'package:feature_example/examples/pagination/core/paging_mixin.dart';
import 'package:feature_example/examples/pagination/data/app_item.dart';
import 'package:feature_example/examples/pagination/data/fake_remote_api.dart';
import 'package:feature_example/examples/pagination/masonry/core/paged_masonry.dart';
import 'package:feature_example/examples/pagination/masonry/widgets/app_item_masonry_tile.dart';
import 'package:flutter/material.dart';



class PaginationMasonryPage extends StatefulWidget {
  const PaginationMasonryPage({super.key});

  @override
  State<PaginationMasonryPage> createState() => _PaginationMasonryPageState();
}

class _PaginationMasonryPageState extends State<PaginationMasonryPage>
    with IntPagingMixin<AppItem> {
  @override
  Future<List<AppItem>> fetchPage(int pageKey) =>
      FakeRemoteApi.fetchItems(page: pageKey, pageSize: pageSize);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pagination · Masonry')),
      body: SafeArea(
        child: AppPagedMasonry<int, AppItem>.count(
          controller: pagingController,
          itemBuilder: (context, item, index) => AppItemMasonryTile(item: item),
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          padding: const EdgeInsets.all(8),
        ),
      ),
    );
  }
}
