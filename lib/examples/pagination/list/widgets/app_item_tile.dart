import 'package:feature_example/examples/pagination/data/app_item.dart';
import 'package:flutter/material.dart';

class AppItemTile extends StatelessWidget {
  const AppItemTile({
    super.key,
    required this.item,
    this.onTap,
    this.onMore,
    this.trailing,
    this.useTechColors = true,
    this.accentColor,
  });

  final AppItem item;
  final VoidCallback? onTap;
  final VoidCallback? onMore;
  final Widget? trailing;
  final bool useTechColors;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final accent = accentColor ?? _accentFromId(item.id, theme);
    final timeText = _formatTime(item.createdAt);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Material(
        elevation: 2.5,
        borderRadius: BorderRadius.circular(14),
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: useTechColors
                  ? Border.all(color: accent.withValues(alpha: 0.18), width: 1)
                  : Border.all(
                      color: colorScheme.outlineVariant.withValues(alpha: 0.6),
                      width: 1,
                    ),
              gradient: useTechColors
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        colorScheme.surface.withValues(alpha: 0.98),
                        accent.withValues(alpha: 0.18),
                        _shiftAccent(
                          accent,
                          deltaHue: 18,
                          deltaValue: 0.05,
                        ).withValues(alpha: 0.1),
                      ],
                    )
                  : LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        colorScheme.surface,
                        colorScheme.surfaceContainerHighest.withValues(
                          alpha: 0.5,
                        ),
                      ],
                    ),
              boxShadow: useTechColors
                  ? [
                      BoxShadow(
                        color: accent.withValues(alpha: 0.25),
                        blurRadius: 20,
                        offset: const Offset(0, 12),
                      ),
                    ]
                  : const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 6),
                      ),
                    ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _AccentBar(
                    color: useTechColors
                        ? accent
                        : colorScheme.primary.withValues(alpha: 0.3),
                  ),
                  const SizedBox(width: 10),
                  _Avatar(
                    url: item.avatarUrl,
                    fallbackText: item.id.toString(),
                    ringColor: useTechColors ? accent : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                item.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              timeText,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.textTheme.bodySmall?.color
                                    ?.withValues(alpha: 0.65),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.subtitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.textTheme.bodyMedium?.color
                                ?.withValues(alpha: 0.9),
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildBadges(context),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  trailing ?? _DefaultMore(onPressed: onMore),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBadges(BuildContext context) {
    final extra = item.extra;
    if (extra == null || extra.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final accent = accentColor ?? _accentFromId(item.id, theme);
    final gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        accent.withValues(alpha: 0.25),
        _shiftAccent(
          accent,
          deltaHue: -12,
          deltaSaturation: -0.1,
        ).withValues(alpha: 0.18),
      ],
    );
    final textColor = theme.colorScheme.onPrimaryContainer;

    final chips = <Widget>[];
    for (final entry in extra.entries.take(3)) {
      final label = '${entry.key}:${entry.value}';
      chips.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            gradient: gradient,
          ),
          child: Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: textColor),
          ),
        ),
      );
    }

    return Wrap(spacing: 6, runSpacing: 4, children: chips);
  }

  String _formatTime(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  Color _accentFromId(int id, ThemeData theme) {
    final hue = 180 + (id % 120);
    final hsl = HSLColor.fromAHSL(
      1,
      hue.toDouble(),
      0.65,
      theme.brightness == Brightness.dark ? 0.55 : 0.45,
    );
    return hsl.toColor();
  }

  static Color _shiftAccent(
    Color base, {
    double deltaHue = 0,
    double deltaSaturation = 0,
    double deltaValue = 0,
  }) {
    final hsv = HSVColor.fromColor(base);
    final hue = (hsv.hue + deltaHue) % 360;
    final saturation = (hsv.saturation + deltaSaturation).clamp(0.0, 1.0);
    final value = (hsv.value + deltaValue).clamp(0.0, 1.0);
    return HSVColor.fromAHSV(hsv.alpha, hue, saturation, value).toColor();
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({
    required this.url,
    required this.fallbackText,
    this.ringColor,
  });
  final String? url;
  final String fallbackText;
  final Color? ringColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        if (ringColor != null)
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: ringColor!.withValues(alpha: 0.35),
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
        CircleAvatar(
          radius: 24,
          backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.12),
          child: ClipOval(
            child: url == null
                ? _AvatarPlaceholder(text: fallbackText)
                : Image.network(
                    url!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _AvatarPlaceholder(text: fallbackText),
                  ),
          ),
        ),
      ],
    );
  }
}

class _AccentBar extends StatelessWidget {
  const _AccentBar({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [color.withValues(alpha: 0.0), color.withValues(alpha: 0.9)],
        ),
      ),
    );
  }
}

class _DefaultMore extends StatelessWidget {
  const _DefaultMore({this.onPressed});
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.more_horiz_rounded),
      tooltip: '更多',
    );
  }
}

class _AvatarPlaceholder extends StatelessWidget {
  const _AvatarPlaceholder({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.08),
      child: Text(text, style: Theme.of(context).textTheme.labelLarge),
    );
  }
}
