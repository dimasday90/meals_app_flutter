import 'package:flutter/material.dart';

import '../models/meal.dart';

import '../categories_meals_data.dart';

class MealDetailPage extends StatelessWidget {
  static const routeName = '/meal-detail';
  final Function toggleFavorite;
  final Function isFavorite;

  MealDetailPage({
    this.toggleFavorite,
    this.isFavorite,
  });

  Widget buildSliverAppBar(
      MediaQueryData mediaQuery, String mealId, Meal selectedMeal) {
    return SliverAppBar(
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
  }

  Widget buildSliverGrid(List<Widget> list) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Card(
            elevation: 4,
            child: Container(
              alignment: Alignment.center,
              child: list[index],
            ),
          );
        },
        childCount: list.length,
      ),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300,
        childAspectRatio: 6 / 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }

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

  String complexityText(Complexity complexity) {
    switch (complexity) {
      case Complexity.Simple:
        return 'Simple';
      case Complexity.Challenging:
        return 'Challenging';
      case Complexity.Hard:
        return 'Hard';
      default:
        return 'Unknown';
    }
  }

  String affordabilityText(Affordability affordability) {
    switch (affordability) {
      case Affordability.Affordable:
        return 'Affordable';
      case Affordability.Pricey:
        return 'Pricey';
      case Affordability.Luxurious:
        return 'Luxurious';
      default:
        return 'Unknown';
    }
  }

  List<String> mealTypes(Meal meal) {
    List<String> result = [];
    if (meal.isGlutenFree) {
      result.add('Glutten-free');
    }
    if (meal.isLactoseFree) {
      result.add('Lactose-free');
    }
    if (meal.isVegan) {
      result.add('Vegan');
    }
    if (meal.isVegetarian) {
      result.add('Vegetarian');
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData mainTheme = Theme.of(context);
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    final List<Widget> detailContents = [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.schedule),
          SizedBox(
            width: 10,
          ),
          Text('${selectedMeal.duration} min')
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.work),
          SizedBox(
            width: 10,
          ),
          Text(
            complexityText(
              selectedMeal.complexity,
            ),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.attach_money),
          SizedBox(
            width: 10,
          ),
          Text(
            affordabilityText(
              selectedMeal.affordability,
            ),
          ),
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: mealTypes(selectedMeal).length > 0
            ? mealTypes(selectedMeal).map((type) {
                return Text(type);
              }).toList()
            : [
                Text('Unavailable'),
              ],
      ),
    ];

    return Scaffold(
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: <Widget>[
            buildSliverAppBar(mediaQuery, mealId, selectedMeal),
            buildSliverGrid(detailContents),
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
