import 'package:flutter/material.dart';
import 'package:meap_app/widgets/meal_detail_item.dart';
import './dummy_data.dart';
import './models/meal.dart';
import './screens/settings_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/categories_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _settings = {
    'gluten': false,
    'lactos': false,
    'vegen': false,
    'vegetarian': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setSettings(Map<String, bool> settingsData) {
    setState(() {
      _settings = settingsData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_settings['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (_settings['lactos']! && !meal.isLactoseFree) {
          return false;
        }
        if (_settings['vegen']! && !meal.isVegan) {
          return false;
        }
        if (_settings['vegetarian']! && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    // if mealId not exist, then existingIndex value = -1
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0) {
      // if it exist in Favorite meal, then remove it.
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      // if not exist, then add to favorite meal.
      setState(() {
        _favoriteMeals.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
        );
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        // Define the default brightness and colors.
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),

        // Define the default font family.
        fontFamily: 'Raleway',

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: ThemeData.light().textTheme.copyWith(
              headline1: const TextStyle(
                fontSize: 72.0,
                fontWeight: FontWeight.bold,
              ),
              headline5: const TextStyle(
                fontSize: 24,
              ),
              headline6: const TextStyle(
                fontSize: 24,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
              bodyText1: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
            ),
      ),
      //home: const CategoriesScreen(),
      initialRoute: '/', // default is '/'
      routes: {
        '/': (ctx) => TabsScreen(favoriteMeals: _favoriteMeals), // Home Screen
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(availableMeal: _availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(
              toggleFavorite: _toggleFavorite,
              isFavorite: _isMealFavorite,
            ),
        SettingsScreen.routeName: (context) => SettingsScreen(
              currentSettings: _settings,
              saveSettings: _setSettings,
            ),
      },
      // onGenerateRoute: (settings) {
      //   print(settings.arguments);
      //   return MaterialPageRoute(builder: (ctx) => const CategoriesScreen());
      // },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => const CategoriesScreen());
      },
    );
  }
}
