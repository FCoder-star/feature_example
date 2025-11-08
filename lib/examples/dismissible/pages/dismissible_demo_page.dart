import 'dart:io';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';

// 仅用于开发测试：自定义HttpOverrides禁用SSL证书验证
class _DevHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class DismissibleDemoPage extends StatefulWidget {
  const DismissibleDemoPage({super.key});

  @override
  State<DismissibleDemoPage> createState() => _DismissibleDemoPageState();
}

class _DismissibleDemoPageState extends State<DismissibleDemoPage> {
  @override
  void initState() {
    super.initState();
    // 仅用于开发测试：禁用SSL证书验证
    HttpOverrides.global = _DevHttpOverrides();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dismissible Page · Demo')),
      body: SafeArea(
        child: GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 1,
          ),
          itemCount: 20,
          itemBuilder: (context, index) {
            return _ImageCard(index: index);
          },
        ),
      ),
    );
  }
}

class _ImageCard extends StatelessWidget {
  const _ImageCard({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'image_$index',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            context.pushTransparentRoute(
              _DetailPage(index: index),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              'https://picsum.photos/500/500?random=$index',
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: Colors.grey[300],
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.error_outline, color: Colors.grey),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _DetailPage extends StatelessWidget {
  const _DetailPage({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return DismissiblePage(
      onDismissed: () => Navigator.of(context).pop(),
      direction: DismissiblePageDismissDirection.multi,
      backgroundColor: Colors.black,
      isFullScreen: true,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Hero(
            tag: 'image_$index',
            child: Image.network(
              'https://picsum.photos/500/500?random=$index',
              fit: BoxFit.contain,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.error_outline,
                  color: Colors.white,
                  size: 64,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}


