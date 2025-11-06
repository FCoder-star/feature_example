import 'app_item.dart';

class FakeRemoteApi {
  static Future<List<AppItem>> fetchItems({
    required int page,
    required int pageSize,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));

    const totalItems = 87;
    final offset = (page - 1) * pageSize;
    if (offset >= totalItems) {
      return const [];
    }

    final remainingItemCount = totalItems - offset;
    final itemsToReturn = remainingItemCount < pageSize
        ? remainingItemCount
        : pageSize;

    return List.generate(itemsToReturn, (index) {
      final id = offset + index + 1;
      final data = _mockCommercialData(id);
      return AppItem(
        id: id,
        title: data.title,
        subtitle: data.subtitle,
        avatarUrl: data.avatarUrl,
        createdAt: data.createdAt,
        extra: data.extra,
      );
    });
  }

  static _MockData _mockCommercialData(int id) {
    const categories = ['电商', 'SaaS', '支付', '物流', '内容', '社交'];
    const statuses = ['活跃', '即将到期', '试用中', '已冻结'];
    const companies = ['凌云科技', '星际数科', '蓝鲸互动', '火山引擎', '星火智联'];

    T pick<T>(List<T> list) => list[id % list.length];

    final category = pick(categories);
    final status = pick(statuses);
    final company = pick(companies);

    final price = ((id * 137) % 9900) / 100 + 9.9;
    final rating = ((id * 17) % 50) / 10 + 3.0;
    final createdAt = DateTime.now().subtract(Duration(minutes: id * 7));

    final title = '$company · $category 解决方案';
    final subtitle = '高并发 · 低延迟 · 可观测 · 第$id 批次部署完成';
    final avatarUrl = id % 4 == 0
        ? 'https://picsum.photos/seed/company_$id/80'
        : (id % 5 == 0 ? 'https://picsum.photos/seed/product_$id/80' : null);

    final extra = <String, dynamic>{
      '状态': status,
      '品类': category,
      '价格': '¥${price.toStringAsFixed(2)}',
      '评分': (rating > 5 ? 5 : rating).toStringAsFixed(1),
    };

    return _MockData(
      title: title,
      subtitle: subtitle,
      avatarUrl: avatarUrl,
      createdAt: createdAt,
      extra: extra,
    );
  }
}

class _MockData {
  final String title;
  final String subtitle;
  final String? avatarUrl;
  final DateTime createdAt;
  final Map<String, dynamic> extra;
  const _MockData({
    required this.title,
    required this.subtitle,
    required this.avatarUrl,
    required this.createdAt,
    required this.extra,
  });
}
