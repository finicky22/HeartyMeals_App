import 'package:flutter/material.dart';
import './models/meal.dart';
import './widgets/dummy_data.dart';
import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import 'screens/categories_meals_screen.dart';
import 'screens/categories_screen_dart.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
  'gluten': false,
  'lactose': false,
  'vegan': false,
  'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favMeals = DUMMY_MEALS;

  void _setFilters(Map<String, bool> filterData){
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if(_filters['gluten'] && !meal.isGlutenFree){
          return false;
        }
        if(_filters['lactose'] && !meal.isLactoseFree){
          return false;
        }
        if(_filters['Vegan'] && !meal.isVegan){
          return false;
        }
        if(_filters['vegetarain'] && !meal.isVegetarian){
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavourite(String mealId){
    final existingIndex = _favMeals.indexWhere((meal) => meal.id == mealId);
    if(existingIndex >= 0){
      setState(() {
        _favMeals.removeAt(existingIndex);
      });
    }else{
      setState(() {
        DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
      });
    }
  }

  bool _isMealFav(String id){
    return _favMeals.any((meal) => meal.id == id);
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        accentColor: Colors.black,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: TextStyle(
                fontSize: 24,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      //home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabScreen(_favMeals),
        CategoriesMealsScreen.RouteName: (ctx) => CategoriesMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_isMealFav,_toggleFavourite),
        FilterScreen.routeName: (ctx) => FilterScreen(_filters,_setFilters),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => CategoriesScreen(),
        );
      },
    );
  }
}

