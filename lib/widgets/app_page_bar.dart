import 'package:flutter/material.dart';

class AppPageBar extends StatelessWidget implements PreferredSizeWidget {
  const AppPageBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.bottom,
    this.centerTitle,
    this.backgroundColor,
    this.elevation,
  });

  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final PreferredSizeWidget? bottom;
  final bool? centerTitle;
  final Color? backgroundColor;
  final double? elevation;

  @override
  Size get preferredSize {
    final bottomHeight = bottom?.preferredSize.height ?? 0;
    return Size.fromHeight(kToolbarHeight + bottomHeight);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final useFancyBackground = backgroundColor == null;
    return AppBar(
      title: Text(title),
      centerTitle: centerTitle ?? true,
      elevation: elevation ?? 0,
      scrolledUnderElevation: 0,
      backgroundColor: useFancyBackground
          ? Colors.transparent
          : backgroundColor,
      surfaceTintColor: Colors.transparent,
      foregroundColor: useFancyBackground ? theme.colorScheme.onPrimary : null,
      leading: leading,
      actions: actions,
      bottom: bottom,
      flexibleSpace: useFancyBackground
          ? const _GradientAppBarBackground()
          : null,
    );
  }
}

class _GradientAppBarBackground extends StatelessWidget {
  const _GradientAppBarBackground();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.topLeft,
          radius: 1.2,
          colors: [scheme.primary, scheme.secondary],
          stops: const [0.0, 1.0],
        ),
      ),
    );
  }
}
