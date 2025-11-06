import 'package:feature_example/examples/pagination/core/paging_mixin.dart';
import 'package:feature_example/examples/pagination/data/app_item.dart';
import 'package:feature_example/examples/pagination/data/fake_remote_api.dart';
import 'package:feature_example/examples/pagination/list/core/paged_list.dart';
import 'package:feature_example/examples/pagination/list/widgets/app_item_card.dart';
import 'package:feature_example/widgets/app_page_bar.dart';
import 'package:flutter/material.dart';

class PaginationListPage extends StatefulWidget {
  const PaginationListPage({super.key});

  @override
  State<PaginationListPage> createState() => _PaginationListPageState();
}

class _PaginationListPageState extends State<PaginationListPage>
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
        title: 'Pagination · List',
      ),
      body: SafeArea(
        child: AppPagedList<int, AppItem>(
          controller: pagingController,
          padding: EdgeInsets.zero,
          itemBuilder: (context, item, index) => AppItemCard(item: item),
        ),
      ),
    );
  }
}
