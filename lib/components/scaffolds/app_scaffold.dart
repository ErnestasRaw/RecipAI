import 'package:flutter/material.dart';
import 'package:receptai/components/theme/palette.dart';
import 'package:receptai/views/app/pages/favorites_page.dart';
import 'package:receptai/views/app/pages/generator_page.dart';
import 'package:receptai/views/app/pages/profile_page.dart';

import 'app_drawer.dart';

class AppScaffold extends StatefulWidget {
  final Widget? title;

  const AppScaffold({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final List<Widget> _widgetOptions = <Widget>[
    // const HomePage(),
    const GeneratorPage(),
    const FavoritesPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: widget.title ??
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('ReceptAI'),
            ),
      ),
      drawer: const AppDrawer(),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.generating_tokens),
            label: 'Generatorius',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Mėgstamiausi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profilis',
          ),
        ],
        selectedItemColor: Palette.seedColor,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, color: Palette.seedColor),
        unselectedItemColor: Palette.grey,
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, color: Palette.grey),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
