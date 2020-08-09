import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

import '../widgets/dummy_data.dart';

class CategoriesMealsScreen extends StatefulWidget {
  static const RouteName = '/category-meals';

  final List<Meal> availableMeals;

  CategoriesMealsScreen(this.availableMeals);

  @override
  _CategoriesMealsScreenState createState() => _CategoriesMealsScreenState();
}

class _CategoriesMealsScreenState extends State<CategoriesMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;
  var _loadedInitData = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if(!_loadedInitData) {
      final routeArgs =
      ModalRoute
          .of(context)
          .settings
          .arguments as Map<String, String>;
      final categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      displayedMeals = widget.availableMeals.where((meals) {
        return meals.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId){
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            imageUrl: displayedMeals[index].imageUrl,
            duration: displayedMeals[index].duration,
            complexity: displayedMeals[index].complexity,
            affordability: displayedMeals[index].affordability,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
