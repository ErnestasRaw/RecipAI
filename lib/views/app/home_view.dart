import 'package:flutter/material.dart';
import 'package:receptai/components/scaffolds/app_scaffold.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      title: Text('ReceptAI'),
    );
  }
}
