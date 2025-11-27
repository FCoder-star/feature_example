import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

/// 自动播放示例
///
/// 展示如何使用自动播放功能：
/// - 设置 autoPlay 为 true
/// - 配置 autoPlayDelay 延迟时间
/// - 自动循环播放所有 showcase
class AutoPlayShowcasePage extends StatefulWidget {
  const AutoPlayShowcasePage({super.key});

  @override
  State<AutoPlayShowcasePage> createState() => _AutoPlayShowcasePageState();
}

class _AutoPlayShowcasePageState extends State<AutoPlayShowcasePage> {
  final GlobalKey _step1Key = GlobalKey();
  final GlobalKey _step2Key = GlobalKey();
  final GlobalKey _step3Key = GlobalKey();
  final GlobalKey _step4Key = GlobalKey();

  bool _isAutoPlay = true;
  int _delaySeconds = 2;
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();

    _registerShowcase();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _startShowcase(),
    );
  }

  void _registerShowcase() {
    ShowcaseView.register(
      autoPlay: _isAutoPlay,
      autoPlayDelay: Duration(seconds: _delaySeconds),
      onStart: (index, key) {
        setState(() => _currentStep = index??0);
        debugPrint('开始播放步骤 ${(index ??0)+ 1}');
      },
      onComplete: (index, key) {
        debugPrint('完成步骤 ${(index??0) + 1}');
      },
      onFinish: () {
        setState(() => _currentStep = 0);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('自动播放完成！'),
            duration: Duration(seconds: 2),
          ),
        );
      },
    );
  }

  void _startShowcase() {
    ShowcaseView.get().startShowCase([
      _step1Key,
      _step2Key,
      _step3Key,
      _step4Key,
    ]);
  }

  void _updateSettings() {
    // 直接更新 ShowcaseView 的属性，而不是重新注册
    final showcaseView = ShowcaseView.get();
    showcaseView.autoPlay = _isAutoPlay;
    showcaseView.autoPlayDelay = Duration(seconds: _delaySeconds);

    // 重新启动 showcase
    _startShowcase();
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
        title: const Text('Auto Play Showcase'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 标题
            const Text(
              '自动播放示例',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Showcase 会自动按顺序播放，无需手动点击',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // 当前步骤指示器
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.indigo.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.indigo.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  const Text(
                    '当前步骤',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${_currentStep + 1} / 4',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: (_currentStep + 1) / 4,
                    backgroundColor: Colors.grey.withValues(alpha: 0.2),
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.indigo),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 设置卡片
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '播放设置',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      title: const Text('启用自动播放'),
                      subtitle: const Text('自动切换到下一个步骤'),
                      value: _isAutoPlay,
                      onChanged: (value) {
                        setState(() => _isAutoPlay = value);
                      },
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text('延迟时间'),
                      subtitle: Text('每个步骤显示 $_delaySeconds 秒'),
                      trailing: SizedBox(
                        width: 150,
                        child: Slider(
                          value: _delaySeconds.toDouble(),
                          min: 1,
                          max: 5,
                          divisions: 4,
                          label: '$_delaySeconds 秒',
                          onChanged: (value) {
                            setState(() => _delaySeconds = value.toInt());
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _updateSettings,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('应用设置并重新开始'),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // 步骤卡片
            Showcase(
              key: _step1Key,
              title: '步骤 1',
              description: '这是第一个自动播放的步骤。请注意观察，它会自动切换到下一步。',
              tooltipBackgroundColor: Colors.blue,
              textColor: Colors.white,
              child: _buildStepCard(
                number: 1,
                title: '欢迎',
                icon: Icons.waving_hand,
                color: Colors.blue,
              ),
            ),

            const SizedBox(height: 16),

            Showcase(
              key: _step2Key,
              title: '步骤 2',
              description: '第二步会在 $_delaySeconds 秒后自动显示。你不需要点击任何按钮！',
              tooltipBackgroundColor: Colors.green,
              textColor: Colors.white,
              child: _buildStepCard(
                number: 2,
                title: '学习',
                icon: Icons.school,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 16),

            Showcase(
              key: _step3Key,
              title: '步骤 3',
              description: '自动播放让用户体验更流畅，不需要频繁点击。',
              tooltipBackgroundColor: Colors.orange,
              textColor: Colors.white,
              child: _buildStepCard(
                number: 3,
                title: '探索',
                icon: Icons.explore,
                color: Colors.orange,
              ),
            ),

            const SizedBox(height: 16),

            Showcase(
              key: _step4Key,
              title: '步骤 4',
              description: '这是最后一步。完成后你可以调整设置重新体验！',
              tooltipBackgroundColor: Colors.purple,
              textColor: Colors.white,
              child: _buildStepCard(
                number: 4,
                title: '完成',
                icon: Icons.check_circle,
                color: Colors.purple,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepCard({
    required int number,
    required String title,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color,
            color.withValues(alpha: 0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '步骤 $number',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                '$number',
                style: TextStyle(
                  color: color,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
