import 'package:flutter/material.dart';

class GridFirstPageProgress extends StatelessWidget {
  const GridFirstPageProgress({super.key});
  @override
  Widget build(BuildContext context) => const Center(
    child: SizedBox(
      width: 28,
      height: 28,
      child: CircularProgressIndicator(strokeWidth: 2.8),
    ),
  );
}

class GridNewPageProgress extends StatelessWidget {
  const GridNewPageProgress({super.key});
  @override
  Widget build(BuildContext context) => const Center(
    child: Padding(
      padding: EdgeInsets.all(8),
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(strokeWidth: 2.5),
      ),
    ),
  );
}

class GridNoItemsIndicator extends StatelessWidget {
  const GridNoItemsIndicator({super.key});
  @override
  Widget build(BuildContext context) => const Center(
    child: Padding(padding: EdgeInsets.all(16), child: Text('暂无数据')),
  );
}

class GridFirstPageError extends StatelessWidget {
  const GridFirstPageError({super.key, required this.onTryAgain});
  final VoidCallback onTryAgain;
  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('加载失败'),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: onTryAgain,
          icon: const Icon(Icons.refresh),
          label: const Text('重试'),
        ),
      ],
    ),
  );
}

class GridNewPageError extends StatelessWidget {
  const GridNewPageError({super.key, required this.onTryAgain});
  final VoidCallback onTryAgain;
  @override
  Widget build(BuildContext context) => Center(
    child: IconButton(
      onPressed: onTryAgain,
      icon: const Icon(Icons.refresh),
      tooltip: '重试',
    ),
  );
}
