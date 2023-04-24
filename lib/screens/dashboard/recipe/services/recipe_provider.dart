import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:recipe_app/models/api/recipe_api.dart';
import 'package:recipe_app/models/recipe_model.dart';
import 'package:recipe_app/screens/dashboard/recipe/services/recipe_firestore.dart';

enum APIState {
  none,
  loading,
  failed
}

class RecipeProvider extends ChangeNotifier {

  List<RecipeModel> _recipes = [];
  List<RecipeModel> savedRecipes = [];
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

  Future<void> getSavedRecipes() async {
    setAPIState(APIState.loading);
    final User user = FirebaseAuth.instance.currentUser!;
    savedRecipes = await RecipeFirestore(uid: user.uid).savedRecipes;
    setAPIState(APIState.none);
  }

  void setAPIState(APIState state) {
    apiState = state;
    notifyListeners();
  }
  
}