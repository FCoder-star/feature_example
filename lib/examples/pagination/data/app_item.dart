class AppItem {
  final int id;
  final String title;
  final String subtitle;
  final String? avatarUrl;
  final DateTime createdAt;
  final Map<String, dynamic>? extra;

  const AppItem({
    required this.id,
    required this.title,
    required this.subtitle,
    this.avatarUrl,
    required this.createdAt,
    this.extra,
  });
}
