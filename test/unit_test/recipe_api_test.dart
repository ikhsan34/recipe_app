import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:recipe_app/models/api/recipe_api.dart';
import 'package:recipe_app/models/recipe_model.dart';
import 'package:recipe_app/screens/dashboard/recipe/services/recipe_firestore.dart';


void main() async {

  final firestore = FakeFirebaseFirestore();
  final RecipeFirestore recipeFirestore = RecipeFirestore(firestore: firestore, uid: 'uid-Testing');
  final RecipeModel recipe = RecipeModel(
      docId: null, 
      recipeId: '1', 
      name: 'Recipe Test', 
      imgUrl: 'Recipe Url', 
      calories: 1000, 
      ingredients: [
        const Ingredients(
          text: 'Ingredient Test', 
          quantity: 1, 
          measure: 'tbs', 
          food: 'Food Test', 
          weight: 2, 
          foodCategory: 'Category Test', 
          imgUrl: 'Img Url Test'
        )
      ], 
      recipeSource: 'Recipe Source', 
      sourceUrl: 'Recipe Source Url'
    );

  test('Search Recipe', () async {
    List<RecipeModel>? recipes = await RecipeApi.searchRecipes('chicken');
    expect(recipes != null, true);
  });

  test('Firestore Add Recipe', () async {
    final String result = await recipeFirestore.addRecipe(recipe: recipe);
    expect(result == 'success', true);
  });

  test('Firestore get savedRecipes', () async {
    List<RecipeModel> result = [];
    result = await recipeFirestore.savedRecipes;
    expect(result.isNotEmpty, true);
  });

}