import 'package:flutter/material.dart';
import 'package:receptai/components/scaffolds/app_scaffold.dart';
import 'package:receptai/components/theme/styles.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('HOME SCREEN'),
            Text(
              '0',
              style: Styles.titleAg25Semi(),
            ),
          ],
        ),
      ),
    );
  }
}
