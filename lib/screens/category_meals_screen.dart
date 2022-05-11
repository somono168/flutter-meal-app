import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> availableMeal;

  const CategoryMealsScreen({
    Key? key,
    required this.availableMeal,
  }) : super(key: key);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late String _categoryTitle;
  late List<Meal> _displayMeals;
  bool _loadedInitData = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      // ModalRoute cannot be used in initState()
      final _routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      _categoryTitle = _routeArgs['title']!;
      final _categoryId = _routeArgs['id'];
      _displayMeals = widget.availableMeal.where((meal) {
        return meal.categories.contains(_categoryId);
      }).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      _displayMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: _displayMeals[index].id,
            title: _displayMeals[index].title,
            imageUrl: _displayMeals[index].imageUrl,
            duration: _displayMeals[index].duration,
            complexity: _displayMeals[index].complexity,
            affordability: _displayMeals[index].affordability,
          );
        },
        itemCount: _displayMeals.length,
      ),
    );
  }
}
