import 'package:flutter/material.dart';
import 'router/app_routes.dart';

void main() {
  runApp(const PaginationApp());
}

class PaginationApp extends StatelessWidget {
  const PaginationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Feature Examples',
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      routerConfig: appRouter,
    );
  }
}
