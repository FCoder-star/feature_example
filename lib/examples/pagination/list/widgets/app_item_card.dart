import 'package:feature_example/examples/pagination/data/app_item.dart';
import 'package:flutter/material.dart';

class AppItemCard extends StatelessWidget {
  const AppItemCard({super.key, required this.item, this.onTap, this.onMore});

  final AppItem item;
  final VoidCallback? onTap;
  final VoidCallback? onMore;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final time = _formatTime(item.createdAt);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        elevation: 4,
        shadowColor: Colors.black.withValues(alpha: 0.15),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.grey.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _AvatarLarge(url: item.avatarUrl, text: item.id.toString()),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                item.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF1A1A2E),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: onMore,
                              icon: Icon(
                                Icons.more_horiz_rounded,
                                color: const Color(0xFF1A1A2E).withValues(alpha: 0.6),
                              ),
                              tooltip: '更多',
                              splashRadius: 20,
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item.subtitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF1A1A2E).withValues(alpha: 0.7),
                          ),
                        ),
                        const SizedBox(height: 10),
                        _Footer(extra: item.extra, time: time),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}

class _AvatarLarge extends StatelessWidget {
  const _AvatarLarge({required this.url, required this.text});
  final String? url;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary.withValues(alpha: 0.12),
            theme.colorScheme.secondary.withValues(alpha: 0.10),
          ],
        ),
      ),
      child: ClipOval(
        child: url == null
            ? _Initials(text: text)
            : Image.network(
                url!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _Initials(text: text),
              ),
      ),
    );
  }
}

class _Initials extends StatelessWidget {
  const _Initials({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.12),
      alignment: Alignment.center,
      child: Text(text, style: Theme.of(context).textTheme.titleSmall),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({required this.extra, required this.time});
  final Map<String, dynamic>? extra;
  final String time;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final e = extra ?? {};
    final chipWidgets = e.entries
        .take(3)
        .map((entry) => _Chip(label: '${entry.key}:${entry.value}'))
        .toList();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Wrap(spacing: 6, runSpacing: 4, children: chipWidgets)),
        if (chipWidgets.isNotEmpty) const SizedBox(width: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.schedule_rounded,
              size: 14,
              color: const Color(0xFF1A1A2E).withValues(alpha: 0.5),
            ),
            const SizedBox(width: 4),
            Text(
              time,
              style: theme.textTheme.labelMedium?.copyWith(
                color: const Color(0xFF1A1A2E).withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
