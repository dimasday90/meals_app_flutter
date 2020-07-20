import 'package:flutter/material.dart';

import './pages/settings_page.dart';
import './pages/tabs_pages.dart';
import 'pages/category_meals_page.dart';
import 'pages/meal_detail_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        '/': (ctx) => TabsPage(),
        CategoryMealsPage.routeName: (ctx) => CategoryMealsPage(),
        MealDetailPage.routeName: (ctx) => MealDetailPage(),
        SettingsCart.routeName: (ctx) => SettingsCart(),
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
