import 'package:app1/pages/create_fruits_screen.dart';
import 'package:app1/pages/fruit_list_screen.dart';
import 'package:app1/pages/home_screen.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<String> routeNames = ['/', '/new_fruit', '/fruits'];
  final Map<String, Widget> _routes = {
    '/': const HomeScreen(),
    '/new_fruit': const CreateFruitsScreen(),
    '/fruits': const FruitListScreen(),
  };
  void _onTap(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
          index: _currentIndex,
          children: routeNames.map((name) => _routes[name]!).toList()),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withValues(alpha: .2),
                    width: 1))),
        child: BottomNavigationBar(
            onTap: _onTap,
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage('assets/icons/home.png'),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage('assets/icons/plus.png'),
                  ),
                  label: 'New'),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'List',
              )
            ]),
      ),
    );
  }
}
