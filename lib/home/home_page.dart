import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../router/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final entries = _demoEntries;
    final bg = Theme.of(context).colorScheme.surfaceContainerLowest;
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(title: const Text('Feature Examples')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: entries.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) => _ExampleCard(entry: entries[index]),
      ),
    );
  }
}

class ExampleEntry {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> gradient;
  final String routePath;

  const ExampleEntry({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradient,
    required this.routePath,
  });
}

const _demoEntries = <ExampleEntry>[
  ExampleEntry(
    title: 'Pagination · List',
    subtitle: 'PagedListView + Refresh + Error/Empty',
    icon: Icons.view_list_rounded,
    gradient: [Color(0xFF2193b0), Color(0xFF6dd5ed)],
    routePath: AppRoutePaths.paginationList,
  ),
  ExampleEntry(
    title: 'Pagination · Grid',
    subtitle: 'PagedGridView in 2 columns',
    icon: Icons.grid_view_rounded,
    gradient: [Color(0xFF8360c3), Color(0xFF2ebf91)],
    routePath: AppRoutePaths.paginationGrid,
  ),
  ExampleEntry(
    title: 'Pagination · Masonry',
    subtitle: 'Staggered layout MasonryGrid',
    icon: Icons.view_quilt_rounded,
    gradient: [Color(0xFFee0979), Color(0xFFff6a00)],
    routePath: AppRoutePaths.paginationMasonry,
  ),
  ExampleEntry(
    title: 'Dismissible · Swipe',
    subtitle: 'Swipe to dismiss page with Hero animation',
    icon: Icons.swipe_rounded,
    gradient: [Color(0xFF667eea), Color(0xFF764ba2)],
    routePath: AppRoutePaths.dismissibleDemo,
  ),

];

class _ExampleCard extends StatefulWidget {
  const _ExampleCard({required this.entry});
  final ExampleEntry entry;

  @override
  State<_ExampleCard> createState() => _ExampleCardState();
}

class _ExampleCardState extends State<_ExampleCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final entry = widget.entry;
    return GestureDetector(
      onTap: () => context.push(entry.routePath),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final t = _controller.value;
          final angle = t * 2 * math.pi;
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.07),
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                ),
              ],
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: entry.gradient,
                transform: GradientRotation(angle),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                // Add a subtle overlay to increase text contrast
                color: Colors.black.withValues(alpha: 0.05),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(entry.icon, size: 36, color: Colors.white),
                  const SizedBox(height: 12),
                  Text(
                    entry.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    entry.subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
