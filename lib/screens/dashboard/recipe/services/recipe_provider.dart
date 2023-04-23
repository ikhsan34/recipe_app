import 'package:flutter/cupertino.dart';
import 'package:recipe_app/models/api/recipe_api.dart';
import 'package:recipe_app/models/recipe_model.dart';

enum APIState {
  none,
  loading,
  failed
}

class RecipeProvider extends ChangeNotifier {

  List<RecipeModel> _recipes = [];
  APIState apiState = APIState.none;

  List<RecipeModel> get recipes => _recipes;

  Future<void> searchRecipe(String keyword) async {
    setAPIState(APIState.loading);
    final result = await RecipeApi.searchRecipes(keyword);
    if (result != null) {
      _recipes = result;
      setAPIState(APIState.none);
    } else {
      _recipes = [];
      setAPIState(APIState.failed);
    }
  }

  void setAPIState(APIState state) {
    apiState = state;
    notifyListeners();
  }
  
}