import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

/// 多作用域示例
///
/// 展示如何在同一页面使用多个独立的 showcase 作用域：
/// - 每个 Tab 有独立的 showcase 序列
/// - 使用命名作用域隔离不同的 showcase
/// - 演示 ShowcaseView.getNamed() 的使用
class MultiScopePage extends StatefulWidget {
  const MultiScopePage({super.key});

  @override
  State<MultiScopePage> createState() => _MultiScopePageState();
}

class _MultiScopePageState extends State<MultiScopePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // 监听 tab 切换
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi-Scope Showcase'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: '主页', icon: Icon(Icons.home)),
            Tab(text: '设置', icon: Icon(Icons.settings)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _HomeTab(),
          _SettingsTab(),
        ],
      ),
    );
  }
}

/// 主页 Tab - 使用 'home' 作用域
class _HomeTab extends StatefulWidget {
  const _HomeTab();

  @override
  State<_HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<_HomeTab> {
  static const String scopeName = 'home';

  final GlobalKey _welcomeKey = GlobalKey();
  final GlobalKey _featuresKey = GlobalKey();
  final GlobalKey _actionKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    // 注册 'home' 作用域
    ShowcaseView.register(
      scope: scopeName,
      onFinish: () {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('主页引导完成！')),
          );
        }
      },
    );

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        if (mounted) {
          // 添加短暂延迟，确保 widget 完全渲染和布局完成
          await Future.delayed(const Duration(milliseconds: 400));
          if (mounted) {
            ShowcaseView.getNamed(scopeName).startShowCase([
              _welcomeKey,
              _featuresKey,
              _actionKey,
            ]);
          }
        }
      },
    );
  }

  @override
  void dispose() {
    ShowcaseView.getNamed(scopeName).unregister();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Showcase(
            key: _welcomeKey,
            title: '欢迎来到主页',
            description: '这是主页 Tab 的第一个引导步骤。每个 Tab 都有独立的引导序列！',
            tooltipBackgroundColor: Colors.teal,
            textColor: Colors.white,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.teal, Colors.tealAccent],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                children: [
                  Icon(Icons.home, size: 64, color: Colors.white),
                  SizedBox(height: 16),
                  Text(
                    '欢迎',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '这是主页 Tab',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Showcase(
            key: _featuresKey,
            title: '功能列表',
            description: '这里展示了主页的主要功能。注意这个引导和设置 Tab 的引导是完全独立的。',
            tooltipBackgroundColor: Colors.teal,
            textColor: Colors.white,
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '主要功能',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildFeatureItem(Icons.star, '精选内容', Colors.amber),
                    const SizedBox(height: 12),
                    _buildFeatureItem(Icons.trending_up, '热门推荐', Colors.red),
                    const SizedBox(height: 12),
                    _buildFeatureItem(Icons.new_releases, '最新发布', Colors.blue),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Showcase(
            key: _actionKey,
            title: '重新开始',
            description: '点击这个按钮可以重新播放主页的引导。',
            tooltipBackgroundColor: Colors.teal,
            textColor: Colors.white,
            child: ElevatedButton.icon(
              onPressed: () {
                ShowcaseView.getNamed(scopeName).startShowCase([
                  _welcomeKey,
                  _featuresKey,
                  _actionKey,
                ]);
              },
              icon: const Icon(Icons.replay),
              label: const Text('重新播放主页引导'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

/// 设置 Tab - 使用 'settings' 作用域
class _SettingsTab extends StatefulWidget {
  const _SettingsTab();

  @override
  State<_SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<_SettingsTab> {
  static const String scopeName = 'settings';

  final GlobalKey _headerKey = GlobalKey();
  final GlobalKey _accountKey = GlobalKey();
  final GlobalKey _privacyKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    // 注册 'settings' 作用域
    ShowcaseView.register(
      scope: scopeName,
      onFinish: () {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('设置引导完成！')),
          );
        }
      },
    );

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        if (mounted) {
          // 添加短暂延迟，确保 widget 完全渲染和布局完成
          await Future.delayed(const Duration(milliseconds: 400));
          if (mounted) {
            ShowcaseView.getNamed(scopeName).startShowCase([
              _headerKey,
              _accountKey,
              _privacyKey,
              _aboutKey,
            ]);
          }
        }
      },
    );
  }

  @override
  void dispose() {
    ShowcaseView.getNamed(scopeName).unregister();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Showcase(
            key: _headerKey,
            title: '设置中心',
            description: '这是设置 Tab 的独立引导。它和主页的引导互不影响！',
            tooltipBackgroundColor: Colors.deepPurple,
            textColor: Colors.white,
            targetShapeBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            targetPadding: const EdgeInsets.all(8),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.deepPurple, Colors.purpleAccent],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                children: [
                  Icon(Icons.settings, size: 64, color: Colors.white),
                  SizedBox(height: 16),
                  Text(
                    '设置',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '管理你的偏好设置',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Showcase(
            key: _accountKey,
            title: '账户设置',
            description: '在这里管理你的账户信息和登录选项。',
            tooltipBackgroundColor: Colors.deepPurple,
            textColor: Colors.white,
            child: _buildSettingCard(
              Icons.account_circle,
              '账户',
              '管理个人信息',
              Colors.blue,
            ),
          ),
          const SizedBox(height: 16),
          Showcase(
            key: _privacyKey,
            title: '隐私设置',
            description: '控制你的数据和隐私选项。',
            tooltipBackgroundColor: Colors.deepPurple,
            textColor: Colors.white,
            child: _buildSettingCard(
              Icons.privacy_tip,
              '隐私',
              '数据和隐私控制',
              Colors.green,
            ),
          ),
          const SizedBox(height: 16),
          Showcase(
            key: _aboutKey,
            title: '关于',
            description: '查看应用信息和版本号。',
            tooltipBackgroundColor: Colors.deepPurple,
            textColor: Colors.white,
            child: _buildSettingCard(
              Icons.info,
              '关于',
              '应用信息和帮助',
              Colors.orange,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              ShowcaseView.getNamed(scopeName).startShowCase([
                _headerKey,
                _accountKey,
                _privacyKey,
                _aboutKey,
              ]);
            },
            icon: const Icon(Icons.replay),
            label: const Text('重新播放设置引导'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingCard(
    IconData icon,
    String title,
    String subtitle,
    Color color,
  ) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }
}
