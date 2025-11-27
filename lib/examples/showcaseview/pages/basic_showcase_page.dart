import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

/// 基础 Showcase 示例
///
/// 展示 showcaseview 的基本用法：
/// - 注册 ShowcaseView
/// - 使用 GlobalKey 标识目标 widget
/// - 用 Showcase widget 包装目标
/// - 启动 showcase 序列
class BasicShowcasePage extends StatefulWidget {
  const BasicShowcasePage({super.key});

  @override
  State<BasicShowcasePage> createState() => _BasicShowcasePageState();
}

class _BasicShowcasePageState extends State<BasicShowcasePage> {
  // 定义 GlobalKeys 用于标识 showcase 目标
  final GlobalKey _menuKey = GlobalKey();
  final GlobalKey _searchKey = GlobalKey();
  final GlobalKey _profileKey = GlobalKey();
  final GlobalKey _fabKey = GlobalKey();
  final GlobalKey _settingsKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    // 注册 ShowcaseView
    ShowcaseView.register(
      onFinish: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Showcase 完成！'),
            duration: Duration(seconds: 2),
          ),
        );
      },
      onStart: (index, key) {
        debugPrint('Showcase $index 开始');
      },
      onComplete: (index, key) {
        debugPrint('Showcase $index 完成');
      },
    );

    // 页面加载后自动启动 showcase
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ShowcaseView.get().startShowCase([
        _menuKey,
        _searchKey,
        _profileKey,
        _fabKey,
        _settingsKey,
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
        title: const Text('Basic Showcase'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: Showcase(
          key: _menuKey,
          title: '菜单',
          description: '点击这里返回主页',
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        actions: [
          Showcase(
            key: _searchKey,
            title: '搜索',
            description: '点击这里搜索内容',
            targetShapeBorder: const CircleBorder(),
            child: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
          ),
          Showcase(
            key: _profileKey,
            title: '个人资料',
            description: '查看和编辑你的个人资料',
            targetShapeBorder: const CircleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: const Icon(Icons.person, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lightbulb_outline, size: 80, color: Colors.amber),
            const SizedBox(height: 20),
            const Text(
              '欢迎来到 Showcase 基础示例',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                '这个示例展示了如何使用基本的 showcase 功能来引导用户了解应用界面',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 40),
            Showcase(
              key: _settingsKey,
              title: '重新开始',
              description: '点击这个按钮可以重新播放引导',
              child: ElevatedButton.icon(
                onPressed: () {
                  ShowcaseView.get().startShowCase([
                    _menuKey,
                    _searchKey,
                    _profileKey,
                    _fabKey,
                    _settingsKey,
                  ]);
                },
                icon: const Icon(Icons.replay),
                label: const Text('重新播放引导'),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Showcase(
        key: _fabKey,
        title: '添加',
        description: '点击这里添加新项目',
        targetShapeBorder: const CircleBorder(),
        child: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
