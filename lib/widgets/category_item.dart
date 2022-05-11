import 'package:flutter/material.dart';
import '../screens/category_meals_screen.dart';

// this widget is used to set up the look of
// each meal category in grid view
class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  const CategoryItem({
    Key? key,
    required this.id,
    required this.title,
    required this.color,
  }) : super(key: key);

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      CategoryMealsScreen.routeName,
      arguments: {
        'id': id,
        'title': title,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),

      // this is color of wave coming out when you tap on Category Item
      splashColor: Theme.of(context).primaryColor,

      // This border radius should be the same as border radius in below
      // container, so you can see the wave match with the size of it.
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.7),
              color,
            ],
            // Below will setup the direction of gredient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          // Below we config the round of corner for box
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
