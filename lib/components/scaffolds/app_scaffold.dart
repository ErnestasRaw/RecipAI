import 'package:flutter/material.dart';
import 'package:receptai/controllers/routing/navigator_utils.dart';

import 'app_drawer.dart';

class AppScaffold extends StatelessWidget {
  final Widget? child;
  final bool hasDrawer;
  final Widget? title;
  final bool? haveSyncButton;

  const AppScaffold({
    Key? key,
    this.child,
    this.title,
    this.haveSyncButton = true,
    this.hasDrawer = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: title ??
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('ReceptAI'),
            ),
      ),
      drawer: hasDrawer ? const AppDrawer() : null,
      body: child,
    );
  }
}
