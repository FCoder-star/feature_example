import 'package:feature_example/examples/pagination/core/paging_mixin.dart';
import 'package:feature_example/examples/pagination/data/app_item.dart';
import 'package:feature_example/examples/pagination/data/fake_remote_api.dart';
import 'package:feature_example/examples/pagination/list/core/paged_list.dart';
import 'package:feature_example/examples/pagination/list/widgets/app_item_card.dart';
import 'package:feature_example/examples/pagination/list/widgets/app_item_card_skeleton.dart';
import 'package:feature_example/shared/widgets/tech_background.dart';
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
    return TechScaffold(
      title: 'Pagination · List',
      variant: TechBackgroundVariant.cyan,
      gradientColors: const [Color(0xFF2193b0), Color(0xFF6dd5ed)],
      body: AppPagedList<int, AppItem>(
        controller: pagingController,
        padding: EdgeInsets.zero,
        itemBuilder: (context, item, index) => AppItemCard(item: item),
        firstPageProgressIndicatorBuilder: (context) =>
            const AppItemCardSkeletonList(count: 5),
      ),
    );
  }
}
