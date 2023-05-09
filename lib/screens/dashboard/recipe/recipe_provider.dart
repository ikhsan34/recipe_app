import 'package:cloud_firestore/cloud_firestore.dart';
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
    savedRecipes = await RecipeFirestore(firestore: FirebaseFirestore.instance, uid: user.uid).savedRecipes;
    setAPIState(APIState.none);
  }

  Future<bool> saveRecipe(RecipeModel recipe) async {
    setAPIState(APIState.loading);
    final User user = FirebaseAuth.instance.currentUser!;
    final String result = await RecipeFirestore(firestore: FirebaseFirestore.instance, uid: user.uid).addRecipe(recipe: recipe);
    if (result == 'success') {
      await getSavedRecipes();
      setAPIState(APIState.none);
      return true;
    }
    setAPIState(APIState.failed);
    return false;
  }
  Future<bool> deleteRecipe(RecipeModel recipe) async {
    setAPIState(APIState.loading);
    final User user = FirebaseAuth.instance.currentUser!;
    final String result = await RecipeFirestore(firestore: FirebaseFirestore.instance, uid: user.uid).deleteRecipe(docId: recipe.docId!);
    if (result == 'success') {
      savedRecipes.remove(recipe);
      setAPIState(APIState.none);
      return true;
    }
    setAPIState(APIState.failed);
    return false;
  }

  void disposeRecipe() {
    _recipes = [];
    savedRecipes = [];
  }

  void setAPIState(APIState state) {
    apiState = state;
    notifyListeners();
  }
  
}