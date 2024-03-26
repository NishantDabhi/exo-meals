import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

import '../models/meal.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vagetarian: false,
  Filter.vegen: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMelas = [];
  Map<Filter, bool> _selectedFilters = kInitialFilters;

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message))
    );
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMelas.contains(meal);
    if(isExisting) {
      setState(() {
        _favoriteMelas.remove(meal);
      });
      _showInfoMessage('Meal is no longer Favorite.');
    } else {
      setState(() {
        _favoriteMelas.add(meal);
      });
      _showInfoMessage('Marked as Favorite!');
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if(identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(MaterialPageRoute(builder: (ctx) =>  FilterScreen(currentFilters: _selectedFilters,)));
      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(context) {

    final availableMeals = dummyMeals.where((meal) {
      if(_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) { //this line doesnt include glutenfree meal if meal.isGlutenFree returns false
        return false; // !meal.isGlutenFree means checking not glutenfree and [Flter.glutenFree]! mean it is glutenfree
        // so overoll whole line checks weather _selectedFlters is glutenfree or not and meal.isGlutenFree checks meal s not glutenfree than..
        // we will not include it and return false
      }
      if(_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if(_selectedFilters[Filter.vagetarian]! && !meal.isVegetarian) {
        return false;
      }
      if(_selectedFilters[Filter.vegen]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget activeScreen =  CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
      availableMeals: availableMeals);
    var  activePageTitle = 'Categories';

    if(_selectedPageIndex == 1) {
      activeScreen = MealsScreen(meals: _favoriteMelas, onToggleFavorite: _toggleMealFavoriteStatus,);
      activePageTitle = 'Favorites';
    }

    return Scaffold(
      drawer:  MainDrawer(onSelectScreen: _setScreen),
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: (index) {
          _selectPage(index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal_outlined), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites')
        ],
      ),
    );
  }
}