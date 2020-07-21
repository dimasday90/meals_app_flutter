import 'package:flutter/material.dart';

import './categories_meals_data.dart';

import './pages/settings_page.dart';
import './pages/tabs_pages.dart';
import './pages/category_meals_page.dart';
import './pages/meal_detail_page.dart';

import './models/meal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'glutten-free': false,
    'lactose-free': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoritedMeals = [];

  void _changeFilters(Map<String, bool> newFilters) {
    setState(() {
      _filters = newFilters;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten-free'] == true && meal.isGlutenFree == false ||
            _filters['lactose-free'] == true && meal.isLactoseFree == false ||
            _filters['vegan'] == true && meal.isVegan == false ||
            _filters['vegetarian'] == true && meal.isVegetarian == false) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoritedMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoritedMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoritedMeals
            .add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String mealId) {
    return _favoritedMeals.any((meal) => meal.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meals App',
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.amberAccent[400],
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline4: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoCondensed'),
              headline6: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.w700,
              ),
            ),
      ),
      // home: CategoriesPage(),
      initialRoute: '/', // default route is '/'
      routes: {
        '/': (ctx) => TabsPage(
              favoritedMeals: _favoritedMeals,
            ),
        CategoryMealsPage.routeName: (ctx) =>
            CategoryMealsPage(_availableMeals),
        MealDetailPage.routeName: (ctx) => MealDetailPage(
              toggleFavorite: _toggleFavorite,
              isFavorite: _isMealFavorite,
            ),
        SettingsCart.routeName: (ctx) => SettingsCart(
              filters: _filters,
              filtersHandler: _changeFilters,
            ),
      },
      onGenerateRoute: (settings) {
        //* for debugging purpose, to reveal current route's settings
        print(settings);
        //* Nothing to configure regarding unlisted routes, hence returns nothing
        return;
      },
      onUnknownRoute: (settings) {
        //* returns default page when no routes are available or onGenerateRoute does not resolve a right page
        return MaterialPageRoute(
          builder: (ctx) => TabsPage(),
        );
      },
    );
  }
}
