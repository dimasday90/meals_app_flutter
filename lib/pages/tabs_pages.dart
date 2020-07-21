import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

import './favorites_page.dart';
import './categories_page.dart';

import '../models/meal.dart';

class TabsPage extends StatefulWidget {
  final List<Meal> favoritedMeals;

  TabsPage({this.favoritedMeals});

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': CategoriesPage(),
        'title': 'Meals',
      },
      {
        'page': FavoritesPage(
          favoritedMeals: widget.favoritedMeals,
        ),
        'title': 'Favorites',
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData mainTheme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      body: _pages[_selectedPageIndex]['page'],
      drawer: MainDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        unselectedItemColor: Colors.white,
        selectedItemColor: mainTheme.accentColor,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text('Categories'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text('Favorites'),
          )
        ],
        backgroundColor: mainTheme.primaryColor,
      ),
    );
  }
}
