import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';

import '../models/meal.dart';

class CategoryMealsPage extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meal> availableMeals;

  CategoryMealsPage(this.availableMeals);

  @override
  _CategoryMealsPageState createState() => _CategoryMealsPageState();
}

class _CategoryMealsPageState extends State<CategoryMealsPage> {
  String _categoryTitle;
  List<Meal> _displayedMeals;
  bool _loadedInitData = false;

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      _categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      _displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  Widget _buildEmptyMealList() {
    return Center(
      child: Text(
        'No meals available due to filter results',
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildAvailableMealList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return MealItem(
          id: _displayedMeals[index].id,
          title: _displayedMeals[index].title,
          duration: _displayedMeals[index].duration,
          imageUrl: _displayedMeals[index].imageUrl,
          complexity: _displayedMeals[index].complexity,
          affordability: _displayedMeals[index].affordability,
        );
      },
      itemCount: _displayedMeals.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_categoryTitle),
      ),
      body: SafeArea(
        child: _displayedMeals.isEmpty
            ? _buildEmptyMealList()
            : _buildAvailableMealList(),
      ),
    );
  }
}
