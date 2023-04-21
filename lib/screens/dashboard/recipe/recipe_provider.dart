import 'package:flutter/cupertino.dart';
import 'package:recipe_app/models/api/recipe_api.dart';
import 'package:recipe_app/models/recipe_model.dart';

class RecipeProvider extends ChangeNotifier {

  List<RecipeModel> _recipes = [];

  List<RecipeModel> get recipes => _recipes;

  void searchRecipe() async {
    final result = await RecipeApi.searchRecipes('chicken');
    if (result != null) {
      _recipes = result;
      notifyListeners();
    }
  }
  
}