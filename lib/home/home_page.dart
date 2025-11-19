import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../router/app_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _bgController;

  @override
  void initState() {
    super.initState();
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _bgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final entries = _demoEntries;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Feature Examples',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF6366F1).withValues(alpha: 0.95),
                const Color(0xFF8B5CF6).withValues(alpha: 0.9),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6366F1).withValues(alpha: 0.4),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
        ),
      ),
      body: AnimatedBuilder(
        animation: _bgController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: const [
                  Color(0xFF0F0F23),
                  Color(0xFF1A1A3E),
                  Color(0xFF0D1B2A),
                ],
                stops: [
                  0.0,
                  0.5 + 0.2 * math.sin(_bgController.value * 2 * math.pi),
                  1.0,
                ],
              ),
            ),
            child: child,
          );
        },
        child: Stack(
          children: [
            // Animated grid pattern overlay
            CustomPaint(
              painter: _GridPatternPainter(),
              size: Size.infinite,
            ),
            // Floating particles effect
            ...List.generate(6, (index) => _FloatingOrb(index: index)),
            // Main content
            SafeArea(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                itemCount: entries.length,
                separatorBuilder: (_, __) => const SizedBox(height: 20),
                itemBuilder: (context, index) =>
                    _ExampleCard(entry: entries[index], index: index),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GridPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00D4FF).withValues(alpha: 0.03)
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    const spacing = 40.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _FloatingOrb extends StatefulWidget {
  const _FloatingOrb({required this.index});
  final int index;

  @override
  State<_FloatingOrb> createState() => _FloatingOrbState();
}

class _FloatingOrbState extends State<_FloatingOrb>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 8 + widget.index * 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final colors = [
      const Color(0xFF00D4FF),
      const Color(0xFF7B2FFF),
      const Color(0xFFFF006E),
      const Color(0xFF00FF87),
      const Color(0xFFFFBE0B),
      const Color(0xFF8338EC),
    ];

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final t = _controller.value * 2 * math.pi;
        final offsetX = math.sin(t + widget.index) * 30;
        final offsetY = math.cos(t + widget.index * 0.5) * 20;

        return Positioned(
          left: (widget.index * size.width / 6) + offsetX,
          top: (widget.index * size.height / 8) + offsetY + 100,
          child: Container(
            width: 60 + widget.index * 10.0,
            height: 60 + widget.index * 10.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  colors[widget.index % colors.length].withValues(alpha: 0.15),
                  colors[widget.index % colors.length].withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        );
      },
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
  const _ExampleCard({required this.entry, required this.index});
  final ExampleEntry entry;
  final int index;

  @override
  State<_ExampleCard> createState() => _ExampleCardState();
}

class _ExampleCardState extends State<_ExampleCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
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
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: () => context.push(entry.routePath),
      child: AnimatedScale(
        scale: _isPressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final t = _controller.value;
            final angle = t * 2 * math.pi;

            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  // Glow effect
                  BoxShadow(
                    color: entry.gradient[0].withValues(alpha: 0.4),
                    blurRadius: 20,
                    spreadRadius: -5,
                    offset: const Offset(0, 10),
                  ),
                  BoxShadow(
                    color: entry.gradient[1].withValues(alpha: 0.3),
                    blurRadius: 30,
                    spreadRadius: -10,
                    offset: const Offset(0, 15),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    // Animated gradient background
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            entry.gradient[0],
                            Color.lerp(entry.gradient[0], entry.gradient[1],
                                0.5 + 0.3 * math.sin(angle))!,
                            entry.gradient[1],
                          ],
                          transform: GradientRotation(angle * 0.5),
                        ),
                      ),
                    ),
                    // Glass morphism overlay
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withValues(alpha: 0.2),
                            Colors.white.withValues(alpha: 0.05),
                            Colors.black.withValues(alpha: 0.1),
                          ],
                        ),
                      ),
                    ),
                    // Animated shine effect
                    Positioned(
                      left: -100 + (200 * t),
                      top: 0,
                      bottom: 0,
                      width: 100,
                      child: Transform.rotate(
                        angle: -0.5,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withValues(alpha: 0.0),
                                Colors.white.withValues(alpha: 0.15),
                                Colors.white.withValues(alpha: 0.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Border glow
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2),
                          width: 1.5,
                        ),
                      ),
                    ),
                    // Content
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          // Icon with animated glow
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.3),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      Colors.white.withValues(alpha: 0.1 + 0.1 * math.sin(angle)),
                                  blurRadius: 15,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Icon(
                              entry.icon,
                              size: 28,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Text content
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  entry.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  entry.subtitle,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.85),
                                    fontSize: 13,
                                    height: 1.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Arrow indicator
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 16,
                              color: Colors.white.withValues(alpha: 0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
