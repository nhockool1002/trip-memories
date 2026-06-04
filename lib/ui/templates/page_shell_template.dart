import 'package:flutter/material.dart';

class PageShellTemplate extends StatelessWidget {
  const PageShellTemplate({
    required this.title,
    required this.child,
    super.key,
    this.actions = const [],
    this.floatingActionButton,
  });

  final String title;
  final Widget child;
  final List<Widget> actions;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: actions,
      ),
      body: child,
      floatingActionButton: floatingActionButton,
    );
  }
}
