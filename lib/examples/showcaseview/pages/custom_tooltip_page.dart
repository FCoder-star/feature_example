import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

/// 自定义工具提示示例
///
/// 展示如何自定义 showcase 工具提示：
/// - 使用 Showcase.withWidget 创建完全自定义的工具提示
/// - 自定义工具提示背景色、文字颜色
/// - 自定义目标形状边框
/// - 自定义工具提示位置
class CustomTooltipPage extends StatefulWidget {
  const CustomTooltipPage({super.key});

  @override
  State<CustomTooltipPage> createState() => _CustomTooltipPageState();
}

class _CustomTooltipPageState extends State<CustomTooltipPage> {
  final GlobalKey _heartKey = GlobalKey();
  final GlobalKey _starKey = GlobalKey();
  final GlobalKey _diamondKey = GlobalKey();
  final GlobalKey _customKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    ShowcaseView.register(
      blurValue: 2,
      onFinish: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('自定义工具提示展示完成！')),
        );
      },
    );

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ShowcaseView.get().startShowCase([
        _heartKey,
        _starKey,
        _diamondKey,
        _customKey,
      ]),
    );
  }

  @override
  void dispose() {
    ShowcaseView.get().unregister();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Tooltip'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '自定义工具提示示例',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              '每个按钮都有不同样式的工具提示',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 40),

            // 自定义背景色和圆形边框
            Center(
              child: Showcase(
                key: _heartKey,
                title: '喜欢',
                description: '这是一个带有自定义粉色背景的工具提示',
                tooltipBackgroundColor: Colors.pink,
                textColor: Colors.white,
                targetShapeBorder: const CircleBorder(),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Colors.pink,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.favorite, color: Colors.white, size: 40),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // 自定义圆角矩形边框
            Center(
              child: Showcase(
                key: _starKey,
                title: '收藏',
                description: '这个工具提示使用了圆角矩形边框，高亮区域与组件形状完全一致',
                tooltipBackgroundColor: Colors.amber,
                textColor: Colors.black87,
                targetShapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  width: 150,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.orange, Colors.amber],
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        '收藏',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // 菱形边框自定义
            Center(
              child: Showcase(
                key: _diamondKey,
                title: '特殊形状',
                description: '你可以使用任何 ShapeBorder 来自定义目标高亮形状',
                tooltipBackgroundColor: Colors.teal,
                textColor: Colors.white,
                targetShapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    '特殊形状按钮',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // 完全自定义的工具提示
            Center(
              child: Showcase.withWidget(
                key: _customKey,
                targetShapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                container: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 300,
                  ),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.purple, Colors.deepPurple],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withValues(alpha: 0.5),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.auto_awesome,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              '完全自定义',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        '使用 Showcase.withWidget 可以创建完全自定义的工具提示！',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => ShowcaseView.get().next(),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            '知道了',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.purple, Colors.deepPurple],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.auto_awesome, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        '完全自定义工具提示',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
