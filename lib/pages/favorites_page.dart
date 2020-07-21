import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';

import '../models/meal.dart';

class FavoritesPage extends StatefulWidget {
  final List<Meal> favoritedMeals;

  FavoritesPage({this.favoritedMeals});

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Meal> _favorites = [];
  // bool _loadedInitData = false;

  @override
  void initState() {
    _favorites = widget.favoritedMeals;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _favorites = widget.favoritedMeals;
    super.didChangeDependencies();
  }

  Widget _buildEmptyFavorites() {
    return Center(
      child: Text(
        'No favorites available - start adding some!',
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildFavoriteMealsList() {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return MealItem(
          id: _favorites[index].id,
          title: _favorites[index].title,
          duration: _favorites[index].duration,
          imageUrl: _favorites[index].imageUrl,
          complexity: _favorites[index].complexity,
          affordability: _favorites[index].affordability,
        );
      },
      itemCount: _favorites.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _favorites.isEmpty
          ? _buildEmptyFavorites()
          : _buildFavoriteMealsList(),
    );
  }
}
