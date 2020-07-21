import 'package:flutter/material.dart';

import '../categories_meals_data.dart';

class MealDetailPage extends StatelessWidget {
  static const routeName = '/meal-detail';
  final Function toggleFavorite;
  final Function isFavorite;

  MealDetailPage({
    this.toggleFavorite,
    this.isFavorite,
  });

  Widget buildSliverSubHeadline(ThemeData mainTheme, String title) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Text(
          title,
          style: mainTheme.textTheme.headline4,
        ),
      ),
    );
  }

  Widget buildSliverList(ThemeData mainTheme, List<String> list, String type) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(
              vertical: 2,
              horizontal: 15,
            ),
            child: Text(
              type == 'step' ? '${index + 1}. ${list[index]}' : list[index],
              style: mainTheme.textTheme.headline6,
            ),
          );
        },
        childCount: list.length,
      ),
    );
  }

  Widget buildSliverSizedBox(
      MediaQueryData mediaQuery, double heightPercentage) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: mediaQuery.size.height * heightPercentage,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData mainTheme = Theme.of(context);
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    final sliverAppBar = SliverAppBar(
      expandedHeight: mediaQuery.size.height * 0.33,
      floating: false,
      pinned: true,
      snap: false,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          selectedMeal.title,
          overflow: TextOverflow.fade,
          softWrap: true,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        background: Image.network(
          selectedMeal.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            isFavorite(mealId) ? Icons.star : Icons.star_border,
          ),
          onPressed: () => toggleFavorite(mealId),
          tooltip: 'Add to favorites',
        ),
      ],
    );

    return Scaffold(
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: <Widget>[
            sliverAppBar,
            buildSliverSubHeadline(mainTheme, 'Ingredients:'),
            buildSliverList(mainTheme, selectedMeal.ingredients, 'ingredient'),
            buildSliverSizedBox(mediaQuery, 0.03),
            buildSliverSubHeadline(mainTheme, 'Steps:'),
            buildSliverList(mainTheme, selectedMeal.steps, 'step'),
            buildSliverSizedBox(mediaQuery, 0.06)
          ],
        ),
      ),
    );
  }
}
