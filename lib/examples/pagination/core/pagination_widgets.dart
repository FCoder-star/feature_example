import 'package:flutter/material.dart';

class AppFirstPageProgress extends StatelessWidget {
  const AppFirstPageProgress({super.key});
  @override
  Widget build(BuildContext context) =>
      const Center(child: CircularProgressIndicator());
}

class AppNewPageProgress extends StatelessWidget {
  const AppNewPageProgress({super.key});
  @override
  Widget build(BuildContext context) => const Center(
    child: Padding(
      padding: EdgeInsets.all(16),
      child: CircularProgressIndicator(),
    ),
  );
}

class AppNoItemsIndicator extends StatelessWidget {
  const AppNoItemsIndicator({super.key, this.title});
  final String? title;
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Text(title ?? '暂无数据'),
    ),
  );
}

class AppFirstPageError extends StatelessWidget {
  const AppFirstPageError({super.key, required this.onTryAgain, this.message});
  final VoidCallback onTryAgain;
  final String? message;
  @override
  Widget build(BuildContext context) => _ErrorScaffold(
    title: '加载失败',
    message: message ?? '加载首页数据出错，请重试',
    onRetry: onTryAgain,
  );
}

class AppNewPageError extends StatelessWidget {
  const AppNewPageError({super.key, required this.onTryAgain, this.message});
  final VoidCallback onTryAgain;
  final String? message;
  @override
  Widget build(BuildContext context) => _ErrorScaffold(
    title: '加载更多失败',
    message: message ?? '继续加载数据出错，请重试',
    onRetry: onTryAgain,
  );
}

class _ErrorScaffold extends StatelessWidget {
  const _ErrorScaffold({
    required this.title,
    required this.message,
    required this.onRetry,
  });
  final String title;
  final String message;
  final VoidCallback onRetry;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(24),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Text(message, textAlign: TextAlign.center),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          onPressed: onRetry,
          icon: const Icon(Icons.refresh),
          label: const Text('重试'),
        ),
      ],
    ),
  );
}
