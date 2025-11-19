import 'package:flutter/material.dart';
import '../../data/app_item.dart';

class AppItemMasonryTile extends StatelessWidget {
  const AppItemMasonryTile({super.key, required this.item, this.onTap});
  final AppItem item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // More varied dynamic height based on id (deterministic): ~120..260
    final variableHeight = 120.0 + (item.id * 37 % 140);

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      elevation: 4,
      shadowColor: Colors.black.withValues(alpha: 0.15),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: SizedBox(
                  height: variableHeight,
                  width: double.infinity,
                  child: item.avatarUrl == null
                      ? _Placeholder(id: item.id)
                      : Image.network(
                          item.avatarUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (c, e, s) => _Placeholder(id: item.id),
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1A1A2E),
                      ),
                    ),
                    const SizedBox(height: 6),
                    _Badges(extra: item.extra),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Badges extends StatelessWidget {
  const _Badges({required this.extra});
  final Map<String, dynamic>? extra;

  @override
  Widget build(BuildContext context) {
    final e = extra ?? {};
    if (e.isEmpty) return const SizedBox.shrink();
    final theme = Theme.of(context);
    final children = <Widget>[];
    for (final entry in e.entries.take(2)) {
      children.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          margin: const EdgeInsets.only(right: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF6366F1),
                Color(0xFF8B5CF6),
              ],
            ),
          ),
          child: Text(
            '${entry.key}:${entry.value}',
            style: theme.textTheme.labelSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }
    return Wrap(spacing: 6, runSpacing: 4, children: children);
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({required this.id});
  final int id;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFee0979),
            Color(0xFFff6a00),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Text(
          'ID $id',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
