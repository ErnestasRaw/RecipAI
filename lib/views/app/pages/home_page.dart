import 'package:flutter/material.dart';
import 'package:receptai/components/theme/sizes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: Sizes.pageMargins,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StyledCard(
              child: Text('a'),
            ),
          ],
        ),
      ),
    );
  }
}

class StyledCard extends StatelessWidget {
  final Widget child;
  const StyledCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            child: Card(
              child: Padding(
                padding: Sizes.boxMargins,
                child: child,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
