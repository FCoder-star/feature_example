import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../router/app_routes.dart';

/// Showcaseview 示例索引页
///
/// 展示所有 showcaseview 的使用示例
class ShowcaseIndexPage extends StatelessWidget {
  const ShowcaseIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 自定义 AppBar
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Showcaseview',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFF11998e),
                      const Color(0xFF38ef7d),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    // 装饰性图案
                    Positioned(
                      right: -50,
                      top: -50,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.1),
                        ),
                      ),
                    ),
                    Positioned(
                      left: -30,
                      bottom: -30,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.1),
                        ),
                      ),
                    ),
                    // 中心图标
                    const Center(
                      child: Icon(
                        Icons.lightbulb_outline,
                        size: 80,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 介绍卡片
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF11998e).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.info_outline,
                              color: Color(0xFF11998e),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            '关于 Showcaseview',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Showcaseview 是一个用于创建交互式 UI 教程的 Flutter 库。'
                        '它可以帮助你高亮显示应用中的特定元素，并为用户提供分步引导。',
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.6,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _buildFeatureChip('分步高亮', Icons.highlight),
                          _buildFeatureChip('自定义样式', Icons.palette),
                          _buildFeatureChip('自动播放', Icons.play_circle),
                          _buildFeatureChip('多作用域', Icons.layers),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 示例列表
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text(
                    '示例列表',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ..._showcaseExamples.map((example) => _ExampleTile(example: example)),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureChip(String label, IconData icon) {
    return Chip(
      avatar: Icon(icon, size: 16, color: const Color(0xFF11998e)),
      label: Text(
        label,
        style: const TextStyle(fontSize: 12),
      ),
      backgroundColor: const Color(0xFF11998e).withValues(alpha: 0.1),
      side: BorderSide.none,
    );
  }
}

class ShowcaseExample {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final String routePath;
  final List<String> features;

  const ShowcaseExample({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.routePath,
    required this.features,
  });
}

const _showcaseExamples = <ShowcaseExample>[
  ShowcaseExample(
    title: 'Basic Showcase',
    description: '学习 showcaseview 的基础用法，包括注册、包装目标 widget 和启动引导序列',
    icon: Icons.lightbulb_outline,
    color: Color(0xFF11998e),
    routePath: AppRoutePaths.showcaseBasic,
    features: ['基础注册', '目标高亮', '工具提示', '回调处理'],
  ),
  ShowcaseExample(
    title: 'Custom Tooltip',
    description: '探索如何自定义工具提示的样式，包括背景色、形状、位置和完全自定义的内容',
    icon: Icons.auto_awesome,
    color: Color(0xFFa8edea),
    routePath: AppRoutePaths.showcaseCustomTooltip,
    features: ['自定义颜色', '自定义形状', '自定义位置', '完全自定义'],
  ),
  ShowcaseExample(
    title: 'Auto Play',
    description: '体验自动播放功能，showcase 会按照设定的延迟时间自动切换到下一步',
    icon: Icons.play_circle_outline,
    color: Color(0xFF4facfe),
    routePath: AppRoutePaths.showcaseAutoPlay,
    features: ['自动播放', '延迟设置', '进度显示', '动态配置'],
  ),
  ShowcaseExample(
    title: 'Multi-Scope',
    description: '了解如何在同一应用中使用多个独立的 showcase 作用域，适用于多页面场景',
    icon: Icons.tab,
    color: Color(0xFF43e97b),
    routePath: AppRoutePaths.showcaseMultiScope,
    features: ['命名作用域', '独立序列', 'Tab 切换', '作用域隔离'],
  ),
];

class _ExampleTile extends StatelessWidget {
  const _ExampleTile({required this.example});

  final ShowcaseExample example;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () => context.push(example.routePath),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 图标
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: example.color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  example.icon,
                  color: example.color,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              // 内容
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      example.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      example.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: example.features
                          .map((feature) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: example.color.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  feature,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: example.color,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
              // 箭头
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
