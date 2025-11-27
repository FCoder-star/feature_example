import 'package:flutter/material.dart';

/// 科技感背景组件
class TechBackground extends StatelessWidget {
  const TechBackground({
    super.key,
    required this.child,
    this.variant = TechBackgroundVariant.primary,
  });

  final Widget child;
  final TechBackgroundVariant variant;

  @override
  Widget build(BuildContext context) {
    final colors = variant.colors;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
      ),
      child: Stack(
        children: [
          // Grid pattern
          CustomPaint(
            painter: _SubtleGridPainter(
              color: variant.gridColor,
            ),
            size: Size.infinite,
          ),
          // Content
          child,
        ],
      ),
    );
  }
}

enum TechBackgroundVariant {
  primary,   // 主页深蓝紫
  cyan,      // 青色系
  purple,    // 紫色系
  green,     // 绿色系
}

extension on TechBackgroundVariant {
  List<Color> get colors {
    switch (this) {
      case TechBackgroundVariant.primary:
        return const [
          Color(0xFF0F0F23),
          Color(0xFF1A1A3E),
          Color(0xFF0D1B2A),
        ];
      case TechBackgroundVariant.cyan:
        return const [
          Color(0xFF0A1628),
          Color(0xFF0D2137),
          Color(0xFF0F2847),
        ];
      case TechBackgroundVariant.purple:
        return const [
          Color(0xFF1A0A2E),
          Color(0xFF16132D),
          Color(0xFF0F0F23),
        ];
      case TechBackgroundVariant.green:
        return const [
          Color(0xFF0A1A14),
          Color(0xFF0D2118),
          Color(0xFF0F281C),
        ];
    }
  }

  Color get gridColor {
    switch (this) {
      case TechBackgroundVariant.primary:
        return const Color(0xFF00D4FF);
      case TechBackgroundVariant.cyan:
        return const Color(0xFF00D4FF);
      case TechBackgroundVariant.purple:
        return const Color(0xFF8B5CF6);
      case TechBackgroundVariant.green:
        return const Color(0xFF00FF87);
    }
  }
}

class _SubtleGridPainter extends CustomPainter {
  _SubtleGridPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.03)
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    const spacing = 50.0;
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

/// 科技感 AppBar 样式
class TechAppBarTheme {
  static AppBar build({
    required String title,
    List<Color>? gradientColors,
    List<Widget>? actions,
    Widget? leading,
    bool automaticallyImplyLeading = true,
  }) {
    final colors = gradientColors ?? const [
      Color(0xFF6366F1),
      Color(0xFF8B5CF6),
    ];

    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
          color: Colors.white,
        ),
      ),
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: actions,
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: colors.map((c) => c.withValues(alpha: 0.95)).toList(),
          ),
          boxShadow: [
            BoxShadow(
              color: colors.first.withValues(alpha: 0.3),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
      ),
    );
  }
}

/// 科技感 Scaffold
class TechScaffold extends StatelessWidget {
  const TechScaffold({
    super.key,
    required this.title,
    required this.body,
    this.variant = TechBackgroundVariant.cyan,
    this.gradientColors,
    this.actions,
    this.floatingActionButton,
  });

  final String title;
  final Widget body;
  final TechBackgroundVariant variant;
  final List<Color>? gradientColors;
  final List<Widget>? actions;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: TechAppBarTheme.build(
        title: title,
        gradientColors: gradientColors,
        actions: actions,
      ),
      floatingActionButton: floatingActionButton,
      body: TechBackground(
        variant: variant,
        child: SafeArea(child: body),
      ),
    );
  }
}
